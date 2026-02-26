local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format
local xpcall = xpcall
local C_EditMode, Enum = C_EditMode, Enum
local InCombatLockdown = InCombatLockdown
local C = MUI.Colors
local L = LibStub("AceLocale-3.0"):GetLocale("MagguuUI")

-- Combat queue: stores setup calls made during combat, replayed on PLAYER_REGEN_ENABLED
SE.combatQueue = {}

StaticPopupDialogs["MAGGUUI_OVERWRITE_PROFILE"] = {
    text = format(L["OVERWRITE_TEXT"], "%s"),
    button1 = L["OVERWRITE_BUTTON"],
    button2 = L["CANCEL"],
    OnAccept = function(self)
        if self.data and self.data.callback then
            self.data.callback()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function SE:Setup(addon, ...)
    local setup = self[addon]

    if not setup then
        MUI:Print(format("|cff%sNo setup handler for:|r |cff%s%s|r", C.HEX_DIM, C.HEX_BLUE, tostring(addon)))
        return
    end

    -- Queue setup calls made during combat (replayed on PLAYER_REGEN_ENABLED)
    if InCombatLockdown() then
        tinsert(SE.combatQueue, {addon, ...})
        MUI:LogWarning(format("Setup '%s' queued — in combat", addon))
        MUI:Print(format("|cff%s%s|r |cff%s%s|r |cff%s— queued until combat ends|r", C.HEX_BLUE, addon, C.HEX_DIM, L["COMBAT_ERROR"], C.HEX_DIM))
        return
    end

    MUI:LogDebug(format("Setup '%s' starting", addon))

    -- Protected call: a failed handler does not crash the profile queue
    local ok, err = xpcall(setup, function(e) return e end, addon, ...)

    if not ok then
        MUI:LogError(format("Setup '%s' failed: %s", addon, tostring(err)))
        MUI:Print(format("|cff%sSetup error|r |cff%s%s|r|cff%s:|r |cff%s%s|r", C.HEX_SOFT_RED, C.HEX_BLUE, tostring(addon), C.HEX_DIM, C.HEX_DIM, tostring(err)))
    else
        MUI:LogDebug(format("Setup '%s' completed", addon))
    end

    return ok
end

function SE:SetupWithConfirmation(addon, ...)
    local args = {...}

    if self:ProfileExistsForAddon(addon) then
        local dialog = StaticPopup_Show("MAGGUUI_OVERWRITE_PROFILE", addon)

        if dialog then
            dialog.data = {
                callback = function()
                    SE:Setup(addon, unpack(args))
                end
            }
        end
    else
        self:Setup(addon, unpack(args))
    end
end

function SE:ProfileExistsForAddon(addon)
    if addon == "ElvUI" then
        return MUI:IsAddOnEnabled("ElvUI") and self.IsProfileExisting(ElvDB)
    elseif addon == "Plater" then
        return MUI:IsAddOnEnabled("Plater") and self.IsProfileExisting(PlaterDB)
    elseif addon == "BigWigs" then
        return MUI:IsAddOnEnabled("BigWigs") and self.IsProfileExisting(BigWigs3DB)
    elseif addon == "Details" then
        if MUI:IsAddOnEnabled("Details") and Details then
            return Details:GetProfile("MagguuUI") ~= nil
        end
    elseif addon == "Blizzard_EditMode" then
        return SE.FindEditModeLayout() ~= nil
    elseif addon == "BetterCooldownManager" then
        return MUI:IsAddOnEnabled("BetterCooldownManager") and BCDMDB and self.IsProfileExisting(BCDMDB)
    elseif addon == "ClassCooldowns" then
        return SE.HasExistingClassLayouts and SE.HasExistingClassLayouts()
    end

    return false
end

function SE.CompleteSetup(addon)
    local PluginInstallStepComplete = PluginInstallStepComplete

    if PluginInstallStepComplete then
        if PluginInstallStepComplete:IsShown() then
            PluginInstallStepComplete:Hide()
        end

        PluginInstallStepComplete.message = L["SUCCESS"]

        PluginInstallStepComplete:Show()
    end

    if not MUI.db.global.profiles then
        MUI.db.global.profiles = {}
    end

    MUI.db.global.profiles[addon] = true
    MUI.db.char.loaded = true
    MUI.db.global.version = MUI.version
end

function SE.IsProfileExisting(svTable)
    if not svTable or not svTable.profiles then return false end

    return svTable.profiles["MagguuUI"] ~= nil
end

function SE.IsProfileActive(addon)
    if addon == "ElvUI" then
        if MUI:IsAddOnEnabled("ElvUI") and ElvDB and ElvDB.profileKeys then
            local key = MUI.myname .. " - " .. GetRealmName()
            return ElvDB.profileKeys[key] == "MagguuUI"
        end
    elseif addon == "BetterCooldownManager" then
        if MUI:IsAddOnEnabled("BetterCooldownManager") and BCDMDB and BCDMDB.profileKeys then
            local key = MUI.myname .. " - " .. GetRealmName()
            return BCDMDB.profileKeys[key] == "MagguuUI"
        end
    elseif addon == "BigWigs" then
        if MUI:IsAddOnEnabled("BigWigs") and BigWigs3DB and BigWigs3DB.profileKeys then
            local key = MUI.myname .. " - " .. GetRealmName()
            return BigWigs3DB.profileKeys[key] == "MagguuUI"
        end
    elseif addon == "Details" then
        if MUI:IsAddOnEnabled("Details") and Details then
            local current = Details.GetCurrentProfileName and Details:GetCurrentProfileName()
            return current == "MagguuUI"
        end
    elseif addon == "Plater" then
        if MUI:IsAddOnEnabled("Plater") and Plater and Plater.db then
            local profile = Plater.db.GetCurrentProfile and Plater.db:GetCurrentProfile()
            return profile == "MagguuUI"
        end
    elseif addon == "ClassCooldowns" then
        return SE.IsClassLayoutActive and SE.IsClassLayoutActive()
    end

    return false
end

function SE.RemoveFromDatabase(addon)
    if not MUI.db.global.profiles then return end

    MUI.db.global.profiles[addon] = nil

    if not next(MUI.db.global.profiles) then
        wipe(MUI.db.char)
        MUI.db.global.profiles = nil
    end
end

-- ============================================================
-- Combat Queue Replay (PLAYER_REGEN_ENABLED)
-- Replays setup calls that were queued during combat
-- ============================================================
function SE:ReplayCombatQueue()
    if #SE.combatQueue == 0 then return end

    MUI:Print(format("|cff%sReplaying %d queued setup(s)...|r", C.HEX_DIM, #SE.combatQueue))

    for _, entry in ipairs(SE.combatQueue) do
        local addon = entry[1]
        SE:Setup(addon, select(2, unpack(entry)))
    end

    wipe(SE.combatQueue)
end

-- ============================================================
-- Shared EditMode Layout Finder (used by Blizzard_EditMode + ClassLayouts)
-- Returns layout index or nil
-- ============================================================
function SE.FindEditModeLayout()
    if not C_EditMode then return nil end

    local layouts = C_EditMode.GetLayouts()

    for i, v in ipairs(layouts.layouts) do
        if v.layoutName == "MagguuUI" then
            return Enum.EditModePresetLayoutsMeta.NumValues + i
        end
    end

    return nil
end
