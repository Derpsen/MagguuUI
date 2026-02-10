local MUI = unpack(MagguuUI)
local I = MUI:GetModule("Installer")
local SE = MUI:GetModule("Setup")
local D = MUI:GetModule("Data")

-- Color constants
local BLUE = {0.27, 0.54, 0.83}
local SILVER = {0.76, 0.80, 0.85}
local DARK_BG = {0.08, 0.11, 0.16}
local HOVER_BG = {0.14, 0.19, 0.28}
local ACTIVE_BG = {0.18, 0.24, 0.35}
local DIM = {0.45, 0.45, 0.50}

-- Installer-matched black (ElvUI installer uses near-black)
local POPUP_BG = {0.05, 0.05, 0.05}
local POPUP_BORDER = {0.12, 0.12, 0.12}
local EDITBOX_BG = {0.02, 0.02, 0.02}

-- ============================================================
-- Install All Profiles (fresh install, sequential)
-- ============================================================
local function InstallAllProfiles()
    local SE = MUI:GetModule("Setup")

    -- BigWigs must be last (its popup requires user interaction)
    local addonOrder = {"ElvUI", "BetterCooldownManager", "Blizzard_EditMode", "Details", "Plater"}
    local queue = {}
    local hasBigWigs = false

    for _, addon in ipairs(addonOrder) do
        if MUI:IsAddOnEnabled(addon) then
            tinsert(queue, addon)
        end
    end

    if MUI:IsAddOnEnabled("BigWigs") then
        hasBigWigs = true
    end

    if #queue == 0 and not hasBigWigs then
        MUI:Print("|cff999999No supported addons are enabled.|r")

        return
    end

    local index = 0
    local total = #queue

    local function InstallNext()
        index = index + 1

        if index > total then
            -- All non-BigWigs addons done
            if hasBigWigs then
                MUI:Print(format("|cff999999Installing profile|r |cff4A8FD9BigWigs|r |cff999999(%d/%d)...|r", total + 1, total + 1))
                MUI._bigWigsReloadPending = true

                SE:Setup("BigWigs", true)
                -- Reload popup will be shown by BigWigs callback
            else
                MUI:Print(format("|cff00ff88All %d profiles installed.|r", total))

                StaticPopup_Show("MAGGUUI_RELOAD")
            end

            return
        end

        local addon = queue[index]
        local displayTotal = hasBigWigs and (total + 1) or total
        MUI:Print(format("|cff999999Installing profile|r |cff4A8FD9%s|r |cff999999(%d/%d)...|r", addon, index, displayTotal))
        SE:Setup(addon, true)

        C_Timer.After(0.3, InstallNext)
    end

    InstallNext()
end

