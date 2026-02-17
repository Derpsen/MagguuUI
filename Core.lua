local MUI = unpack(MagguuUI)

local ipairs, unpack = ipairs, unpack
local format = format

local DisableAddOn = C_AddOns.DisableAddOn

MUI.title = "|cff4A8FD9Magguu|r|cffC0C8D4UI|r"
MUI.version = C_AddOns.GetAddOnMetadata("MagguuUI", "Version")
MUI.myname = UnitName("player")

-- ============================================================
-- Centralized Color Constants
-- ============================================================
MUI.Colors = {
    -- RGB (0-1) for textures and frames
    BLUE = {0.27, 0.54, 0.83},
    SILVER = {0.76, 0.80, 0.85},
    DARK_BG = {0.08, 0.11, 0.16},
    HOVER_BG = {0.14, 0.19, 0.28},
    ACTIVE_BG = {0.18, 0.24, 0.35},
    DIM = {0.45, 0.45, 0.50},
    POPUP_BG = {0.05, 0.05, 0.05},
    POPUP_BORDER = {0.12, 0.12, 0.12},
    EDITBOX_BG = {0.02, 0.02, 0.02},
    CONTENT_BG = {0.02, 0.02, 0.02},

    -- Hex strings for |cff...|r chat/text formatting
    HEX_BLUE = "4A8FD9",
    HEX_SILVER = "C0C8D4",
    HEX_GREEN = "00ff88",
    HEX_RED = "ff4444",
    HEX_SOFT_RED = "FF6666",
    HEX_YELLOW = "FFFF00",
    HEX_DIM = "999999",
    HEX_DARK = "666666",
    HEX_LIGHT = "cccccc",
    HEX_WHITE = "ffffff",
}

function MUI:ColorText(text, hexColor)
    return format("|cff%s%s|r", hexColor, text)
end

-- ============================================================
-- Named Constants (replace magic numbers)
-- ============================================================
MUI.Constants = {
    PROFILE_QUEUE_DELAY = 0.3,
    FIRST_RUN_DELAY = 2,
    UI_SETTLE_DELAY = 0.05,
    MINIMAP_RADIUS = 80,
    MINIMAP_DEFAULT_ANGLE = 220,
    MINIMAP_BUTTON_SIZE = 32,
}

-- ============================================================
-- Centralized Addon Lists (single source of truth)
-- ============================================================
MUI.INSTALL_ORDER = {"ElvUI", "BetterCooldownManager", "Blizzard_EditMode", "Details", "Plater", "ClassCooldowns"}
MUI.STATUS_ADDONS = {"ElvUI", "BetterCooldownManager", "BigWigs", "Details", "Plater"}
MUI.SYSTEM_ADDONS = {"ElvUI", "ElvUI_WindTools", "ElvUI_Anchor", "BetterCooldownManager", "BigWigs", "Details", "Plater"}

-- ============================================================
-- Popup Helpers
-- ============================================================
local C = MUI.Colors

local POPUP_DEFAULTS = {
    timeout = 0,
    whileDead = true,
    hideOnEscape = false,
    preferredIndex = 3,
    showAlert = true,
}

local function CreatePopup(specific)
    local popup = {}
    for k, v in pairs(POPUP_DEFAULTS) do popup[k] = v end
    for k, v in pairs(specific) do popup[k] = v end
    return popup
end

-- ============================================================
-- Reload Popup (ReloadUI requires a hardware click event)
-- ============================================================
StaticPopupDialogs["MAGGUUI_RELOAD"] = CreatePopup({
    text = format("|cff%sMagguuUI|r\n\n|cff%sAll profiles loaded successfully.|r\n|cff%sClick Reload to apply your settings.|r", C.HEX_BLUE, C.HEX_GREEN, C.HEX_DIM),
    button1 = format("|cff%sReload|r", C.HEX_BLUE),
    OnAccept = function()
        ReloadUI()
    end,
})

-- ============================================================
-- Shared Sequential Profile Queue
-- ============================================================
function MUI:ProcessProfileQueue(install, addonOrder)
    local SE = self:GetModule("Setup")

    local queue = {}
    local hasBigWigs = false

    if addonOrder then
        -- Fixed order (Install All)
        for _, addon in ipairs(addonOrder) do
            if self:IsAddOnEnabled(addon) then
                tinsert(queue, addon)
            end
        end

        if self:IsAddOnEnabled("BigWigs") then
            hasBigWigs = true
        end
    else
        -- Dynamic order from saved profiles (Load Profiles)
        if not self.db.global.profiles then
            self.db.char.loaded = true

            return
        end

        for addon in pairs(self.db.global.profiles) do
            if self:IsAddOnEnabled(addon) then
                if addon == "BigWigs" then
                    hasBigWigs = true
                else
                    tinsert(queue, addon)
                end
            end
        end
    end

    if #queue == 0 and not hasBigWigs then
        self.db.char.loaded = true

        if addonOrder then
            self:Print(format("|cff%sNo supported addons are enabled.|r", C.HEX_DIM))
        end

        return
    end

    local index = 0
    local total = #queue
    local verb = install and "Installing" or "Loading"

    local function ProcessNext()
        index = index + 1

        if index > total then
            self.db.char.loaded = true

            if hasBigWigs then
                self:Print(format("|cff%s%s profile|r |cff%sBigWigs|r |cff%s(%d/%d)...|r", C.HEX_DIM, verb, C.HEX_BLUE, C.HEX_DIM, total + 1, total + 1))
                MUI._bigWigsReloadPending = true

                SE:Setup("BigWigs", true)
            else
                self:Print(format("|cff%sAll %d profiles %s.|r", C.HEX_GREEN, total, install and "installed" or "loaded"))

                StaticPopup_Show("MAGGUUI_RELOAD")
            end

            return
        end

        local addon = queue[index]
        local displayTotal = hasBigWigs and (total + 1) or total
        self:Print(format("|cff%s%s profile|r |cff%s%s|r |cff%s(%d/%d)...|r", C.HEX_DIM, verb, C.HEX_BLUE, addon, C.HEX_DIM, index, displayTotal))
        SE:Setup(addon, install)

        C_Timer.After(MUI.Constants.PROFILE_QUEUE_DELAY, ProcessNext)
    end

    ProcessNext()
end

-- ============================================================
-- New Character Popup
-- ============================================================
StaticPopupDialogs["MAGGUUI_LOAD_NEW_CHAR"] = CreatePopup({
    text = format("|cff%sMagguuUI|r\n\n|cff%sProfiles have been installed on another character.\nWould you like to load all profiles onto this character?|r\n\n|cff%sProfiles will be applied one at a time.|r", C.HEX_BLUE, C.HEX_DIM, C.HEX_DARK),
    button1 = format("|cff%sLoad All Profiles|r", C.HEX_BLUE),
    button2 = format("|cff%sSkip|r", C.HEX_SILVER),
    OnAccept = function()
        MUI:ProcessProfileQueue(false)
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
})

function MUI:Initialize()
    local E
    local addons = {
        "MagguuUI_Installer",
        "NephUI",
        "NephUI Cooldown Manager",
        "SharedMedia_MagguuUI"
    }

    if self:IsAddOnEnabled("Details") and Details then
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
        C_Timer.After(MUI.Constants.FIRST_RUN_DELAY, function()
            MUI:RunInstaller()
        end)
    elseif self.db.global.profiles and not self.db.char.loaded and not InCombatLockdown() then
        -- New character with existing profiles: Show load popup
        C_Timer.After(MUI.Constants.FIRST_RUN_DELAY, function()
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
