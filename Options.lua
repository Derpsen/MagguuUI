local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local InCombatLockdown = InCombatLockdown

-- ============================================================
-- URL Copy Popup (same style as WowUp popup)
-- ============================================================
local BLUE = {0.27, 0.54, 0.83}
local SILVER = {0.76, 0.80, 0.85}
local POPUP_BG = {0.05, 0.05, 0.05}
local POPUP_BORDER = {0.12, 0.12, 0.12}
local EDITBOX_BG = {0.02, 0.02, 0.02}

local function GetOrCreateURLPopup()
    if MUI.URLPopup then return MUI.URLPopup end

    local popup = CreateFrame("Frame", "MagguuUIURLPopup", UIParent, "BackdropTemplate")
    popup:SetSize(380, 130)
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

    -- Title
    local title = popup:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", popup, "TOP", 0, -16)
    title:SetText("|cff4A8FD9MagguuUI|r |cffC0C8D4Website|r")

    -- Description
    local desc = popup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    desc:SetPoint("TOP", title, "BOTTOM", 0, -6)
    desc:SetText("|cff999999Press|r |cffC0C8D4Ctrl+C|r |cff999999to copy the URL|r")

    -- EditBox background
    local ebBg = CreateFrame("Frame", nil, popup, "BackdropTemplate")
    ebBg:SetHeight(26)
    ebBg:SetPoint("TOPLEFT", popup, "TOPLEFT", 14, -60)
    ebBg:SetPoint("TOPRIGHT", popup, "TOPRIGHT", -14, -60)
    ebBg:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    ebBg:SetBackdropColor(EDITBOX_BG[1], EDITBOX_BG[2], EDITBOX_BG[3], 1)
    ebBg:SetBackdropBorderColor(POPUP_BORDER[1], POPUP_BORDER[2], POPUP_BORDER[3], 1)

    -- EditBox
    local editBox = CreateFrame("EditBox", nil, ebBg)
    editBox:SetAllPoints()
    editBox:SetAutoFocus(false)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetTextInsets(8, 8, 0, 0)

    editBox:SetScript("OnEscapePressed", function() popup:Hide() end)
    editBox:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    editBox:SetScript("OnMouseUp", function(self) self:HighlightText() end)

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
                desc:SetText("|cff999999Press|r |cffC0C8D4Ctrl+C|r |cff999999to copy the URL|r")
            end)
        end
    end)

    popup.editBox = editBox

    -- Close button (centered)
    local closeBtn = CreateFrame("Button", nil, popup, "UIPanelButtonTemplate")
    closeBtn:SetSize(100, 26)
    closeBtn:SetPoint("BOTTOM", popup, "BOTTOM", 0, 10)
    closeBtn:SetText("|cffC0C8D4Close|r")
    closeBtn:SetScript("OnClick", function() popup:Hide() end)

    -- ESC to close
    tinsert(UISpecialFrames, "MagguuUIURLPopup")

    popup:Hide()
    MUI.URLPopup = popup

    return popup
end

local function ShowURLPopup()
    local popup = GetOrCreateURLPopup()
    local url = "https://ui.magguu.xyz"

    popup.editBox._muiText = url
    popup.editBox:SetText(url)
    popup:Show()
    popup:Raise()

    C_Timer.After(0.05, function()
        popup.editBox:SetFocus()
        popup.editBox:HighlightText()
    end)
end

local function AreAddOnsEnabled()
    local addons = {
        ["BigWigs"] = true,
        ["Details"] = true,
        ["Plater"] = true
    }

    for k in pairs(addons) do
        if MUI:IsAddOnEnabled(k) then

            return true
        end
    end
end

