local MUI = unpack(MagguuUI)

local ipairs, unpack = ipairs, unpack
local format = format
local strjoin = strjoin
local tostringall = tostringall

local DisableAddOn = C_AddOns.DisableAddOn
local EnableAddOn = C_AddOns.EnableAddOn
local GetNumAddOns = C_AddOns.GetNumAddOns
local GetAddOnInfo = C_AddOns.GetAddOnInfo

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
    POPUP_FRAME_LEVEL = 500,
    COPY_FEEDBACK_DELAY = 0.6,
    URL_FEEDBACK_DELAY = 0.5,
    PLATER_RELOAD_DELAY = 0.5,
    INSTALLER_HOOK_DELAY = 0.1,
    CHANGELOG_RESIZE_DELAY = 0.01,
}

-- ============================================================
-- Tiered Logging (inspired by WindTools)
-- Levels: 0 = off, 1 = errors only, 2 = warnings, 3 = info, 4 = debug
-- Controlled via self.db.global.logLevel (default 0)
-- ============================================================
MUI.LogLevel = {
    ERROR   = 1,
    WARNING = 2,
    INFO    = 3,
    DEBUG   = 4,
}

function MUI:GetLogLevel()
    return self.db and self.db.global and self.db.global.logLevel or 0
end

function MUI:SetLogLevel(level)
    if self.db and self.db.global then
        self.db.global.logLevel = level
    end
end

function MUI:LogError(...)
    if self:GetLogLevel() < self.LogLevel.ERROR then return end
    self:Print(format("|cffFF4444[ERROR]|r %s", strjoin(" ", tostringall(...))))
end

function MUI:LogWarning(...)
    if self:GetLogLevel() < self.LogLevel.WARNING then return end
    self:Print(format("|cffFFCC00[WARNING]|r %s", strjoin(" ", tostringall(...))))
end

function MUI:LogInfo(...)
    if self:GetLogLevel() < self.LogLevel.INFO then return end
    self:Print(format("|cff4A8FD9[INFO]|r %s", strjoin(" ", tostringall(...))))
end

function MUI:LogDebug(...)
    if self:GetLogLevel() < self.LogLevel.DEBUG then return end
    self:Print(format("|cff00D3BC[DEBUG]|r %s", strjoin(" ", tostringall(...))))
end

-- ============================================================
-- Version Code Helpers
-- ============================================================
function MUI:VersionCodeToString(code)
    local major = math.floor(code / 10000)
    local minor = math.floor((code % 10000) / 100)
    local patch = code % 100
    return format("%d.%d.%d", major, minor, patch)
end

function MUI:VersionStringToCode(str)
    if not str then return 0 end
    local clean = tostring(str):gsub("^v", "")
    local major, minor, patch = clean:match("^(%d+)%.(%d+)%.(%d+)$")
    if not major then return 0 end
    return tonumber(major) * 10000 + tonumber(minor) * 100 + tonumber(patch)
end

-- ============================================================
-- Centralized Addon Lists (single source of truth)
-- ============================================================
MUI.INSTALL_ORDER = {"ElvUI", "BetterCooldownManager", "Blizzard_EditMode", "Details", "Plater", "ClassCooldowns"}
MUI.STATUS_ADDONS = {"ElvUI", "BetterCooldownManager", "BigWigs", "Details", "Plater"}

-- Maps virtual addon names to their actual dependency for IsAddOnEnabled checks
MUI.ADDON_DEPENDENCY_MAP = {
    ClassCooldowns = "BetterCooldownManager",
}
MUI.SYSTEM_ADDONS = {"ElvUI", "ElvUI_WindTools", "ElvUI_Anchor", "BetterCooldownManager", "BigWigs", "Details", "Plater"}

-- ============================================================
-- Debug Mode: Whitelist of addons that stay enabled
-- ============================================================
MUI.DEBUG_WHITELIST = {
    ["ElvUI"] = true,
    ["ElvUI_Options"] = true,
    ["ElvUI_Libraries"] = true,
    ["MagguuUI"] = true,
    ["!BugGrabber"] = true,
    ["BugSack"] = true,
}

function MUI:IsDebugModeActive()
    return self.db and self.db.global and self.db.global.debugDisabledAddons and next(self.db.global.debugDisabledAddons) ~= nil
end

-- ============================================================
-- Database Migration (version-gated, runs once per version)
-- Each block runs only if upgrading from below that version code.
-- Pattern: if lastCode < 120005 then ... end
-- ============================================================
function MUI:DBConvert()
    local db = self.db.global

    -- Backward compat: convert old string-based lastDBConversion to version code
    local lastCode = db.lastDBConversionCode or 0

    if lastCode == 0 and db.lastDBConversion and db.lastDBConversion ~= "0" then
        lastCode = self:VersionStringToCode(db.lastDBConversion)
    end

    local currentCode = self:VersionStringToCode(self.version)

    if currentCode == 0 or lastCode >= currentCode then return end

    -- === v12.0.2: Migrate old minimap format to LibDBIcon ===
    if lastCode < 120002 then
        if db.minimapButton ~= nil or db.minimapAngle ~= nil then
            local wasHidden = db.minimapButton == false
            db.minimap = { hide = wasHidden }
            db.minimapButton = nil
            db.minimapAngle = nil
        end
    end

    -- === v12.0.9: Clean up old string-based lastDBConversion key ===
    if lastCode < 120009 then
        db.lastDBConversion = nil
    end

    -- === Future migrations go here: ===
    -- if lastCode < 120010 then
    --     -- migration code
    -- end

    db.lastDBConversionCode = currentCode
