local MUI = unpack(MagguuUI)

local format = format

local L = LibStub("AceLocale-3.0"):GetLocale("MagguuUI")
local C = MUI.Colors
local chatCommands = {}

function MUI:IsInstallerShown()
    return PluginInstallFrame and PluginInstallFrame:IsShown()
end

function MUI:IsSettingsShown()
    return SettingsPanel and SettingsPanel:IsShown()
end

function MUI:CloseSettings()
    if self:IsSettingsShown() then
        HideUIPanel(SettingsPanel)

        return true
    end

    return false
end

function MUI:OpenSettings()
    if self:IsInstallerShown() then
        PluginInstallFrame:SetFrameStrata("MEDIUM")
    end

    Settings.OpenToCategory(self.category)
end

function MUI:ToggleInstaller()
    if InCombatLockdown() then
        self:Print(format("|cff%s%s|r", C.HEX_RED, L["COMBAT_ERROR"]))

        return
    end

    if self:IsInstallerShown() then
        -- Properly close: wipe ElvUI's install queue so re-queue works cleanly
        if self:IsAddOnEnabled("ElvUI") then
            local E = unpack(ElvUI)
            local PI = E:GetModule("PluginInstaller")

            wipe(PI.Installs)
        end

        PluginInstallFrame:Hide()

        return
    end

    self:RunInstaller()
end

function MUI:ToggleSettings()
    if self:IsAddOnEnabled("ElvUI") then
        local E = unpack(ElvUI)
        E:ToggleOptions("magguuui")
        return
    end

    if self:CloseSettings() then
        return
    end

    self:OpenSettings()
end

function MUI:RunInstaller()
    local I = MUI:GetModule("Installer")

    if InCombatLockdown() then
        MUI:Print(format("|cff%s%s|r", C.HEX_RED, L["COMBAT_ERROR"]))

        return
    end

    if self:IsAddOnEnabled("ElvUI") then
        local E = unpack(ElvUI)
        local PI = E:GetModule("PluginInstaller")

        PI:Queue(I.installer)

        -- Apply custom styling after frame is created
        C_Timer.After(MUI.Constants.INSTALLER_HOOK_DELAY, function()
            I:HookInstaller()
        end)

        return
    end

    self:OpenSettings()
end

function chatCommands.install()
    MUI:ToggleInstaller()
end

function chatCommands.settings()
    MUI:ToggleSettings()
end

function chatCommands.version()
    MUI:Print(format("Version: |cff%s%s|r", C.HEX_BLUE, MUI.version or "unknown"))
end

function chatCommands.changelog()
    MUI:ShowChangelog()
end

function chatCommands.status()
    MUI:Print(format("|cff%s%s|r", C.HEX_BLUE, L["ADDON_STATUS"]))

    local addons = MUI.STATUS_ADDONS

    for _, name in ipairs(addons) do
        if MUI:IsAddOnEnabled(name) then
            local installed = MUI.db.global.profiles and MUI.db.global.profiles[name]

            if installed then
                print(format("  |cff%s%s|r |cff%s%s|r", C.HEX_BLUE, name, C.HEX_GREEN, L["STATUS_INSTALLED"]))
            else
                print(format("  |cff%s%s|r |cff%s%s|r", C.HEX_SILVER, name, C.HEX_DIM, L["STATUS_ENABLED_NOT_INSTALLED"]))
            end
        else
            print(format("  |cff%s%s|r |cff%s%s|r", C.HEX_DARK, name, C.HEX_DARK, L["STATUS_NOT_ENABLED"]))
        end
    end
end

