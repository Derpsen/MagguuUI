local MUI = unpack(MagguuUI)
local I = MUI:GetModule("Installer")
local SE = MUI:GetModule("Setup")
local D = MUI:GetModule("Data")

-- Use centralized colors
local C = MUI.Colors
local L = LibStub("AceLocale-3.0"):GetLocale("MagguuUI")
local BLUE = C.BLUE
local SILVER = C.SILVER
local DARK_BG = C.DARK_BG
local HOVER_BG = C.HOVER_BG
local ACTIVE_BG = C.ACTIVE_BG
local DIM = C.DIM
local POPUP_BG = C.POPUP_BG
local POPUP_BORDER = C.POPUP_BORDER

-- ============================================================
-- Install All Profiles (fresh install, sequential)
-- ============================================================
local INSTALL_ORDER = MUI.INSTALL_ORDER

local function InstallAllProfiles()
    MUI:ProcessProfileQueue(true, INSTALL_ORDER)
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

    -- ElvUI Transparent template (matches Installer)
    if popup.SetTemplate then
        popup:SetTemplate("Transparent")
    else
        popup:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
        })
        popup:SetBackdropColor(POPUP_BG[1], POPUP_BG[2], POPUP_BG[3], 0.95)
        popup:SetBackdropBorderColor(POPUP_BORDER[1], POPUP_BORDER[2], POPUP_BORDER[3], 1)
    end

    -- Header: MagguuUI
    local header = popup:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    header:SetPoint("TOP", popup, "TOP", 0, -14)
    header:SetText(MUI.title)

    -- Title (dynamic, below header)
    local title = popup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", header, "BOTTOM", 0, -10)
    popup.title = title

    -- Description
    local desc = popup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    desc:SetPoint("TOP", title, "BOTTOM", 0, -4)
    desc:SetPoint("LEFT", popup, "LEFT", 14, 0)
    desc:SetPoint("RIGHT", popup, "RIGHT", -14, 0)
    desc:SetText(format("|cff%s%s|r", C.HEX_DIM, L["COPY_HINT"]))
    popup.desc = desc

    -- ScrollFrame + EditBox (relative anchoring to desc)
    local scrollFrame = CreateFrame("ScrollFrame", nil, popup, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -20)
    scrollFrame:SetPoint("BOTTOMRIGHT", popup, "BOTTOMRIGHT", -32, 50)

    -- Scroll background (transparent)
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
        sfBg:SetBackdropColor(0.02, 0.02, 0.02, 0.6)
        sfBg:SetBackdropBorderColor(POPUP_BORDER[1], POPUP_BORDER[2], POPUP_BORDER[3], 1)
    end
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
            desc:SetText(format("|cff%s%s|r", C.HEX_GREEN, L["COPIED"]))
            C_Timer.After(0.6, function()
                popup:Hide()
                desc:SetText(format("|cff%s%s|r", C.HEX_DIM, L["COPY_HINT"]))
            end)
        end
    end)

    scrollFrame:SetScrollChild(editBox)
    popup.editBox = editBox

    -- Close button (UIPanelButtonTemplate — ElvUI auto-skins)
    local closeBtn = CreateFrame("Button", nil, popup, "UIPanelButtonTemplate")
    closeBtn:SetSize(80, 22)
    closeBtn:SetPoint("BOTTOM", popup, "BOTTOM", 0, 14)
    closeBtn:SetText(L["CLOSE"])
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
    local text = str or L["NO_WOWUP_STRING"]

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
        format("|cff%sWowUp|r |cff%s%s|r", C.HEX_BLUE, C.HEX_SILVER, L["REQUIRED_ADDONS"]),
        D.WowUpRequired or D.WowUpString or L["NO_REQUIRED_STRING"]
    )
end

