local MUI = unpack(MagguuUI)

local format = format
local ipairs = ipairs
local pairs = pairs
local tinsert = tinsert

-- ============================================================
-- Changelog Data (keyed by version code)
-- Version code = major * 10000 + minor * 100 + patch
-- ============================================================
MUI.Changelog = {}

MUI.Changelog[120010] = {
    RELEASE_DATE = "2026/02/26",
    NEW = {
        "Tiered logging system with 4 levels ([/mui log] to cycle)",
        "Diagnostic report generator ([/mui report] — copyable system info for support)",
        "[/mui load] command to load profiles on alt characters anytime",
        "ElvUI version check — warns if ElvUI is too old for current profiles",
        "Combat queue: profile installs during combat are queued and replayed automatically",
        "WindTools settings applied automatically during ElvUI profile import",
    },
    IMPROVEMENT = {
        "All setup handlers protected with [pcall] — one failed addon won't crash the queue",
        "LibDualSpec disabled before ElvUI profile switch (prevents profile conflicts)",
        "ElvUI installer auto-skipped when MagguuUI is installed (no double installer)",
        "Database migrations now version-gated (each migration runs exactly once)",
        "Nil guards after DecompressData in Details and Plater handlers",
        "Centralized helpers: [CreateBasePopup], [DBSet], [VersionStringToCode]",
        "Named constants for all magic numbers ([MUI.Constants])",
        "[IMPORTANT] changelog category added (red highlighting)",
    },
    BUGFIX = {
        "EditMode [ConvertStringToLayoutInfo] and [SaveLayouts] wrapped in pcall",
        "BCM import wrapped in pcall — corrupt profile data no longer causes UI errors",
    },
}

MUI.Changelog[120009] = {
    RELEASE_DATE = "2026/02/23",
    NEW = {
        "Debug mode: disables all non-essential addons for troubleshooting ([/mui debug])",
    },
    IMPROVEMENT = {
        "Debugger moved into [Information] tab (alongside About, Changelog, System)",
        "WowUp tab restructured with [Required] and [Optional] subtabs and HowTo section",
        "Class layout reinstall properly reindexes layout IDs after removal (no gaps)",
        "Core files reorganized into [Core/] and [Installer/] subfolders",
    },
    BUGFIX = {
        "SaveLayouts error on class layout reinstall now handled safely",
        "Updated ElvUI Anchor profile (addon was reset by author — reinstall required)",
    },
}

MUI.Changelog[120008] = {
    RELEASE_DATE = "2026/02/19",
    NEW = {
        "Class-specific BCM layouts integrated into [Install All] and [Load Profiles]",
        "Class and spec names shown in class colors on [Class Layouts] page",
    },
    IMPROVEMENT = {
        "Installer pages reformatted with cleaner multi-line descriptions",
        "[Class Layouts] replaces old layouts instead of duplicating on reinstall",
        "[STEP_LAYOUTS] renamed to [Class Layouts] in all 11 locales",
    },
    BUGFIX = {
        "[Load Profiles] now correctly checks addon dependencies for ClassCooldowns",
        "Replaced hardcoded hex color codes with [MUI.Colors.HEX_*] constants",
        "Fixed locale key for [Ignore] button",
    },
}

MUI.Changelog[120007] = {
    RELEASE_DATE = "2026/02/18",
    NEW = {
        "Localization support (9 languages) via [AceLocale-3.0]",
        "LibDataBroker minimap button (replaces custom implementation)",
        "Active profile status on installer pages (green/yellow/red)",
        "Reinstall warning on [Character Layouts] page",
    },
    IMPROVEMENT = {
        "All user-facing strings use locale keys instead of hardcoded text",
        "Minimap button now supports standard [LibDBIcon] dragging",
        "Profile status shown in [Settings] panel with color coding",
        "[Not installed] profiles now shown in red instead of gray",
        "Removed unused color constants and dead locale keys",
    },
    BUGFIX = {
        "BCM profile status always showed [Not installed] (wrong SavedVariable name)",
        "Duplicate [LOAD_PROFILES_DESC] locale key caused wrong text",
        "embeds.xml used [Include] instead of [Script] for .lua library files",
        "Settings title showed [vv12.0.x] instead of [v12.0.x]",
    },
}

MUI.Changelog[120006] = {
    RELEASE_DATE = "2026/02/15",
    IMPROVEMENT = {
        "Changelog [Got it!] opens installer automatically on version update",
    },
}

MUI.Changelog[120005] = {
    RELEASE_DATE = "2026/02/15",
    IMPROVEMENT = {
        "Installer detects version updates and requires [Install All] before [Load Profiles]",
        "Version strings with v-prefix handled correctly everywhere",
        "Updated addon profiles (ElvUI, Plater, Details, BCM, EditMode)",
    },
    BUGFIX = {
        "Changelog popup showed [vv12.0.4] instead of [v12.0.4]",
        "Changelog popup did not appear when upgrading from older versions",
    },
}

