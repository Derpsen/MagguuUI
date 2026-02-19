local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format
local C = MUI.Colors
local L = LibStub("AceLocale-3.0"):GetLocale("MagguuUI")

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

    return setup(addon, ...)
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
        if C_EditMode then
            local layouts = C_EditMode.GetLayouts()

            for _, v in ipairs(layouts.layouts) do
                if v.layoutName == "MagguuUI" then
                    return true
                end
            end
        end
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