-- ============================================================
-- WowUp Copy Popup (reusable for Required + Optional)
-- ============================================================
local function GetOrCreateWowUpPopup()
    if MUI.WowUpPopup then return MUI.WowUpPopup end

    local popup = CreateFrame("Frame", "MagguuUIWowUpPopup", UIParent, "BackdropTemplate")
    popup:SetSize(520, 280)
    popup:SetPoint("CENTER")
    popup:SetFrameStrata("TOOLTIP")
    popup:SetFrameLevel(500)
    popup:SetMovable(true)
    popup:EnableMouse(true)
    popup:RegisterForDrag("LeftButton")
    popup:SetScript("OnDragStart", popup.StartMoving)
    popup:SetScript("OnDragStop", popup.StopMovingOrSizing)

    popup:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    popup:SetBackdropColor(POPUP_BG[1], POPUP_BG[2], POPUP_BG[3], 0.98)
    popup:SetBackdropBorderColor(POPUP_BORDER[1], POPUP_BORDER[2], POPUP_BORDER[3], 1)

    -- Accent line top
    local accent = popup:CreateTexture(nil, "OVERLAY")
    accent:SetHeight(2)
    accent:SetPoint("TOPLEFT", popup, "TOPLEFT", 0, 0)
    accent:SetPoint("TOPRIGHT", popup, "TOPRIGHT", 0, 0)
    accent:SetColorTexture(BLUE[1], BLUE[2], BLUE[3], 1)

    -- Title (dynamic)
    local title = popup:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", popup, "TOP", 0, -16)
    popup.title = title

    -- Description
    local desc = popup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    desc:SetPoint("TOP", title, "BOTTOM", 0, -8)
    desc:SetText("|cff999999Click the text below to select all, then press|r |cffC0C8D4Ctrl+C|r |cff999999to copy|r")
    popup.desc = desc

    -- ScrollFrame + EditBox
    local scrollFrame = CreateFrame("ScrollFrame", nil, popup, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", popup, "TOPLEFT", 14, -64)
    scrollFrame:SetPoint("BOTTOMRIGHT", popup, "BOTTOMRIGHT", -32, 50)

    -- Scrollframe backdrop
    local sfBg = CreateFrame("Frame", nil, popup, "BackdropTemplate")
    sfBg:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", -4, 4)
    sfBg:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 20, -4)
    sfBg:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    sfBg:SetBackdropColor(EDITBOX_BG[1], EDITBOX_BG[2], EDITBOX_BG[3], 1)
    sfBg:SetBackdropBorderColor(POPUP_BORDER[1], POPUP_BORDER[2], POPUP_BORDER[3], 1)
    sfBg:SetFrameLevel(popup:GetFrameLevel() + 1)
    scrollFrame:SetFrameLevel(sfBg:GetFrameLevel() + 1)

    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetAutoFocus(false)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetWidth(scrollFrame:GetWidth() - 10)
    editBox:SetTextInsets(6, 6, 4, 4)

    editBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    editBox:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)

    -- Read-only
    editBox:SetScript("OnChar", function(self)
        self:SetText(self._muiText or "")
        self:HighlightText()
    end)
    editBox:SetScript("OnTextChanged", function(self, userInput)
        if userInput then
            self:SetText(self._muiText or "")
            self:HighlightText()
        end
    end)

    -- Detect Ctrl+C → show feedback → auto-close
    editBox:SetScript("OnKeyDown", function(self, key)
        if key == "C" and IsControlKeyDown() then
            desc:SetText("|cff00ff88Copied!|r")
            C_Timer.After(0.6, function()
                popup:Hide()
                desc:SetText("|cff999999Click the text below to select all, then press|r |cffC0C8D4Ctrl+C|r |cff999999to copy|r")
            end)
        end
    end)

    scrollFrame:SetScrollChild(editBox)
    popup.editBox = editBox

    -- Click anywhere on the editbox background to select all
    sfBg:EnableMouse(true)
    sfBg:SetScript("OnMouseDown", function()
        editBox:SetFocus()
        editBox:HighlightText()
    end)

    -- Close button (centered)
    local closeBtn = CreateFrame("Button", nil, popup, "UIPanelButtonTemplate")
    closeBtn:SetSize(100, 26)
    closeBtn:SetPoint("BOTTOM", popup, "BOTTOM", 0, 12)
    closeBtn:SetText("|cffC0C8D4Close|r")
    closeBtn:SetScript("OnClick", function() popup:Hide() end)

    -- ESC to close
    tinsert(UISpecialFrames, "MagguuUIWowUpPopup")

    popup:Hide()
    MUI.WowUpPopup = popup

    return popup
end

-- Generic function: show popup with a title and string
local function ShowWowUpString(popupTitle, str)
    local popup = GetOrCreateWowUpPopup()
    local text = str or "No WowUp string configured"

    popup.title:SetText(popupTitle)
    popup.editBox._muiText = text
    popup.editBox:SetText(text)
    popup:Show()
    popup:Raise()

    C_Timer.After(0.05, function()
        popup.editBox:SetFocus()
        popup.editBox:HighlightText()
    end)
end

-- Required addons string
function I:ShowWowUpRequired()
    ShowWowUpString(
        "|cff4A8FD9WowUp|r |cffC0C8D4Required Addons|r",
        D.WowUpRequired or D.WowUpString or "No required addons string configured"
    )
end

-- Optional/recommended addons string
function I:ShowWowUpOptional()
    ShowWowUpString(
        "|cff4A8FD9WowUp|r |cffC0C8D4Optional Addons|r",
        D.WowUpOptional or "No optional addons string configured"
    )
end

-- Local references for internal use
local ShowWowUpRequired = function() I:ShowWowUpRequired() end
local ShowWowUpOptional = function() I:ShowWowUpOptional() end

