local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")
local D = MUI:GetModule("Data")

local format = format
local ipairs = ipairs
local tinsert = tinsert
local InCombatLockdown = InCombatLockdown

-- Use centralized colors
local C = MUI.Colors
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

    local popup = MUI:CreateBasePopup("MagguuUIURLPopup", 380, 130)

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
            C_Timer.After(MUI.Constants.URL_FEEDBACK_DELAY, function()
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

    MUI.URLPopup = popup

    return popup
end

local function ShowURLPopup(label, url)
    local popup = GetOrCreateURLPopup()

    popup.title:SetText(label or format("|cff%sWebsite|r", C.HEX_BLUE))
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
                    name = format("|cff%sInfo|r", C.HEX_SILVER),
                    order = 11,
                    type = "header"
                },
                version_info = {
                    name = function()
                        local version = MUI.version or C_AddOns.GetAddOnMetadata("MagguuUI", "Version") or "Unknown"
                        return format("|cff%sVersion:|r |cff%s%s|r", C.HEX_DIM, C.HEX_BLUE, version)
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
                    name = format("|cff%sWebsite:|r |cff%sui.magguu.xyz|r", C.HEX_DIM, C.HEX_BLUE),
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
                        ShowURLPopup(format("|cff%sWebsite|r", C.HEX_BLUE), "https://ui.magguu.xyz")
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
            childGroups = "tab",
            args = {
                -- Tab: Required
                required = {
                    name = format("|cff%s%s|r", C.HEX_SOFT_RED, L["REQUIRED"]),
                    order = 1,
                    type = "group",
                    args = {
                        howto_header = {
                            name = format("|cff%s%s|r", C.HEX_BLUE, L["WOWUP_HOW_TO"]),
                            order = 1,
                            type = "header"
                        },
                        howto = {
                            name = MUI:BuildWowUpHowToText(L["COPY_REQUIRED_ADDONS"], C.HEX_SOFT_RED),
                            order = 2,
                            type = "description",
                            fontSize = "medium"
                        },
                        spacer1 = {
                            name = " ",
                            order = 3,
                            type = "description"
                        },
                        desc = {
                            name = format("|cff%s%s|r\n", C.HEX_DIM, L["WOWUP_REQUIRED_DESC"]),
                            order = 4,
                            type = "description",
                            fontSize = "medium"
                        },
                        copy = {
                            name = format("|cff%s%s|r", C.HEX_SOFT_RED, L["COPY_REQUIRED_ADDONS"]),
                            desc = L["COPY_REQUIRED_DESC"],
                            order = 5,
                            type = "execute",
                            func = function()
                                local I = MUI:GetModule("Installer")
                                if I and I.ShowWowUpRequired then
                                    I:ShowWowUpRequired()
                                end
                            end,
                            width = "full"
                        },
                        spacer2 = {
                            name = "\n",
                            order = 6,
                            type = "description"
                        },
                        list_header = {
                            name = format("|cff%s%s|r", C.HEX_SOFT_RED, L["REQUIRED_ADDONS"]),
                            order = 7,
                            type = "header"
                        },
                        list = {
                            name = BuildAddonListString(D.WowUpRequiredList, C.HEX_SOFT_RED, ""),
                            order = 8,
                            type = "description",
                            fontSize = "medium"
                        }
                    }
                },

                -- Tab: Optional
                optional = {
                    name = L["OPTIONAL"],
                    order = 2,
                    type = "group",
                    args = {
                        howto_header = {
                            name = format("|cff%s%s|r", C.HEX_BLUE, L["WOWUP_HOW_TO"]),
                            order = 1,
                            type = "header"
                        },
                        howto = {
                            name = MUI:BuildWowUpHowToText(L["COPY_OPTIONAL_ADDONS"], C.HEX_DIM),
                            order = 2,
                            type = "description",
                            fontSize = "medium"
                        },
                        spacer1 = {
                            name = " ",
                            order = 3,
                            type = "description"
                        },
                        desc = {
                            name = format("|cff%s%s|r\n", C.HEX_DIM, L["WOWUP_OPTIONAL_DESC"]),
                            order = 4,
                            type = "description",
                            fontSize = "medium"
                        },
                        copy = {
                            name = L["COPY_OPTIONAL_ADDONS"],
                            desc = L["COPY_OPTIONAL_DESC"],
                            order = 5,
                            type = "execute",
                            func = function()
                                local I = MUI:GetModule("Installer")
                                if I and I.ShowWowUpOptional then
                                    I:ShowWowUpOptional()
                                end
                            end,
                            width = "full"
                        },
                        spacer2 = {
                            name = "\n",
                            order = 6,
                            type = "description"
                        },
                        list_header = {
                            name = format("|cff%s%s|r", C.HEX_DIM, L["OPTIONAL_ADDONS"]),
                            order = 7,
                            type = "header"
                        },
                        list = {
                            name = BuildAddonListString(D.WowUpOptionalList, C.HEX_DIM, ""),
                            order = 8,
                            type = "description",
                            fontSize = "medium"
                        }
                    }
                }
            }
        },
        debugger = {
            name = format("|cff%s%s|r", C.HEX_SOFT_RED, L["DEBUGGER"]),
            order = 4,
            type = "group",
            args = {
                desc = {
                    name = format("|cff%s%s|r\n", C.HEX_DIM, L["DEBUGGER_DESC"]),
                    order = 1,
                    type = "description",
                    fontSize = "medium"
                },
                status_header = {
                    name = format("|cff%s%s|r", C.HEX_BLUE, L["DEBUG_MODE_STATUS"]),
                    order = 2,
                    type = "header"
                },
                status = {
                    name = function()
                        if MUI:IsDebugModeActive() then
                            return L["DEBUG_MODE_ACTIVE"]
                        else
                            return L["DEBUG_MODE_INACTIVE"]
                        end
                    end,
                    order = 3,
                    type = "description",
                    fontSize = "medium"
                },
                spacer1 = {
                    name = "\n",
                    order = 4,
                    type = "description"
                },
                enable_debug = {
                    name = format("|cff%s%s|r", C.HEX_SOFT_RED, L["ENABLE_DEBUG_MODE"]),
                    desc = L["ENABLE_DEBUG_MODE_DESC"],
                    order = 5,
                    type = "execute",
                    func = function()
                        MUI:EnableDebugMode()
                    end,
                    width = "full",
                    hidden = function()
                        return MUI:IsDebugModeActive()
                    end
                },
                disable_debug = {
                    name = format("|cff%s%s|r", C.HEX_GREEN, L["DISABLE_DEBUG_MODE"]),
                    desc = L["DISABLE_DEBUG_MODE_DESC"],
                    order = 6,
                    type = "execute",
                    func = function()
                        MUI:DisableDebugMode()
                    end,
                    width = "full",
                    hidden = function()
                        return not MUI:IsDebugModeActive()
                    end
                }
            }
        }
    }
}