function MUI:HandleChatCommand(input)
    input = strtrim(input or "")
    local command = chatCommands[input]

    if not command then
        self:Print(format("|cff%s%s|r", C.HEX_DIM, L["AVAILABLE_COMMANDS"]))
        print(format("  |cff%s/mui|r |cff%sinstall|r    |cff%s- %s|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM, L["CMD_INSTALL"]))
        print(format("  |cff%s/mui|r |cff%ssettings|r   |cff%s- %s|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM, L["CMD_SETTINGS"]))
        print(format("  |cff%s/mui|r |cff%sminimap|r    |cff%s- %s|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM, L["CMD_MINIMAP"]))
        print(format("  |cff%s/mui|r |cff%sversion|r    |cff%s- %s|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM, L["CMD_VERSION"]))
        print(format("  |cff%s/mui|r |cff%sstatus|r     |cff%s- %s|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM, L["CMD_STATUS"]))
        print(format("  |cff%s/mui|r |cff%schangelog|r  |cff%s- %s|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM, L["CMD_CHANGELOG"]))
        print(format("  |cff%s/mui|r |cff%sdebug|r      |cff%s- %s|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM, L["CMD_DEBUG"]))
        print(format("  |cff%s/mui|r |cff%slog|r        |cff%s- Cycle log level (off > error > warning > info > debug)|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM))
        print(format("  |cff%s/mui|r |cff%sreport|r     |cff%s- Generate copyable diagnostic report|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM))

        return
    end

    command()
end

function MUI:LoadProfiles()
    if not self.db.global.profiles then
        self:Print(format("|cff%s%s|r", C.HEX_DIM, L["NO_PROFILES_TO_LOAD"]))

        return
    end

    self:ProcessProfileQueue(false)
end

-- ============================================================
-- Minimap Button (LibDataBroker + LibDBIcon)
-- ============================================================
function MUI:CreateMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1")
    local LDBI = LibStub("LibDBIcon-1.0")

    if not self.db.global.minimap then
        self.db.global.minimap = { hide = false }
    end

    local dataObj = LDB:NewDataObject("MagguuUI", {
        type = "launcher",
        text = "MagguuUI",
        icon = "Interface\\AddOns\\MagguuUI\\Media\\Textures\\MinimapButton",
        OnClick = function(_, button)
            if button == "LeftButton" then
                MUI:ToggleInstaller()
            elseif button == "RightButton" then
                MUI:ToggleSettings()
            elseif button == "MiddleButton" then
                MUI:ShowChangelog()
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine(MUI.title)
            tooltip:AddLine(format("|cff%sLeft-Click:|r %s", C.HEX_BLUE, L["LEFT_CLICK"]), 1, 1, 1)
            tooltip:AddLine(format("|cff%sRight-Click:|r %s", C.HEX_SILVER, L["RIGHT_CLICK"]), 1, 1, 1)
            tooltip:AddLine(format("|cff%sMiddle-Click:|r %s", C.HEX_DIM, L["MIDDLE_CLICK"]), 1, 1, 1)
            tooltip:AddLine(" ")
            tooltip:AddLine(format("|cff%s/mui|r", C.HEX_DARK), 0.5, 0.5, 0.5)
        end,
    })

    LDBI:Register("MagguuUI", dataObj, self.db.global.minimap)
end

function MUI:ToggleMinimapButton()
    local LDBI = LibStub("LibDBIcon-1.0")

    if not self.db.global.minimap then
        self.db.global.minimap = { hide = false }
    end

    if self.db.global.minimap.hide then
        self.db.global.minimap.hide = false
        LDBI:Show("MagguuUI")
        self:Print(L["MINIMAP_ENABLED"])
    else
        self.db.global.minimap.hide = true
        LDBI:Hide("MagguuUI")
        self:Print(L["MINIMAP_DISABLED"])
    end
end

function chatCommands.minimap()
    MUI:ToggleMinimapButton()
end

function chatCommands.debug()
    MUI:ToggleDebugMode()
end

function chatCommands.log()
    local current = MUI:GetLogLevel()

    if current >= MUI.LogLevel.DEBUG then
        MUI:SetLogLevel(0)
        MUI:Print(format("|cff%sLog level:|r |cff%sOFF|r", C.HEX_DIM, C.HEX_RED))
    else
        local newLevel = current + 1
        local names = {[1] = "ERROR", [2] = "WARNING", [3] = "INFO", [4] = "DEBUG"}
        local colors = {[1] = C.HEX_RED, [2] = C.HEX_YELLOW, [3] = C.HEX_BLUE, [4] = "00D3BC"}

        MUI:SetLogLevel(newLevel)
        MUI:Print(format("|cff%sLog level:|r |cff%s%s|r", C.HEX_DIM, colors[newLevel], names[newLevel]))
    end
end

-- ============================================================
-- Diagnostic Report (inspired by BenikUI)
-- Generates a copyable string with system info for support
-- ============================================================
function chatCommands.report()
    MUI:ShowReport()
end

function MUI:BuildReport()
    local lines = {}
    local SE = self:GetModule("Setup")

    tinsert(lines, "== MagguuUI Report ==")
    tinsert(lines, format("MagguuUI: %s", self.version or "?"))

    -- ElvUI version
    if self:IsAddOnEnabled("ElvUI") then
        local E = unpack(ElvUI)
        tinsert(lines, format("ElvUI: %s", E.version or "?"))
    else
        tinsert(lines, "ElvUI: not loaded")
    end

    -- WoW version
    local wowVersion, wowBuild, _, tocVersion = GetBuildInfo()
    tinsert(lines, format("WoW: %s (build %s, toc %s)", wowVersion or "?", wowBuild or "?", tostring(tocVersion or "?")))

    -- Resolution & Scale
    local resX, resY = GetPhysicalScreenSize()
    tinsert(lines, format("Resolution: %dx%d", resX or 0, resY or 0))
    tinsert(lines, format("UI Scale: %.4f", UIParent:GetEffectiveScale()))

    -- Installed profiles
    tinsert(lines, "")
    tinsert(lines, "-- Profiles --")

    local allAddons = {"ElvUI", "BetterCooldownManager", "BigWigs", "Details", "Plater", "Blizzard_EditMode", "ClassCooldowns"}

    for _, name in ipairs(allAddons) do
        local checkAddon = self.ADDON_DEPENDENCY_MAP and self.ADDON_DEPENDENCY_MAP[name] or name
        local enabled = self:IsAddOnEnabled(checkAddon)
        local installed = self.db.global.profiles and self.db.global.profiles[name]
        local active = enabled and SE.IsProfileActive and SE.IsProfileActive(name)

        local status
        if not enabled then
            status = "not loaded"
        elseif active then
            status = "active"
        elseif installed then
            status = "installed"
        else
            status = "enabled, not installed"
        end

        tinsert(lines, format("  %s: %s", name, status))
    end

    -- Optional addons
    tinsert(lines, "")
    tinsert(lines, "-- Optional Addons --")

    local optionals = {"ElvUI_WindTools", "ElvUI_Anchor"}

    for _, name in ipairs(optionals) do
        local ver = C_AddOns.DoesAddOnExist(name) and (C_AddOns.GetAddOnMetadata(name, "Version") or "?") or nil

        if ver then
            tinsert(lines, format("  %s: %s", name, ver))
        end
    end

    -- Debug state
    tinsert(lines, "")
    tinsert(lines, format("Debug Mode: %s", self:IsDebugModeActive() and "ON" or "off"))
    tinsert(lines, format("Log Level: %d", self:GetLogLevel()))
    tinsert(lines, format("Char Loaded: %s", tostring(self.db.char.loaded or false)))

    return table.concat(lines, "\n")
end

function MUI:ShowReport()
    local report = self:BuildReport()

    -- Create or reuse a simple popup with an editbox for copy
    if not MagguuUI_ReportFrame then
        local popup = self:CreateBasePopup("MagguuUI_ReportFrame", 450, 350)

        local title = popup:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOP", 0, -12)
        title:SetText(format("|cff%sMagguuUI Report|r", C.HEX_BLUE))
        popup.title = title

        local editBox = CreateFrame("EditBox", nil, popup, "InputBoxTemplate")
        editBox:SetMultiLine(true)
        editBox:SetAutoFocus(false)
        editBox:SetFontObject(GameFontHighlightSmall)
        editBox:SetPoint("TOPLEFT", 16, -40)
        editBox:SetPoint("BOTTOMRIGHT", -16, 40)
        editBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
        editBox:SetScript("OnTextChanged", function(self)
            -- Prevent editing: reset to report text
            if self.reportText and self:GetText() ~= self.reportText then
                self:SetText(self.reportText)
            end
            self:HighlightText()
        end)
        popup.editBox = editBox

        local hint = popup:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        hint:SetPoint("BOTTOM", 0, 14)
        hint:SetText(format("|cff%sCtrl+A to select all, Ctrl+C to copy|r", C.HEX_DIM))
    end

    local frame = MagguuUI_ReportFrame
    frame.editBox.reportText = report
    frame.editBox:SetText(report)
    frame:Show()

    C_Timer.After(0.1, function()
        frame.editBox:SetFocus()
        frame.editBox:HighlightText()
    end)
end

-- ============================================================
-- Safe DB Setter (inspired by LuckyoneUI)
-- Sets a nested value via dot-separated path. Silently skips
-- if any intermediate key is missing or not a table.
-- Usage: MUI:DBSet(E.private, "WT.skins.shadow", false)
-- ============================================================
function MUI:DBSet(tbl, path, value)
    if not tbl or type(tbl) ~= "table" then return end

    local keys = {}
    for key in path:gmatch("([^.]+)") do
        tinsert(keys, key)
    end

    if #keys == 0 then return end

    local current = tbl

    for i = 1, #keys - 1 do
        local key = keys[i]

        if current[key] == nil then
            current[key] = {}
        elseif type(current[key]) ~= "table" then
            return -- path invalid, skip silently
        end

        current = current[key]
    end

    local finalKey = keys[#keys]

    if current and type(current) == "table" then
        current[finalKey] = value
    end
end

-- ============================================================
-- Shared WowUp HowTo Text Builder
-- ============================================================
function MUI:BuildWowUpHowToText(buttonText, buttonColor)
    return format("|cff%s", C.HEX_DIM)
        .. format("1. Click |cff%s%s|r |cff%sbelow|r\n", buttonColor, buttonText, C.HEX_DIM)
        .. format("|cff%s2. The string is selected — press|r |cff%sCtrl+C|r |cff%sto copy|r\n", C.HEX_DIM, C.HEX_SILVER, C.HEX_DIM)
        .. format("|cff%s3. Open|r |cff%sWowUp|r |cff%s> More > Import/Export Addons|r\n", C.HEX_DIM, C.HEX_BLUE, C.HEX_DIM)
        .. format("|cff%s4. Switch to|r |cff%sImport|r|cff%s, paste, click|r |cff%sInstall|r\n", C.HEX_DIM, C.HEX_SILVER, C.HEX_DIM, C.HEX_BLUE)
end

-- ============================================================
-- Base Popup Frame Factory (shared by WowUp, URL, Changelog)
-- ============================================================
function MUI:CreateBasePopup(name, width, height)
    local popup = CreateFrame("Frame", name, UIParent, "BackdropTemplate")
    popup:SetSize(width, height)
    popup:SetPoint("CENTER")
    popup:SetFrameStrata("TOOLTIP")
    popup:SetFrameLevel(self.Constants.POPUP_FRAME_LEVEL)
    popup:SetMovable(true)
    popup:EnableMouse(true)
    popup:RegisterForDrag("LeftButton")
    popup:SetScript("OnDragStart", popup.StartMoving)
    popup:SetScript("OnDragStop", popup.StopMovingOrSizing)

    if popup.SetTemplate then
        popup:SetTemplate("Transparent")
    else
        popup:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
        })
        popup:SetBackdropColor(C.POPUP_BG[1], C.POPUP_BG[2], C.POPUP_BG[3], 0.95)
        popup:SetBackdropBorderColor(C.POPUP_BORDER[1], C.POPUP_BORDER[2], C.POPUP_BORDER[3], 1)
    end

    tinsert(UISpecialFrames, name)
    popup:Hide()

    return popup
end

-- Shared scroll background for popup scroll frames
function MUI:CreatePopupScrollBackground(popup, scrollFrame)
    local sfBg = CreateFrame("Frame", nil, popup, "BackdropTemplate")
    sfBg:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", -4, 4)
    sfBg:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 20, -4)

    if sfBg.SetTemplate then
        sfBg:SetTemplate("Transparent")
    else
        sfBg:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
        })
        sfBg:SetBackdropColor(C.CONTENT_BG[1], C.CONTENT_BG[2], C.CONTENT_BG[3], 0.6)
        sfBg:SetBackdropBorderColor(C.POPUP_BORDER[1], C.POPUP_BORDER[2], C.POPUP_BORDER[3], 1)
    end

    sfBg:SetFrameLevel(popup:GetFrameLevel() + 1)
    scrollFrame:SetFrameLevel(sfBg:GetFrameLevel() + 1)

    return sfBg
end
