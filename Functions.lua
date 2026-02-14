local MUI = unpack(MagguuUI)

local format = format
local rad, deg, cos, sin, atan2 = math.rad, math.deg, math.cos, math.sin, math.atan2

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
        self:Print("|cffff4444Cannot run installer during combat.|r")

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
    if self:CloseSettings() then
        return
    end

    self:OpenSettings()
end

function MUI:RunInstaller()
    local I = MUI:GetModule("Installer")

    if InCombatLockdown() then
        MUI:Print("|cffff4444Cannot run installer during combat.|r")

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
    MUI:Print(format("Version: |cff4A8FD9%s|r", MUI.version or "unknown"))
end

function chatCommands.changelog()
    MUI:ShowChangelog()
end

function chatCommands.status()
    MUI:Print("|cff4A8FD9Addon Status:|r")

    local addons = {"ElvUI", "BigWigs", "Details", "Plater", "BetterCooldownManager"}

    for _, name in ipairs(addons) do
        if MUI:IsAddOnEnabled(name) then
            local installed = MUI.db.global.profiles and MUI.db.global.profiles[name]

            if installed then
                print(format("  |cff4A8FD9%s|r |cff00ff88Installed|r", name))
            else
                print(format("  |cffC0C8D4%s|r |cff999999Enabled, not installed|r", name))
            end
        else
            print(format("  |cff666666%s|r |cff666666Not enabled|r", name))
        end
    end
end

function MUI:HandleChatCommand(input)
    input = strtrim(input or "")
    local command = chatCommands[input]

    if not command then
        self:Print("|cff999999Available commands:|r")
        print("  |cff4A8FD9/mui|r |cffC0C8D4install|r    |cff999999- Toggle the installer|r")
        print("  |cff4A8FD9/mui|r |cffC0C8D4settings|r   |cff999999- Toggle settings panel|r")
        print("  |cff4A8FD9/mui|r |cffC0C8D4minimap|r    |cff999999- Toggle minimap button|r")
        print("  |cff4A8FD9/mui|r |cffC0C8D4version|r    |cff999999- Show addon version|r")
        print("  |cff4A8FD9/mui|r |cffC0C8D4status|r     |cff999999- Show installed profiles|r")
        print("  |cff4A8FD9/mui|r |cffC0C8D4changelog|r  |cff999999- Show changelog|r")

        return
    end

    command()
end

function MUI:LoadProfiles()
    if not self.db.global.profiles then
        self:Print("|cff999999No profiles to load.|r")

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
    btn:SetSize(32, 32)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)
    btn:SetMovable(true)
    btn:SetClampedToScreen(true)

    local angle = self.db.global.minimapAngle or 220
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
        end
    end)

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine(MUI.title)
        GameTooltip:AddLine("|cff4A8FD9Left-Click:|r Toggle Installer", 1, 1, 1)
        GameTooltip:AddLine("|cffC0C8D4Right-Click:|r Toggle Settings", 1, 1, 1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("|cff666666/mui for commands|r", 0.5, 0.5, 0.5)
        GameTooltip:Show()
    end)

    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    btn:RegisterForDrag("LeftButton")
    btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")

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
    local radius = 80
    local x = cos(r) * radius
    local y = sin(r) * radius

    btn:ClearAllPoints()
    btn:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function MUI:ToggleMinimapButton()
    if self.db.global.minimapButton == false then
        self.db.global.minimapButton = true
        if self.MinimapBtn then self.MinimapBtn:Show() end
        self:Print("Minimap button |cff00ff88enabled|r.")
    else
        self.db.global.minimapButton = false
        if self.MinimapBtn then self.MinimapBtn:Hide() end
        self:Print("Minimap button |cffff4444disabled|r.")
    end
end

function chatCommands.minimap()
    MUI:ToggleMinimapButton()
end
