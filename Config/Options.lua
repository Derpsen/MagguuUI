local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")
local D = MUI:GetModule("Data")

local format = format
local ipairs = ipairs
local tinsert = tinsert
local InCombatLockdown = InCombatLockdown

-- Use centralized colors
local C = MUI.Colors
local POPUP_BG = C.POPUP_BG
local POPUP_BORDER = C.POPUP_BORDER
local L = LibStub("AceLocale-3.0"):GetLocale("MagguuUI")

-- ============================================================
-- Helper: Build addon list string from D.WowUpRequiredList / OptionalList
-- ============================================================
local function BuildAddonListString(listTable, headerColor, headerText)
    local header = format("|cff%s%s:|r\n\n", headerColor, headerText)

    if not listTable or #listTable == 0 then
        return header .. format("|cff%s%s|r", C.HEX_DARK, L["NO_ADDON_DATA_RELOAD"])
    end

    local lines = {}
    for _, name in ipairs(listTable) do
        tinsert(lines, format("|cff%s%s|r", C.HEX_BLUE, name))
    end

    return header .. table.concat(lines, "\n")
end

-- ============================================================
-- URL Copy Popup (same style as WowUp popup)
-- ============================================================
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

    -- Title (below header)
    local title = popup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", header, "BOTTOM", 0, -10)
    popup.title = title

    -- Description
    local desc = popup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    desc:SetPoint("TOP", title, "BOTTOM", 0, -4)
    desc:SetText(format("|cff%s%s|r", C.HEX_DIM, L["PRESS_CTRL_C"]))
    popup.desc = desc

    -- EditBox
    local editBox = CreateFrame("EditBox", nil, popup, "InputBoxTemplate")
    editBox:SetSize(340, 20)
    editBox:SetPoint("TOP", desc, "BOTTOM", 0, -8)
    editBox:SetAutoFocus(false)
    editBox:SetFontObject(ChatFontNormal)

    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        popup:Hide()
    end)
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
            C_Timer.After(0.5, function()
                popup:Hide()
                desc:SetText(format("|cff%s%s|r", C.HEX_DIM, L["PRESS_CTRL_C"]))
            end)
        end
    end)

    popup.editBox = editBox

    -- Close button (UIPanelButtonTemplate — ElvUI auto-skins)
    local closeBtn = CreateFrame("Button", nil, popup, "UIPanelButtonTemplate")
    closeBtn:SetSize(80, 22)
    closeBtn:SetPoint("BOTTOM", popup, "BOTTOM", 0, 10)
    closeBtn:SetText(L["CLOSE"])
    closeBtn:SetScript("OnClick", function() popup:Hide() end)

    -- ESC to close
    tinsert(UISpecialFrames, "MagguuUIURLPopup")

    popup:Hide()
    MUI.URLPopup = popup

    return popup
end

local function ShowURLPopup(label, url)
    local popup = GetOrCreateURLPopup()

    popup.title:SetText(label or "|cff4A8FD9Website|r")
    popup.editBox._muiText = url
    popup.editBox:SetText(url)
    popup:Show()
    popup:Raise()

    C_Timer.After(0.05, function()
        popup.editBox:SetFocus()
        popup.editBox:HighlightText()
    end)
end

-- Expose globally so ElvUI_MagguuUI.lua can reuse the same popup
function MUI:ShowURLPopup(label, url)
    ShowURLPopup(label, url)
end