MUI.Changelog[120004] = {
    RELEASE_DATE = "2026/02/14",
    NEW = {
        "Tree layout with sub-tabs in ElvUI settings",
        "Minimap middle-click toggles Changelog popup",
        "Right-click opens ElvUI settings directly to MagguuUI section",
        "URL copy popup for Website and CurseForge links",
        "WowUp strings split into [Required] and [Optional]",
        "Changelog popup on version update",
        "Changelog tab in ElvUI settings with version dropdown and [I got it!] button",
    },
    IMPROVEMENT = {
        "All popups now match Installer design (ElvUI Transparent template)",
        "Settings restructured: Installer / Settings / Information with sub-tabs",
        "Scroll frames use fully relative anchoring (no hardcoded pixel offsets)",
        "Installer buttons: [Required] (red) / [Optional] (gray)",
        "Unified URL copy popup across all settings (shared between ElvUI and standalone)",
        "Standalone Blizzard settings hidden when ElvUI is active",
        "Config files restructured into Config/ folder",
    },
    BUGFIX = {
        "URL copy buttons in Settings now work reliably",
        "ElvUI config navigation via right-click",
        "Fixed changelog data format errors",
        "Fixed version comparison for changelog read status",
    },
}

MUI.Changelog[120003] = {
    RELEASE_DATE = "2026/02/09",
    IMPROVEMENT = {
        "Updated Blizzard EditMode profile string",
    },
}

MUI.Changelog[120002] = {
    RELEASE_DATE = "2026/02/09",
    NEW = {
        "ElvUI_Anchor as recommended dependency",
        "Version info in Settings",
        "Website link with copy popup",
        "Copy feedback — popups show [Copied!] and auto-close",
    },
    IMPROVEMENT = {
        "License to GPLv3",
        "Version scheme to 12.0.x",
    },
    BUGFIX = {
        "Removed broken Accept button from WowUp settings",
        "Website URL popup now works reliably",
    },
}

MUI.Changelog[120001] = {
    RELEASE_DATE = "2026/02/09",
    NEW = {
        "ElvUI WindTools as optional dependency",
        "Website link for class-specific BCM layouts",
    },
    BUGFIX = {
        "ElvUI download link corrected",
    },
}

MUI.Changelog[120000] = {
    RELEASE_DATE = "2026/02/08",
    NEW = {
        "One-click Install All",
        "Guided step-by-step installer",
        "Automatic profile loading for new characters",
        "WowUp import string",
        "Minimap button & Addon Compartment",
        "Chat commands: /mui install, settings, minimap, version, status",
    },
}

-- Strip leading "v" from version strings (CurseForge tags include it)
local function StripVersionPrefix(str)
    if not str then return str end
    return str:gsub("^v", "")
end

-- ============================================================
-- Use centralized colors
-- ============================================================
local C = MUI.Colors
local L = LibStub("AceLocale-3.0"):GetLocale("MagguuUI")

local CATEGORY_LABELS = {
    { key = "IMPORTANT",   label = "Important", color = C.HEX_RED },
    { key = "NEW",         label = "New",       color = C.HEX_GREEN },
    { key = "IMPROVEMENT", label = "Changed",   color = C.HEX_YELLOW },
    { key = "BUGFIX",      label = "Fixed",     color = C.HEX_SOFT_RED },
}

local function BuildChangelogText(fromVersionCode)
    local lines = {}

    -- Sort versions newest first
    local versions = {}
    for code in pairs(MUI.Changelog) do
        tinsert(versions, code)
    end
    table.sort(versions, function(a, b) return a > b end)

    for _, code in ipairs(versions) do
        local data = MUI.Changelog[code]
        local vStr = MUI:VersionCodeToString(code)

        -- Show all versions newer than lastSeen (or all if no fromVersionCode)
        if not fromVersionCode or code >= fromVersionCode then
            tinsert(lines, format("|cff%sv%s|r  |cff%s— %s|r", C.HEX_BLUE, vStr, C.HEX_DARK, data.RELEASE_DATE or ""))
            tinsert(lines, "")

            for _, cat in ipairs(CATEGORY_LABELS) do
                local entries = data[cat.key]
                if entries and #entries > 0 then
                    tinsert(lines, format("  |cff%s%s:|r", cat.color, cat.label))
                    for i, entry in ipairs(entries) do
                        tinsert(lines, format("    %02d. %s", i, entry))
                    end
                    tinsert(lines, "")
                end
            end

            tinsert(lines, "")
        end
    end

    return table.concat(lines, "\n")
end

-- Use centralized MUI:VersionStringToCode() from Core.lua
local VersionStringToCode = function(str) return MUI:VersionStringToCode(str) end