-- Optional/recommended addons string
function I:ShowWowUpOptional()
    ShowWowUpString(
        format("|cff%sWowUp|r |cff%s%s|r", C.HEX_BLUE, C.HEX_SILVER, L["OPTIONAL_ADDONS"]),
        D.WowUpOptional or L["NO_OPTIONAL_STRING"]
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

        -- Make step buttons bigger
        btn:SetHeight(32)
        if btn:GetWidth() < 200 then
            btn:SetWidth(200)
        end

        -- Increase font size
        local fs = btn:GetFontString()
        if fs then
            fs:SetFont(fs:GetFont(), 13, "OUTLINE")
        end

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
local function SetFontSize(fontString, size)
    if not fontString then return end
    local font = fontString:GetFont()
    if font then fontString:SetFont(font, size, "OUTLINE") end
end

local function EnlargeInstaller()
    local frame = PluginInstallFrame
    if not frame or frame.MagguuEnlarged then return end

    frame:SetSize(550, 400)

    if frame.tutorialImage then
        frame.tutorialImage:SetSize(256, 128)
    end

    -- Increase font sizes for title and descriptions
    SetFontSize(frame.Title, 16)
    SetFontSize(frame.SubTitle, 13)
    SetFontSize(frame.Desc1, 12)
    SetFontSize(frame.Desc2, 12)
    SetFontSize(frame.Desc3, 12)

    -- Increase option button font sizes
    for i = 1, 4 do
        local optBtn = frame["Option" .. i]
        if optBtn then
            SetFontSize(optBtn:GetFontString(), 12)
        end
    end

    frame.MagguuEnlarged = true
end

-- ============================================================
-- Clear ElvUI default tooltips from option buttons
-- ============================================================
local function ClearOptionTooltips()
    for i = 1, 4 do
        local btn = PluginInstallFrame["Option" .. i]
        if btn then
            btn.tooltipText = nil
        end
    end
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
            ClearOptionTooltips()
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
                ClearOptionTooltips()
                if PluginInstallFrame.CurrentPage then
                    UpdateStepHighlight(PluginInstallFrame.CurrentPage)
                end
            end)
        end)
    end

    if PluginInstallFrame.Prev then
        PluginInstallFrame.Prev:HookScript("OnClick", function()
            C_Timer.After(0.05, function()
                ClearOptionTooltips()
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
                ClearOptionTooltips()
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
-- Profile Status Helper
-- ============================================================
local function GetProfileStatusText(addon)
    if SE.IsProfileActive(addon) then
        return format("|cff%s%s|r", C.HEX_GREEN, L["PROFILE_ACTIVE"])
    elseif SE:ProfileExistsForAddon(addon) then
        return format("|cff%s%s|r", C.HEX_YELLOW, L["PROFILE_INSTALLED"])
    else
        return format("|cff%s%s|r", C.HEX_SOFT_RED, L["PROFILE_NOT_INSTALLED"])
    end
end

-- EditMode has no IsProfileActive check
local function GetEditModeStatusText()
    if SE:ProfileExistsForAddon("Blizzard_EditMode") then
        return format("|cff%s%s|r", C.HEX_YELLOW, L["PROFILE_INSTALLED"])
    else
        return format("|cff%s%s|r", C.HEX_SOFT_RED, L["PROFILE_NOT_INSTALLED"])
    end
end

-- ============================================================
-- Installer Pages
-- ============================================================
I.installer = {
    Title = format("%s |cff%s%s|r", MUI.title, C.HEX_DIM, L["INSTALLATION"]),
    Name = MUI.title,
    tutorialImage = "Interface\\AddOns\\MagguuUI\\Media\\Textures\\LogoTop.tga",
    Pages = {
        [1] = function()
            if PluginInstallFrame.tutorialImage2 then PluginInstallFrame.tutorialImage2:Hide() end
            PluginInstallFrame.SubTitle:SetFormattedText("|cff%s%s|r %s", C.HEX_SILVER, L["WELCOME_TO"], MUI.title)

            -- Check if profiles need (re-)installation:
            -- No profiles at all, OR version changed since last install
            local needsInstall = not MUI.db.global.profiles
            if not needsInstall and MUI.db.global.version then
                local savedVer = tostring(MUI.db.global.version):gsub("^v", "")
                local currentVer = tostring(MUI.version or ""):gsub("^v", "")
                if savedVer ~= currentVer then
                    needsInstall = true
                end
            end

            if needsInstall then
                PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r", C.HEX_DIM, L["INSTALL_ALL_DESC"]))
                PluginInstallFrame.Desc2:SetText(format("|cff%s%s|r\n|cff%s%s|r", C.HEX_YELLOW, L["OPTIMIZED_4K"], C.HEX_DIM, L["OTHER_RESOLUTIONS"]))
                PluginInstallFrame.Desc3:SetText(format("|cff%s%s|r", C.HEX_DIM, L["MISSING_ADDONS"]))
                PluginInstallFrame.Option1:Show()
                PluginInstallFrame.Option1:SetScript("OnClick", function() InstallAllProfiles() end)
                PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_BLUE, L["INSTALL_ALL"]))

                PluginInstallFrame.Option2:Show()
                PluginInstallFrame.Option2:SetScript("OnClick", function() ShowWowUpRequired() end)
                PluginInstallFrame.Option2:SetText(format("|cff%s%s|r", C.HEX_SOFT_RED, L["REQUIRED"]))

                PluginInstallFrame.Option3:Show()
                PluginInstallFrame.Option3:SetScript("OnClick", function() ShowWowUpOptional() end)
                PluginInstallFrame.Option3:SetText(format("|cff%s%s|r", C.HEX_DIM, L["OPTIONAL"]))


                return
            end

            PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r", C.HEX_DIM, L["LOAD_PROFILES_INSTALLER_DESC"]))
            PluginInstallFrame.Desc2:SetText(format("|cff%s%s|r\n|cff%s%s|r", C.HEX_YELLOW, L["OPTIMIZED_4K"], C.HEX_DIM, L["OTHER_RESOLUTIONS"]))
            PluginInstallFrame.Desc3:SetText(format("|cff%s%s|r", C.HEX_DIM, L["MISSING_ADDONS"]))
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() MUI:LoadProfiles() end)
            PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_BLUE, L["LOAD_PROFILES"]))
            PluginInstallFrame.Option1.tooltipText = nil
            PluginInstallFrame.Option2:Show()
            PluginInstallFrame.Option2:SetScript("OnClick", function() ShowWowUpRequired() end)
            PluginInstallFrame.Option2:SetText(format("|cff%s%s|r", C.HEX_SOFT_RED, L["REQUIRED"]))
            PluginInstallFrame.Option2.tooltipText = nil
            PluginInstallFrame.Option3:Show()
            PluginInstallFrame.Option3:SetScript("OnClick", function() ShowWowUpOptional() end)
            PluginInstallFrame.Option3:SetText(format("|cff%s%s|r", C.HEX_DIM, L["OPTIONAL"]))
            PluginInstallFrame.Option3.tooltipText = nil
        end,
        [2] = function()

            PluginInstallFrame.SubTitle:SetText(format("|cff%sElvUI|r", C.HEX_SILVER))

            if not MUI:IsAddOnEnabled("ElvUI") then
                PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r", C.HEX_DARK, L["ELVUI_ENABLE"]))

                return
            end

            PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r\n|cff%s%s|r", C.HEX_DIM, L["ELVUI_DESC1"], C.HEX_DIM, L["ELVUI_DESC2"]))
            PluginInstallFrame.Desc3:SetText(GetProfileStatusText("ElvUI"))
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("ElvUI", true) end)
            PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_BLUE, L["INSTALL"]))
        end,
        [3] = function()

            PluginInstallFrame.SubTitle:SetText(format("|cff%sBetterCooldownManager|r", C.HEX_SILVER))

            if not MUI:IsAddOnEnabled("BetterCooldownManager") then
                PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r", C.HEX_DARK, L["BCM_ENABLE"]))

                return
            end

            PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r\n|cff%s%s|r", C.HEX_DIM, L["BCM_DESC1"], C.HEX_DIM, L["BCM_DESC2"]))
            PluginInstallFrame.Desc3:SetText(GetProfileStatusText("BetterCooldownManager"))
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("BetterCooldownManager", true) end)
            PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_BLUE, L["INSTALL"]))
        end,
        [4] = function()

            PluginInstallFrame.SubTitle:SetText(format("|cff%sBigWigs|r", C.HEX_SILVER))

            if not MUI:IsAddOnEnabled("BigWigs") then
                PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r", C.HEX_DARK, L["BIGWIGS_ENABLE"]))

                return
            end

            PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r\n|cff%s%s|r", C.HEX_DIM, L["BIGWIGS_DESC1"], C.HEX_DIM, L["BIGWIGS_DESC2"]))
            PluginInstallFrame.Desc3:SetText(GetProfileStatusText("BigWigs"))
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("BigWigs", true) end)
            PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_BLUE, L["INSTALL"]))
        end,
        [5] = function()

            PluginInstallFrame.SubTitle:SetText(format("|cff%sBlizzard EditMode|r", C.HEX_SILVER))
            PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r\n|cff%s%s|r", C.HEX_DIM, L["EDITMODE_DESC1"], C.HEX_DIM, L["EDITMODE_DESC2"]))
            PluginInstallFrame.Desc3:SetText(GetEditModeStatusText())
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("Blizzard_EditMode", true) end)
            PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_BLUE, L["INSTALL"]))
        end,
        [6] = function()

            PluginInstallFrame.SubTitle:SetText(format("|cff%sDetails|r", C.HEX_SILVER))

            if not MUI:IsAddOnEnabled("Details") then
                PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r", C.HEX_DARK, L["DETAILS_ENABLE"]))

                return
            end

            PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r\n|cff%s%s|r", C.HEX_DIM, L["DETAILS_DESC1"], C.HEX_DIM, L["DETAILS_DESC2"]))
            PluginInstallFrame.Desc3:SetText(GetProfileStatusText("Details"))
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() SE:SetupWithConfirmation("Details", true) end)
            PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_BLUE, L["INSTALL"]))
        end,
        [7] = function()

            PluginInstallFrame.SubTitle:SetText(format("|cff%sPlater|r", C.HEX_SILVER))

            if not MUI:IsAddOnEnabled("Plater") then
                PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r", C.HEX_DARK, L["PLATER_ENABLE"]))

                return
            end

            PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r\n|cff%s%s|r", C.HEX_DIM, L["PLATER_DESC1"], C.HEX_DIM, L["PLATER_DESC2"]))
            PluginInstallFrame.Desc3:SetText(GetProfileStatusText("Plater") .. "\n" .. format("|cff%s%s|r", C.HEX_YELLOW, L["REQUIRES_RELOAD"]))
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
            PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_BLUE, L["INSTALL"]))
        end,
        [8] = function()

            PluginInstallFrame.SubTitle:SetText(format("|cff%s%s|r", C.HEX_SILVER, L["STEP_LAYOUTS"]))

            local _, classToken = UnitClass("player")
            local classColor = RAID_CLASS_COLORS[classToken]
            local colorize = classColor and function(text) return classColor:WrapTextInColorCode(text) end or function(text) return format("|cff%s%s|r", C.HEX_BLUE, text) end

            local className = SE.GetPlayerClassDisplayName and SE.GetPlayerClassDisplayName() or L["YOUR_CLASS"]

            -- Build spec list for current class
            local specNames = {}
            for i = 1, GetNumSpecializations() do
                local _, name = GetSpecializationInfo(i)
                if name then
                    specNames[#specNames + 1] = colorize(name)
                end
            end
            local specList = table.concat(specNames, format("|cff%s, |r", C.HEX_DIM))

            PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r %s", C.HEX_DIM, L["CLASS_LAYOUTS_FOR"], colorize(className)))
            PluginInstallFrame.Desc2:SetText(specList)
            PluginInstallFrame.Desc3:SetText(GetProfileStatusText("ClassCooldowns") .. "\n" .. format("|cff%s%s|r", C.HEX_YELLOW, L["REQUIRES_RELOAD"]))
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function()
                SE:Setup("ClassCooldowns", true)
                ReloadUI()
            end)
            PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_BLUE, L["INSTALL"]))
        end,
        [9] = function()

            PluginInstallFrame.SubTitle:SetText(format("|cff%s%s|r", C.HEX_GREEN, L["INSTALLATION_COMPLETE"]))
            PluginInstallFrame.Desc1:SetText(format("|cff%s%s|r\n|cff%s%s|r", C.HEX_DIM, L["COMPLETED_DESC1"], C.HEX_DIM, L["COMPLETED_DESC2"]))
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function() ReloadUI() end)
            PluginInstallFrame.Option1:SetText(format("|cff%s%s|r", C.HEX_SILVER, L["RELOAD_BUTTON"]))
        end
    },
    StepTitles = {
        [1] = L["STEP_WELCOME"],
        [2] = "ElvUI",
        [3] = "BCM",
        [4] = "BigWigs",
        [5] = "EditMode",
        [6] = "Details",
        [7] = "Plater",
        [8] = L["STEP_LAYOUTS"],
        [9] = L["STEP_COMPLETE"],
    },
    StepTitlesColor = {DIM[1], DIM[2], DIM[3]},
    StepTitlesColorSelected = {BLUE[1], BLUE[2], BLUE[3]},
    StepTitleWidth = 200,
    StepTitleButtonWidth = 180,
    StepTitleTextJustification = "RIGHT"
}