-- ============================================================
-- Custom Step Button Styling
-- ============================================================
local function StyleStepButtons()
    local frame = PluginInstallFrame
    if not frame or frame.MagguuStyled then return end

    local i = 1
    while true do
        local btn = frame["StepButton" .. i]
        if not btn then break end

        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(DARK_BG[1], DARK_BG[2], DARK_BG[3], 0.6)
        btn._muiBG = bg

        local accentLine = btn:CreateTexture(nil, "ARTWORK")
        accentLine:SetWidth(3)
        accentLine:SetPoint("TOPLEFT", btn, "TOPLEFT", 0, 0)
        accentLine:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 0, 0)
        accentLine:SetColorTexture(BLUE[1], BLUE[2], BLUE[3], 1)
        accentLine:Hide()
        btn._muiAccent = accentLine

        local hoverTex = btn:CreateTexture(nil, "HIGHLIGHT")
        hoverTex:SetAllPoints()
        hoverTex:SetColorTexture(HOVER_BG[1], HOVER_BG[2], HOVER_BG[3], 0.5)

        btn._muiIndex = i

        btn:HookScript("OnEnter", function(self)
            if self._muiBG then
                self._muiBG:SetColorTexture(HOVER_BG[1], HOVER_BG[2], HOVER_BG[3], 0.8)
            end
            if not self._muiIsActive and self:GetFontString() then
                self:GetFontString():SetTextColor(SILVER[1], SILVER[2], SILVER[3])
            end
        end)

        btn:HookScript("OnLeave", function(self)
            if self._muiIsActive then
                if self._muiBG then
                    self._muiBG:SetColorTexture(ACTIVE_BG[1], ACTIVE_BG[2], ACTIVE_BG[3], 0.9)
                end
            else
                if self._muiBG then
                    self._muiBG:SetColorTexture(DARK_BG[1], DARK_BG[2], DARK_BG[3], 0.6)
                end
                if self:GetFontString() then
                    self:GetFontString():SetTextColor(DIM[1], DIM[2], DIM[3])
                end
            end
        end)

        i = i + 1
    end

    frame.MagguuStyled = true
end

local function UpdateStepHighlight(currentPage)
    local frame = PluginInstallFrame
    if not frame or not frame.MagguuStyled then return end

    local i = 1
    while true do
        local btn = frame["StepButton" .. i]
        if not btn then break end

        if i == currentPage then
            btn._muiIsActive = true
            if btn._muiBG then
                btn._muiBG:SetColorTexture(ACTIVE_BG[1], ACTIVE_BG[2], ACTIVE_BG[3], 0.9)
            end
            if btn._muiAccent then btn._muiAccent:Show() end
            if btn:GetFontString() then
                btn:GetFontString():SetTextColor(BLUE[1], BLUE[2], BLUE[3])
            end
        else
            btn._muiIsActive = false
            if btn._muiBG then
                btn._muiBG:SetColorTexture(DARK_BG[1], DARK_BG[2], DARK_BG[3], 0.6)
            end
            if btn._muiAccent then btn._muiAccent:Hide() end
            if btn:GetFontString() then
                btn:GetFontString():SetTextColor(DIM[1], DIM[2], DIM[3])
            end
        end

        i = i + 1
    end
end

-- ============================================================
-- Make Installer Frame Bigger
-- ============================================================
local function EnlargeInstaller()
    local frame = PluginInstallFrame
    if not frame or frame.MagguuEnlarged then return end

    frame:SetSize(550, 400)

    if frame.tutorialImage then
        frame.tutorialImage:SetSize(256, 128)
    end

    frame.MagguuEnlarged = true
end

-- ============================================================
-- Hook into ElvUI PluginInstaller
-- ============================================================
function I:HookInstaller()
    if not PluginInstallFrame then return end
    if PluginInstallFrame.MagguuHooked then return end

    PluginInstallFrame:HookScript("OnShow", function()
        PluginInstallFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        C_Timer.After(0.05, function()
            EnlargeInstaller()
            StyleStepButtons()
            if PluginInstallFrame.CurrentPage then
                UpdateStepHighlight(PluginInstallFrame.CurrentPage)
            else
                UpdateStepHighlight(1)
            end
        end)
    end)

    if PluginInstallFrame.Next then
        PluginInstallFrame.Next:HookScript("OnClick", function()
            C_Timer.After(0.05, function()
                if PluginInstallFrame.CurrentPage then
                    UpdateStepHighlight(PluginInstallFrame.CurrentPage)
                end
            end)
        end)
    end

    if PluginInstallFrame.Prev then
        PluginInstallFrame.Prev:HookScript("OnClick", function()
            C_Timer.After(0.05, function()
                if PluginInstallFrame.CurrentPage then
                    UpdateStepHighlight(PluginInstallFrame.CurrentPage)
                end
            end)
        end)
    end

    local i = 1
    while true do
        local btn = PluginInstallFrame["StepButton" .. i]
        if not btn then break end
        btn:HookScript("OnClick", function()
            C_Timer.After(0.05, function()
                if PluginInstallFrame.CurrentPage then
                    UpdateStepHighlight(PluginInstallFrame.CurrentPage)
                end
            end)
        end)
        i = i + 1
    end

    PluginInstallFrame.MagguuHooked = true
