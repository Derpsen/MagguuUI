local MUI = unpack(MagguuUI)

local format = format

local L = LibStub("AceLocale-3.0"):GetLocale("MagguuUI")
local C = MUI.Colors
local chatCommands = {}

function MUI.SetFrameStrata(frame, strata)
    frame:SetFrameStrata(strata)
end

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
        self.SetFrameStrata(PluginInstallFrame, "MEDIUM")
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
        C_Timer.After(0.1, function()
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