-- ============================================================
-- Changelog Popup
-- ============================================================
local function GetOrCreateChangelogPopup()
    if MUI.ChangelogPopup then return MUI.ChangelogPopup end

    local popup = MUI:CreateBasePopup("MagguuUIChangelogPopup", 520, 440)

    -- Logo
    local logo = popup:CreateTexture(nil, "ARTWORK")
    logo:SetSize(200, 100)
    logo:SetPoint("TOP", popup, "TOP", 0, -10)
    logo:SetTexture("Interface\\AddOns\\MagguuUI\\Media\\Textures\\LogoTop.tga")

    -- Title (below logo)
    local title = popup:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", logo, "BOTTOM", 0, -6)
    popup.title = title

    -- Subtitle
    local subtitle = popup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    subtitle:SetPoint("TOP", title, "BOTTOM", 0, -4)
    subtitle:SetPoint("LEFT", popup, "LEFT", 14, 0)
    subtitle:SetPoint("RIGHT", popup, "RIGHT", -14, 0)
    subtitle:SetText(format("|cff%s%s|r", C.HEX_DIM, L["WHATS_NEW"]))

    -- ScrollFrame (fully relative — anchored below subtitle with one line gap)
    local scrollFrame = CreateFrame("ScrollFrame", nil, popup, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -20)
    scrollFrame:SetPoint("BOTTOMRIGHT", popup, "BOTTOMRIGHT", -32, 50)

    MUI:CreatePopupScrollBackground(popup, scrollFrame)

    -- Content text
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetWidth(440)
    content:SetHeight(1)

    local text = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    text:SetPoint("TOPLEFT", content, "TOPLEFT", 8, -8)
    text:SetPoint("TOPRIGHT", content, "TOPRIGHT", -8, -8)
    text:SetJustifyH("LEFT")
    text:SetJustifyV("TOP")
    text:SetSpacing(3)

    scrollFrame:SetScrollChild(content)
    popup.content = content
    popup.text = text

    -- Close button (UIPanelButtonTemplate — ElvUI auto-skins)
    local closeBtn = CreateFrame("Button", nil, popup, "UIPanelButtonTemplate")
    closeBtn:SetSize(120, 26)
    closeBtn:SetPoint("BOTTOM", popup, "BOTTOM", 0, 14)
    closeBtn:SetText(L["GOT_IT"])
    closeBtn:SetScript("OnClick", function()
        popup:Hide()
        -- If this was an automatic update popup, open the installer
        if popup.isUpdatePopup then
            popup.isUpdatePopup = false
            MUI:ToggleInstaller()
        end
    end)

    MUI.ChangelogPopup = popup

    return popup
end

local function ShowChangelog(fromVersion, isAutoUpdate)
    local popup = GetOrCreateChangelogPopup()
    local version = MUI.version or "Unknown"

    popup.isUpdatePopup = isAutoUpdate or false
    popup.title:SetText(format("|cff%sMagguuUI|r |cff%sv%s|r", C.HEX_BLUE, C.HEX_SILVER, StripVersionPrefix(version)))

    local fromCode = VersionStringToCode(fromVersion)
    local changelogText = BuildChangelogText(fromCode > 0 and fromCode or nil)
    popup.text:SetText(changelogText)

    -- Resize content frame to fit text
    C_Timer.After(MUI.Constants.CHANGELOG_RESIZE_DELAY, function()
        local textHeight = popup.text:GetStringHeight() + 16
        popup.content:SetHeight(textHeight)
    end)

    popup:Show()
    popup:Raise()
end

-- ============================================================
-- Version Check on Login
-- ============================================================
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, isInitialLogin, isReloadingUi)
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")

    -- Wait a moment for UI to settle
    C_Timer.After(2, function()
        if not MUI.db or not MUI.db.global then return end

        local currentVersion = MUI.version
        local lastSeen = MUI.db.global.lastSeenVersion

        if not currentVersion then return end

        if not lastSeen then
            -- User upgraded from a version before this feature existed
            -- Check if they had the addon installed before (profiles or version exist)
            if MUI.db.global.profiles or MUI.db.global.version then
                ShowChangelog(MUI.db.global.version, true)
                MUI.db.global.lastSeenVersion = currentVersion
            else
                -- Truly first install, don't show popup
                MUI.db.global.lastSeenVersion = currentVersion
            end
            return
        end

        -- Show changelog if version changed
        if StripVersionPrefix(lastSeen) ~= StripVersionPrefix(currentVersion) then
            ShowChangelog(lastSeen, true)
            MUI.db.global.lastSeenVersion = currentVersion
        end
    end)
end)

-- ============================================================
-- Manual access via chat command or settings
-- ============================================================
function MUI:ShowChangelog()
    if MUI.ChangelogPopup and MUI.ChangelogPopup:IsShown() then
        MUI.ChangelogPopup:Hide()
        return
    end
    ShowChangelog(nil)
end