end

-- ============================================================
-- Installer Pages
-- ============================================================
I.installer = {
    Title = format("%s %s", MUI.title, "|cff888888Installation|r"),
    Name = MUI.title,
    tutorialImage = "Interface\\AddOns\\MagguuUI\\Media\\Textures\\LogoTop.tga",
    Pages = {
        [1] = function()
            PluginInstallFrame.SubTitle:SetFormattedText("|cffccccccWelcome to|r %s", MUI.title)

            if not MUI.db.global.profiles then
                PluginInstallFrame.Desc1:SetText("|cff999999Click|r |cff4A8FD9Install All|r |cff999999to set up all profiles at once|r")
                PluginInstallFrame.Desc2:SetText("|cff999999Or click|r |cffC0C8D4Continue|r |cff999999to install addons individually|r")
                PluginInstallFrame.Desc3:SetText("|cff999999Missing addons? Copy a|r |cff4A8FD9WowUp|r |cff999999string below|r")
                PluginInstallFrame.Option1:Show()
                PluginInstallFrame.Option1:SetScript("OnClick", function() InstallAllProfiles() end)
                PluginInstallFrame.Option1:SetText("|cff4A8FD9Install All|r")
                PluginInstallFrame.Option2:Show()
                PluginInstallFrame.Option2:SetScript("OnClick", function() ShowWowUpRequired() end)
                PluginInstallFrame.Option2:SetText("|cff4A8FD9Required|r")
                PluginInstallFrame.Option3:Show()
                PluginInstallFrame.Option3:SetScript("OnClick", function() ShowWowUpOptional() end)
                PluginInstallFrame.Option3:SetText("|cff4A8FD9Optional|r")

                return
            end

            PluginInstallFrame.Desc1:SetText("|cff999999Click|r |cff4A8FD9Load Profiles|r |cff999999to apply your profiles to this character|r")
            PluginInstallFrame.Desc2:SetText("|cff999999Or click|r |cffC0C8D4Continue|r |cff999999to reinstall individual addons|r")
            PluginInstallFrame.Desc3:SetText("|cff999999Missing addons? Copy a|r |cff4A8FD9WowUp|r |cff999999string below|r")
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() MUI:LoadProfiles() end)
            PluginInstallFrame.Option1:SetText("|cff4A8FD9Load Profiles|r")
            PluginInstallFrame.Option2:Show()
            PluginInstallFrame.Option2:SetScript("OnClick", function() ShowWowUpRequired() end)
            PluginInstallFrame.Option2:SetText("|cff4A8FD9Required|r")
            PluginInstallFrame.Option3:Show()
            PluginInstallFrame.Option3:SetScript("OnClick", function() ShowWowUpOptional() end)
            PluginInstallFrame.Option3:SetText("|cff4A8FD9Optional|r")
        end,
        [2] = function()
            PluginInstallFrame.SubTitle:SetText("|cffC0C8D4ElvUI|r")

            if not MUI:IsAddOnEnabled("ElvUI") then
                PluginInstallFrame.Desc1:SetText("|cff666666Enable ElvUI to unlock this step|r")

                return
            end

            PluginInstallFrame.Desc1:SetText("|cff999999Complete UI replacement for action bars, unit frames, and more|r")
            PluginInstallFrame.Desc2:SetText("|cff999999Movable frames with built-in configuration GUI|r")
            PluginInstallFrame.Desc3:SetText("|cff999999Adds quality-of-life features beyond the default interface|r")
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("ElvUI", true) end)
            PluginInstallFrame.Option1:SetText("|cff4A8FD9Install|r")
        end,
        [3] = function()
            PluginInstallFrame.SubTitle:SetText("|cffC0C8D4BetterCooldownManager|r")

            if not MUI:IsAddOnEnabled("BetterCooldownManager") then
                PluginInstallFrame.Desc1:SetText("|cff666666Enable BetterCooldownManager to unlock this step|r")

                return
            end

            PluginInstallFrame.Desc1:SetText("|cff999999Enhanced cooldown tracking with flexible bar layouts|r")
            PluginInstallFrame.Desc2:SetText("|cff999999Configurable tracking for spells, items, and trinkets|r")
            PluginInstallFrame.Desc3:SetText("|cff4A8FD9Class-specific layouts:|r |cffC0C8D4ui.magguu.xyz|r")
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("BetterCooldownManager", true) end)
            PluginInstallFrame.Option1:SetText("|cff4A8FD9Install|r")
        end,
        [4] = function()
            PluginInstallFrame.SubTitle:SetText("|cffC0C8D4BigWigs|r")

            if not MUI:IsAddOnEnabled("BigWigs") then
                PluginInstallFrame.Desc1:SetText("|cff666666Enable BigWigs to unlock this step|r")

                return
            end

            PluginInstallFrame.Desc1:SetText("|cff999999Lightweight boss mod with alerts, timers, and sounds|r")
            PluginInstallFrame.Desc2:SetText("|cff999999Real-time warnings for boss abilities and phase changes|r")
            PluginInstallFrame.Desc3:SetText("|cff999999Extremely optimized with minimal CPU and memory usage|r")
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("BigWigs", true) end)
            PluginInstallFrame.Option1:SetText("|cff4A8FD9Install|r")
        end,
        [5] = function()
            PluginInstallFrame.SubTitle:SetText("|cffC0C8D4Blizzard EditMode|r")
            PluginInstallFrame.Desc1:SetText("|cff999999Blizzard's built-in UI layout editor for HUD elements|r")
            PluginInstallFrame.Desc2:SetText("|cff999999Drag, resize, and snap UI elements with saveable layouts|r")
            PluginInstallFrame.Desc3:SetText("|cff999999Fine-tune action bars, unit frames, minimap, and more|r")
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("Blizzard_EditMode", true) end)
            PluginInstallFrame.Option1:SetText("|cff4A8FD9Install|r")
        end,
        [6] = function()
            PluginInstallFrame.SubTitle:SetText("|cffC0C8D4Details|r")

            if not MUI:IsAddOnEnabled("Details") then
                PluginInstallFrame.Desc1:SetText("|cff666666Enable Details to unlock this step|r")

                return
            end

            PluginInstallFrame.Desc1:SetText("|cff999999Real-time combat meter for damage, healing, and more|r")
            PluginInstallFrame.Desc2:SetText("|cff999999Detailed encounter breakdowns with custom displays|r")
            PluginInstallFrame.Desc3:SetText("|cff999999Includes death logs, raid tools, and guild rankings|r")
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("Details", true) end)
            PluginInstallFrame.Option1:SetText("|cff4A8FD9Install|r")
        end,
        [7] = function()
            PluginInstallFrame.SubTitle:SetText("|cffC0C8D4Plater|r")

            if not MUI:IsAddOnEnabled("Plater") then
                PluginInstallFrame.Desc1:SetText("|cff666666Enable Plater to unlock this step|r")

                return
            end

            PluginInstallFrame.Desc1:SetText("|cff999999Highly customizable nameplates with health and cast bars|r")
            PluginInstallFrame.Desc2:SetText("|cff999999Scripting, animations, and importable Wago profiles|r")
            PluginInstallFrame.Desc3:SetText("|cff999999Automatic threat coloring and per-unit-type settings|r")
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function()
                if SE:ProfileExistsForAddon("Plater") then
                    local dialog = StaticPopup_Show("MAGGUUI_OVERWRITE_PROFILE", "Plater")

                    if dialog then
                        dialog.data = {
                            callback = function()
                                SE:Setup("Plater", true)

                                ReloadUI()
                            end
                        }
                    end
                else
                    SE:Setup("Plater", true)

                    ReloadUI()
                end
            end)
            PluginInstallFrame.Option1:SetText("|cff4A8FD9Install|r")
        end,
        [8] = function()
            PluginInstallFrame.SubTitle:SetText("|cff00ff88Installation Complete|r")
            PluginInstallFrame.Desc1:SetText("|cff999999You have completed the installation process|r")
            PluginInstallFrame.Desc2:SetText("|cff999999Click|r |cffC0C8D4Reload|r |cff999999to save your settings|r")
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() ReloadUI() end)
            PluginInstallFrame.Option1:SetText("|cffC0C8D4Reload|r")
        end
    },
    StepTitles = {
        [1] = "Welcome",
        [2] = "ElvUI",
        [3] = "BCM",
        [4] = "BigWigs",
        [5] = "EditMode",
        [6] = "Details",
        [7] = "Plater",
        [8] = "Complete"
    },
    StepTitlesColor = {DIM[1], DIM[2], DIM[3]},
    StepTitlesColorSelected = {BLUE[1], BLUE[2], BLUE[3]},
    StepTitleWidth = 200,
    StepTitleButtonWidth = 180,
    StepTitleTextJustification = "RIGHT"
}