MUI.options = {
    name = "MagguuUI",
    type = "group",
    args = {
        profiles = {
            name = "Profiles",
            order = 1,
            hidden = function()
                if MUI:IsAddOnEnabled("ElvUI") or (not MUI.Retail and not AreAddOnsEnabled()) or InCombatLockdown() then

                    return true
                end
            end,
            type = "group",
            args = {
                bettercooldownmanager = {
                    name = "BetterCooldownManager",
                    desc = "Setup BetterCooldownManager",
                    hidden = function()
                        if not MUI.Retail or not MUI:IsAddOnEnabled("BetterCooldownManager") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("BetterCooldownManager", true) end
                },
                bigwigs = {
                    name = "BigWigs",
                    desc = "Setup BigWigs",
                    hidden = function()
                        if not MUI:IsAddOnEnabled("BigWigs") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("BigWigs", true) end
                },
                blizzard_editmode = {
                    name = "Blizzard_EditMode",
                    desc = "Setup Blizzard_EditMode",
                    hidden = function()
                        if not MUI.Retail then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("Blizzard_EditMode", true) end
                },
                details = {
                    name = "Details",
                    desc = "Setup Details",
                    hidden = function()
                        if not MUI:IsAddOnEnabled("Details") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("Details", true) end
                },
                plater = {
                    name = "Plater",
                    desc = "Setup Plater",
                    hidden = function()
                        if not MUI:IsAddOnEnabled("Plater") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function()
                        SE:Setup("Plater", true)

                        ReloadUI()
                    end
                }
            }
        },
        settings = {
            name = "Settings",
            order = 2,
            type = "group",
            args = {
                minimap_toggle = {
                    name = "Show Minimap Button",
                    desc = "Toggle the minimap button on or off",
                    order = 1,
                    type = "toggle",
                    get = function() return MUI.db.global.minimapButton ~= false end,
                    set = function() MUI:ToggleMinimapButton() end,
                    width = "full"
                },
                spacer_info = {
                    name = " ",
                    order = 10,
                    type = "description"
                },
                info_header = {
                    name = "|cffC0C8D4Info|r",
                    order = 11,
                    type = "header"
                },
                version_info = {
                    name = function()
                        local version = MUI.version or GetAddOnMetadata("MagguuUI", "Version") or "Unknown"
                        return "|cff999999Version:|r |cff4A8FD9" .. version .. "|r"
                    end,
                    order = 12,
                    type = "description",
                    fontSize = "medium"
                },
                spacer_version = {
                    name = " ",
                    order = 13,
                    type = "description"
                },
                website_link = {
                    name = "|cff999999Website:|r |cff4A8FD9ui.magguu.xyz|r",
                    order = 14,
                    type = "description",
                    fontSize = "medium"
                },
                open_website = {
                    name = "Open Website",
                    desc = "Copies the website URL to your clipboard",
                    order = 15,
                    type = "execute",
                    func = function()
                        ShowURLPopup()
                    end
                }
            }
        },
        wowup = {
            name = "|cff4A8FD9WowUp|r",
            order = 3,
            type = "group",
            args = {
                header = {
                    name = "|cff4A8FD9WowUp|r |cffC0C8D4Addon Import|r",
                    order = 1,
                    type = "header"
                },
                info = {
                    name = "|cff999999MagguuUI requires several addons to work properly. "
                        .. "You can install all of them at once using|r |cff4A8FD9WowUp|r|cff999999's import feature.|r\n\n"
                        .. "|cffC0C8D4How to use:|r\n"
                        .. "|cff9999991.|r |cff999999Click|r |cffC0C8D4Copy WowUp String|r |cff999999below to open the import string|r\n"
                        .. "|cff9999992.|r |cff999999The string is selected automatically — press|r |cffC0C8D4Ctrl+C|r |cff999999to copy|r\n"
                        .. "|cff9999993.|r |cff999999Open|r |cff4A8FD9WowUp|r |cff999999on your computer|r\n"
                        .. "|cff9999994.|r |cff999999Click the|r |cffC0C8D4More|r |cff999999button > Import/Export Addons|r\n"
                        .. "|cff9999995.|r |cff999999Switch to the|r |cffC0C8D4Import|r |cff999999tab and paste the string|r\n"
                        .. "|cff9999996.|r |cff999999Click|r |cff4A8FD9Install|r |cff999999to install all addons|r",
                    order = 2,
                    type = "description",
                    fontSize = "medium"
                },
                spacer1 = {
                    name = " ",
                    order = 3,
                    type = "description"
                },
                import_string = {
                    name = "Copy WowUp String",
                    desc = "Opens a popup with the WowUp import string",
                    order = 4,
                    type = "execute",
                    func = function()
                        local I = MUI:GetModule("Installer")
                        if I and I.ShowWowUpPopup then
                            I:ShowWowUpPopup()
                        end
                    end
                },
                spacer2 = {
                    name = " ",
                    order = 5,
                    type = "description"
                },
                addon_list = {
                    name = "|cffC0C8D4Required Addons:|r\n\n"
                        .. "|cff4A8FD9ElvUI|r |cff666666- Complete UI replacement|r\n"
                        .. "|cff4A8FD9ElvUI_Anchor|r |cff666666- Extended frame positioning|r\n"
                        .. "|cff4A8FD9ElvUI WindTools|r |cff666666- Enhanced skins & QoL features|r\n"
                        .. "|cff4A8FD9BetterCooldownManager|r |cff666666- Cooldown tracking|r\n"
                        .. "|cff4A8FD9BigWigs|r |cff666666- Boss encounter mod|r\n"
                        .. "|cff4A8FD9Details|r |cff666666- Damage & healing meter|r\n"
                        .. "|cff4A8FD9Plater|r |cff666666- Nameplate addon|r",
                    order = 6,
                    type = "description",
                    fontSize = "medium"
                }
            }
        }
    }
}