MUI.options = {
    name = "MagguuUI",
    type = "group",
    args = {
        profiles = {
            name = L["PROFILES"],
            order = 1,
            hidden = function()
                if MUI:IsAddOnEnabled("ElvUI") or InCombatLockdown() then
                    return true
                end

                return false
            end,
            type = "group",
            args = {
                bettercooldownmanager = {
                    name = "BetterCooldownManager",
                    desc = format(L["SETUP_ADDON"], "BetterCooldownManager"),
                    hidden = function()
                        if not MUI:IsAddOnEnabled("BetterCooldownManager") then
                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("BetterCooldownManager", true) end
                },
                bigwigs = {
                    name = "BigWigs",
                    desc = format(L["SETUP_ADDON"], "BigWigs"),
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
                    desc = format(L["SETUP_ADDON"], "Blizzard_EditMode"),
                    type = "execute",
                    func = function() SE:Setup("Blizzard_EditMode", true) end
                },
                details = {
                    name = "Details",
                    desc = format(L["SETUP_ADDON"], "Details"),
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
                    desc = format(L["SETUP_ADDON"], "Plater"),
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
            name = L["SETTINGS"],
            order = 2,
            type = "group",
            args = {
                minimap_toggle = {
                    name = L["SHOW_MINIMAP_BUTTON"],
                    desc = L["SHOW_MINIMAP_BUTTON_DESC"],
                    order = 1,
                    type = "toggle",
                    get = function() return not (MUI.db.global.minimap and MUI.db.global.minimap.hide) end,
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
                        local version = MUI.version or C_AddOns.GetAddOnMetadata("MagguuUI", "Version") or "Unknown"
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
                    name = L["OPEN_WEBSITE"],
                    desc = L["OPEN_WEBSITE_DESC"],
                    order = 15,
                    type = "execute",
                    func = function()
                        ShowURLPopup("|cff4A8FD9Website|r", "https://ui.magguu.xyz")
                    end
                },
                spacer_changelog = {
                    name = " ",
                    order = 16,
                    type = "description"
                },
                show_changelog = {
                    name = L["SHOW_CHANGELOG"],
                    desc = L["SHOW_CHANGELOG_DESC"],
                    order = 17,
                    type = "execute",
                    func = function()
                        MUI:ShowChangelog()
                    end
                }
            }
        },
        wowup = {
            name = format("|cff%sWowUp|r", C.HEX_BLUE),
            order = 3,
            type = "group",
            args = {
                header = {
                    name = format("|cff%sWowUp|r |cff%s%s|r", C.HEX_BLUE, C.HEX_SILVER, L["WOWUP_ADDON_IMPORT"]),
                    order = 1,
                    type = "header"
                },
                info = {
                    name = format("|cff%s%s|r\n\n", C.HEX_DIM, L["WOWUP_DESC"])
                        .. format("|cff%s%s|r |cff%s— %s|r\n", C.HEX_SOFT_RED, L["REQUIRED"], C.HEX_DIM, L["WOWUP_REQUIRED_DESC"])
                        .. format("|cff%s%s — %s|r\n\n", C.HEX_DIM, L["OPTIONAL"], L["WOWUP_OPTIONAL_DESC"])
                        .. format("|cff%s%s:|r\n", C.HEX_SILVER, L["WOWUP_HOW_TO"])
                        .. format("|cff%s1.|r |cff%sClick|r |cff%s%s|r |cff%sor|r %s |cff%sbelow|r\n", C.HEX_DIM, C.HEX_DIM, C.HEX_SOFT_RED, L["REQUIRED"], C.HEX_DIM, L["OPTIONAL"], C.HEX_DIM)
                        .. format("|cff%s2.|r |cff%sThe string is selected — press|r |cff%sCtrl+C|r |cff%sto copy|r\n", C.HEX_DIM, C.HEX_DIM, C.HEX_SILVER, C.HEX_DIM)
                        .. format("|cff%s3.|r |cff%sOpen|r |cff%sWowUp|r |cff%s> More > Import/Export Addons|r\n", C.HEX_DIM, C.HEX_DIM, C.HEX_BLUE, C.HEX_DIM)
                        .. format("|cff%s4.|r |cff%sSwitch to|r |cff%sImport|r|cff%s, paste, click|r |cff%sInstall|r", C.HEX_DIM, C.HEX_DIM, C.HEX_SILVER, C.HEX_DIM, C.HEX_BLUE),
                    order = 2,
                    type = "description",
                    fontSize = "medium"
                },
                spacer1 = {
                    name = " ",
                    order = 3,
                    type = "description"
                },
                import_required = {
                    name = format("|cff%s%s|r", C.HEX_SOFT_RED, L["COPY_REQUIRED_ADDONS"]),
                    desc = L["COPY_REQUIRED_DESC"],
                    order = 4,
                    type = "execute",
                    func = function()
                        local I = MUI:GetModule("Installer")
                        if I and I.ShowWowUpRequired then
                            I:ShowWowUpRequired()
                        end
                    end
                },
                import_optional = {
                    name = L["COPY_OPTIONAL_ADDONS"],
                    desc = L["COPY_OPTIONAL_DESC"],
                    order = 5,
                    type = "execute",
                    func = function()
                        local I = MUI:GetModule("Installer")
                        if I and I.ShowWowUpOptional then
                            I:ShowWowUpOptional()
                        end
                    end
                },
                spacer2 = {
                    name = " ",
                    order = 6,
                    type = "description"
                },
                required_list = {
                    name = BuildAddonListString(D.WowUpRequiredList, C.HEX_SOFT_RED, L["REQUIRED_ADDONS"]),
                    order = 7,
                    type = "description",
                    fontSize = "medium"
                },
                spacer3 = {
                    name = " ",
                    order = 8,
                    type = "description"
                },
                optional_list = {
                    name = BuildAddonListString(D.WowUpOptionalList, C.HEX_DIM, L["OPTIONAL_ADDONS"]),
                    order = 9,
                    type = "description",
                    fontSize = "medium"
                }
            }
        }
    }
}