end

-- ============================================================
-- Popup Helpers
-- ============================================================
local C = MUI.Colors
local L = LibStub("AceLocale-3.0"):GetLocale("MagguuUI")

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
-- Debug Mode: Enable / Disable / Toggle
-- ============================================================
function MUI:EnableDebugMode()
    if self:IsDebugModeActive() then
        self:Print(format("|cff%s%s|r", C.HEX_DIM, L["DEBUG_ALREADY_ACTIVE"]))
        return
    end

    local charName = self.myname
    local disabled = {}
    local count = 0

    for i = 1, GetNumAddOns() do
        local name = GetAddOnInfo(i)

        if name and not self.DEBUG_WHITELIST[name] and self:IsAddOnEnabled(name) then
            DisableAddOn(name, charName)
            disabled[name] = true
            count = count + 1
        end
    end

    if count == 0 then return end

    if not self.db.global then return end
    self.db.global.debugDisabledAddons = disabled

    self:Print(format("|cff%s%s|r", C.HEX_YELLOW, format(L["DEBUG_ENABLED_COUNT"], count)))
    C_UI.Reload()
end

function MUI:DisableDebugMode()
    if not self:IsDebugModeActive() then
        self:Print(format("|cff%s%s|r", C.HEX_DIM, L["DEBUG_NOT_ACTIVE"]))
        return
    end

    local charName = self.myname
    local count = 0

    for name in pairs(self.db.global.debugDisabledAddons) do
        EnableAddOn(name, charName)
        count = count + 1
    end

    self.db.global.debugDisabledAddons = nil

    self:Print(format("|cff%s%s|r", C.HEX_GREEN, format(L["DEBUG_DISABLED_COUNT"], count)))
    C_UI.Reload()
end

function MUI:ToggleDebugMode()
    if self:IsDebugModeActive() then
        self:DisableDebugMode()
    else
        self:EnableDebugMode()
    end
end

-- ============================================================
-- Reload Popup (ReloadUI requires a hardware click event)
-- ============================================================
StaticPopupDialogs["MAGGUUI_RELOAD"] = CreatePopup({
    text = format("|cff%sMagguuUI|r\n\n|cff%s%s|r", C.HEX_BLUE, C.HEX_GREEN, L["RELOAD_TEXT"]),
    button1 = format("|cff%s%s|r", C.HEX_BLUE, L["RELOAD_BUTTON"]),
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
            local checkAddon = self.ADDON_DEPENDENCY_MAP[addon] or addon
            if self:IsAddOnEnabled(checkAddon) then
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
            local checkAddon = self.ADDON_DEPENDENCY_MAP[addon] or addon
            if self:IsAddOnEnabled(checkAddon) then
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
            self:Print(format("|cff%s%s|r", C.HEX_DIM, L["NO_SUPPORTED_ADDONS"]))
        end

        return
    end

    local index = 0
    local total = #queue
    local verb = install and L["INSTALLING"] or L["LOADING"]

    local function ProcessNext()
        index = index + 1

        if index > total then
            self.db.char.loaded = true

            if hasBigWigs then
                self:Print(format("|cff%s%s profile|r |cff%sBigWigs|r |cff%s(%d/%d)...|r", C.HEX_DIM, verb, C.HEX_BLUE, C.HEX_DIM, total + 1, total + 1))
                MUI._bigWigsReloadPending = true

                SE:Setup("BigWigs", true)
            else
                self:Print(format("|cff%s%s|r", C.HEX_GREEN, format(install and L["ALL_PROFILES_INSTALLED"] or L["ALL_PROFILES_LOADED"], total)))

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
    text = format("|cff%sMagguuUI|r\n\n|cff%s%s|r\n\n|cff%s%s|r", C.HEX_BLUE, C.HEX_DIM, L["NEW_CHAR_TEXT"], C.HEX_DARK, L["NEW_CHAR_APPLIED"]),
    button1 = format("|cff%s%s|r", C.HEX_BLUE, L["NEW_CHAR_LOAD_ALL"]),
    button2 = format("|cff%s%s|r", C.HEX_SILVER, L["NEW_CHAR_SKIP"]),
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

    -- Auto-open installer if no profiles installed (re-opens every login until installed)
    if not self.db.global.profiles and not InCombatLockdown() then
        C_Timer.After(MUI.Constants.FIRST_RUN_DELAY, function()
            if not InCombatLockdown() then
                MUI:RunInstaller()
            end
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

    -- Debug mode startup warning
    if self:IsDebugModeActive() then
        C_Timer.After(MUI.Constants.FIRST_RUN_DELAY, function()
            MUI:Print(format("|cff%s%s|r", C.HEX_YELLOW, L["DEBUG_STARTUP_WARNING"]))
        end)
    end

    -- Register combat queue replay: run queued setup calls when combat ends
    local SE = self:GetModule("Setup")
    SE:RegisterEvent("PLAYER_REGEN_ENABLED", "ReplayCombatQueue")
end
