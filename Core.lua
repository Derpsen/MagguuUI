local MUI = unpack(MagguuUI)

local ipairs, unpack = ipairs, unpack
local format = format

local DisableAddOn = C_AddOns.DisableAddOn

MUI.title = format("|cff4A8FD9Magguu|r|cffC0C8D4UI|r")
MUI.version = C_AddOns.GetAddOnMetadata("MagguuUI", "Version")
MUI.myname = UnitName("player")

-- ============================================================
-- Reload Popup (ReloadUI requires a hardware click event)
-- ============================================================
StaticPopupDialogs["MAGGUUI_RELOAD"] = {
    text = "|cff4A8FD9MagguuUI|r\n\n|cff00ff88All profiles loaded successfully.|r\n|cff999999Click Reload to apply your settings.|r",
    button1 = "|cff4A8FD9Reload|r",
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = false,
    preferredIndex = 3,
    showAlert = true,
}

-- ============================================================
-- Sequential Profile Loader
-- ============================================================
local function LoadProfilesSequential()
    local SE = MUI:GetModule("Setup")

    if not MUI.db.global.profiles then
        MUI.db.char.loaded = true

        return
    end

    -- Separate BigWigs from other addons (BigWigs must be last)
    local queue = {}
    local hasBigWigs = false

    for addon in pairs(MUI.db.global.profiles) do
        if MUI:IsAddOnEnabled(addon) then
            if addon == "BigWigs" then
                hasBigWigs = true
            else
                tinsert(queue, addon)
            end
        end
    end

    if #queue == 0 and not hasBigWigs then
        MUI.db.char.loaded = true

        return
    end

    local index = 0
    local total = #queue

    local function LoadNext()
        index = index + 1

        if index > total then
            MUI.db.char.loaded = true

            if hasBigWigs then
                MUI:Print(format("|cff999999Loading profile|r |cff4A8FD9BigWigs|r |cff999999(%d/%d)...|r", total + 1, total + 1))
                MUI._bigWigsReloadPending = true

                SE:Setup("BigWigs", true)
            else
                MUI:Print(format("|cff00ff88All %d profiles loaded.|r", total))

                StaticPopup_Show("MAGGUUI_RELOAD")
            end

            return
        end

        local addon = queue[index]
        local displayTotal = hasBigWigs and (total + 1) or total
        MUI:Print(format("|cff999999Loading profile|r |cff4A8FD9%s|r |cff999999(%d/%d)...|r", addon, index, displayTotal))
        SE:Setup(addon)

        C_Timer.After(0.3, LoadNext)
    end

    LoadNext()
end

-- ============================================================
-- New Character Popup
-- ============================================================
StaticPopupDialogs["MAGGUUI_LOAD_NEW_CHAR"] = {
    text = "|cff4A8FD9MagguuUI|r\n\n|cff999999Profiles have been installed on another character.\nWould you like to load all profiles onto this character?|r\n\n|cff666666Profiles will be applied one at a time.|r",
    button1 = "|cff4A8FD9Load All Profiles|r",
    button2 = "|cffC0C8D4Skip|r",
    OnAccept = function()
        LoadProfilesSequential()
    end,
    OnCancel = function()
        MUI.db.char.loaded = true

        -- Open installer so they can pick individually
        C_Timer.After(0.5, function()
            if not InCombatLockdown() then
                MUI:RunInstaller()
            end
        end)
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = false,
    preferredIndex = 3,
    showAlert = true,
}

function MUI:Initialize()
    local Details = Details
    local E
    local addons = {
        "MagguuUI_Installer",
        "NephUI",
        "NephUI Cooldown Manager",
        "SharedMedia_MagguuUI"
    }

    if self:IsAddOnEnabled("Details") then
        if Details.is_first_run and #Details.custom == 0 then
            Details:AddDefaultCustomDisplays()
        end

        Details.character_first_run = false
        Details.is_first_run = false
        Details.is_version_first_run = false
    end

    if self:IsAddOnEnabled("ElvUI") then
        E = unpack(ElvUI)

        if E.InstallFrame and E.InstallFrame:IsShown() then
            E.InstallFrame:Hide()

            E.private.install_complete = E.version
        end

        E.global.ignoreIncompatible = true
    end

    -- First run: Auto-open installer
    if not self.db.global.firstRun and not InCombatLockdown() then
        self.db.global.firstRun = true
        C_Timer.After(2, function()
            MUI:RunInstaller()
        end)
    elseif self.db.global.profiles and not self.db.char.loaded and not InCombatLockdown() then
        -- New character with existing profiles: Show load popup
        C_Timer.After(2, function()
            if not InCombatLockdown() then
                StaticPopup_Show("MAGGUUI_LOAD_NEW_CHAR")
            end
        end)
    end

    for _, v in ipairs(addons) do
        if self:IsAddOnEnabled(v) then
            DisableAddOn(v)
        end
    end
end
