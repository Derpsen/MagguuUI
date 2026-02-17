local MUI = unpack(MagguuUI)

local format = format
local rad, deg, cos, sin, atan2 = math.rad, math.deg, math.cos, math.sin, math.atan2

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
        self:Print(format("|cff%sCannot run installer during combat.|r", C.HEX_RED))

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
        MUI:Print(format("|cff%sCannot run installer during combat.|r", C.HEX_RED))

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
    MUI:Print(format("|cff%sAddon Status:|r", C.HEX_BLUE))

    local addons = MUI.STATUS_ADDONS

    for _, name in ipairs(addons) do
        if MUI:IsAddOnEnabled(name) then
            local installed = MUI.db.global.profiles and MUI.db.global.profiles[name]

            if installed then
                print(format("  |cff%s%s|r |cff%sInstalled|r", C.HEX_BLUE, name, C.HEX_GREEN))
            else
                print(format("  |cff%s%s|r |cff%sEnabled, not installed|r", C.HEX_SILVER, name, C.HEX_DIM))
            end
        else
            print(format("  |cff%s%s|r |cff%sNot enabled|r", C.HEX_DARK, name, C.HEX_DARK))
        end
    end
end

function MUI:HandleChatCommand(input)
    input = strtrim(input or "")
    local command = chatCommands[input]

    if not command then
        self:Print(format("|cff%sAvailable commands:|r", C.HEX_DIM))
        print(format("  |cff%s/mui|r |cff%sinstall|r    |cff%s- Toggle the installer|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM))
        print(format("  |cff%s/mui|r |cff%ssettings|r   |cff%s- Toggle settings panel|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM))
        print(format("  |cff%s/mui|r |cff%sminimap|r    |cff%s- Toggle minimap button|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM))
        print(format("  |cff%s/mui|r |cff%sversion|r    |cff%s- Show addon version|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM))
        print(format("  |cff%s/mui|r |cff%sstatus|r     |cff%s- Show installed profiles|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM))
        print(format("  |cff%s/mui|r |cff%schangelog|r  |cff%s- Show changelog|r", C.HEX_BLUE, C.HEX_SILVER, C.HEX_DIM))

        return
    end

    command()
end

function MUI:LoadProfiles()
    if not self.db.global.profiles then
        self:Print(format("|cff%sNo profiles to load.|r", C.HEX_DIM))

        return
    end

    self:ProcessProfileQueue(false)
end

-- ============================================================
-- Minimap Button
-- ============================================================
function MUI:CreateMinimapButton()
    if self.MinimapBtn then return end

    local btn = CreateFrame("Button", "MagguuUIMinimapButton", Minimap)
    btn:SetSize(MUI.Constants.MINIMAP_BUTTON_SIZE, MUI.Constants.MINIMAP_BUTTON_SIZE)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)
    btn:SetMovable(true)
    btn:SetClampedToScreen(true)

    local angle = self.db.global.minimapAngle or MUI.Constants.MINIMAP_DEFAULT_ANGLE
    self:UpdateMinimapPosition(btn, angle)

    local bg = btn:CreateTexture(nil, "BACKGROUND")
    bg:SetSize(24, 24)
    bg:SetPoint("CENTER")
    bg:SetTexture("Interface\\AddOns\\MagguuUI\\Media\\Textures\\MinimapButton")
    bg:SetTexCoord(0, 1, 0, 1)

    btn:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    local hl = btn:GetHighlightTexture()
    hl:SetSize(24, 24)
    hl:SetPoint("CENTER")
    hl:SetAlpha(0.15)

    btn:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            MUI:ToggleInstaller()
        elseif button == "RightButton" then
            MUI:ToggleSettings()
        elseif button == "MiddleButton" then
            MUI:ShowChangelog()
        end
    end)

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine(MUI.title)
        GameTooltip:AddLine(format("|cff%sLeft-Click:|r Toggle Installer", C.HEX_BLUE), 1, 1, 1)
        GameTooltip:AddLine(format("|cff%sRight-Click:|r Toggle Settings", C.HEX_SILVER), 1, 1, 1)
        GameTooltip:AddLine(format("|cff%sMiddle-Click:|r Toggle Changelog", C.HEX_DIM), 1, 1, 1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(format("|cff%s/mui for commands|r", C.HEX_DARK), 0.5, 0.5, 0.5)
        GameTooltip:Show()
    end)

    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    btn:RegisterForDrag("LeftButton")
    btn:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")

    btn:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function(self)
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            cx, cy = cx / scale, cy / scale

            local newAngle = deg(atan2(cy - my, cx - mx))
            MUI.db.global.minimapAngle = newAngle
            MUI:UpdateMinimapPosition(self, newAngle)
        end)
    end)

    btn:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)

    self.MinimapBtn = btn

    if self.db.global.minimapButton == false then
        btn:Hide()
    end
end

function MUI:UpdateMinimapPosition(btn, angle)
    local r = rad(angle)
    local radius = MUI.Constants.MINIMAP_RADIUS
    local x = cos(r) * radius
    local y = sin(r) * radius

    btn:ClearAllPoints()
    btn:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function MUI:ToggleMinimapButton()
    if self.db.global.minimapButton == false then
        self.db.global.minimapButton = true
        if self.MinimapBtn then self.MinimapBtn:Show() end
        self:Print(format("Minimap button |cff%senabled|r.", C.HEX_GREEN))
    else
        self.db.global.minimapButton = false
        if self.MinimapBtn then self.MinimapBtn:Hide() end
        self:Print(format("Minimap button |cff%sdisabled|r.", C.HEX_RED))
    end
end

function chatCommands.minimap()
    MUI:ToggleMinimapButton()
end
