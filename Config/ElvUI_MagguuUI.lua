local MUI = unpack(MagguuUI)

if not MUI:IsAddOnEnabled("ElvUI") then return end

local E, L, V, P, G = unpack(ElvUI)
local EP = E.Libs.EP -- ElvUI Plugin Library

local format = format
local gsub = string.gsub
local ipairs = ipairs
local pairs = pairs
local tostring = tostring
local tonumber = tonumber
local tinsert = tinsert

local C = MUI.Colors
local ML = LibStub("AceLocale-3.0"):GetLocale("MagguuUI")

-- Gradient text helper (interpolates hex colors per character)
local function GradientText(text, hexFrom, hexTo)
    local len = #text
    if len == 0 then return "" end
    if len == 1 then return format("|cff%s%s|r", hexFrom, text) end

    local r1, g1, b1 = tonumber(hexFrom:sub(1,2), 16), tonumber(hexFrom:sub(3,4), 16), tonumber(hexFrom:sub(5,6), 16)
    local r2, g2, b2 = tonumber(hexTo:sub(1,2), 16), tonumber(hexTo:sub(3,4), 16), tonumber(hexTo:sub(5,6), 16)

    local result = ""
    for i = 1, len do
        local t = (i - 1) / (len - 1)
        local r = math.floor(r1 + (r2 - r1) * t + 0.5)
        local g = math.floor(g1 + (g2 - g1) * t + 0.5)
        local b = math.floor(b1 + (b2 - b1) * t + 0.5)
        result = result .. format("|cff%02x%02x%02x%s|r", r, g, b, text:sub(i, i))
    end

    return result
end

-- Icon paths (replace nil with custom icon paths when ready)
local ICONS = {
    installer   = nil, -- "Interface\\AddOns\\MagguuUI\\Media\\Textures\\Icons\\Installer"
    settings    = nil, -- "Interface\\AddOns\\MagguuUI\\Media\\Textures\\Icons\\Settings"
    information = nil, -- "Interface\\AddOns\\MagguuUI\\Media\\Textures\\Icons\\Information"
}

-- ============================================================
-- Build Changelog Sub-Tab (with version select dropdown)
-- ============================================================
local CHANGELOG_CATEGORIES = {
    { key = "NEW",         label = "New",         color = C.HEX_GREEN },
    { key = "IMPROVEMENT", label = "Improvement",  color = C.HEX_YELLOW },
    { key = "BUGFIX",      label = "Bug Fixes",    color = C.HEX_SOFT_RED },
}

local function renderChangeLogLine(line)
    -- Highlight [bracketed] text in blue
    line = gsub(line, "%[([^%]]+)%]", function(text)
        return "|cff" .. C.HEX_BLUE .. "[" .. text .. "]|r"
    end)
    return line
end

local function BuildChangelogOptions()
    if not MUI.Changelog then return {} end

    local changelogArgs = {}

    for version, data in pairs(MUI.Changelog) do
        local versionString = format("%d.%d.%d",
            math.floor(version / 10000),
            math.floor((version % 10000) / 100),
            version % 100
        )
        local changelogVer = version
        local dateString = data.RELEASE_DATE or ""

        local page = {}

        -- Date line
        page.date = {
            order = 1,
            type = "description",
            name = format("|cff%s%s %s|r", C.HEX_DIM, dateString, ML["RELEASED"]),
            fontSize = "small",
        }

        -- Version title
        page.version = {
            order = 2,
            type = "description",
            name = "|cff" .. C.HEX_DIM .. "Version|r |cff" .. C.HEX_BLUE .. versionString .. "|r",
            fontSize = "large",
        }

        -- Build categorized entries
        local entryOrder = 3
        for _, cat in ipairs(CHANGELOG_CATEGORIES) do
            local entries = data[cat.key]
            if entries and #entries > 0 then
                page[cat.key .. "Header"] = {
                    order = entryOrder,
                    type = "header",
                    name = "|cff" .. cat.color .. cat.label .. "|r",
                }
                entryOrder = entryOrder + 1

                page[cat.key .. "Entries"] = {
                    order = entryOrder,
                    type = "description",
                    name = function()
                        local text = ""
                        for index, line in ipairs(entries) do
                            text = text .. format("%02d", index) .. ". " .. renderChangeLogLine(line) .. "\n"
                        end
                        return text .. "\n"
                    end,
                    fontSize = "medium",
                }
                entryOrder = entryOrder + 1
            end
        end

        -- "Got it!" confirmation (hidden once read)
        local function isChangelogRead()
            local dbVer = MUI.db and MUI.db.global and MUI.db.global.changelogRead
            if not dbVer then return false end
            -- Handle legacy string values from older versions
            dbVer = tonumber(dbVer) or 0
            return dbVer >= changelogVer
        end

        page.beforeConfirm1 = {
            order = 90,
            type = "description",
            name = " ",
            width = "full",
            hidden = isChangelogRead,
        }

        page.beforeConfirm2 = {
            order = 91,
            type = "description",
            name = " ",
            width = "full",
            hidden = isChangelogRead,
        }

        page.confirm = {
            order = 92,
            type = "execute",
            name = format("|cff%s%s|r", C.HEX_GREEN, ML["GOT_IT"]),
            desc = ML["GOT_IT_DESC"],
            width = "full",
            hidden = isChangelogRead,
            func = function()
                if MUI.db and MUI.db.global then
                    MUI.db.global.changelogRead = changelogVer
                end
            end,
        }

        changelogArgs[tostring(version)] = {
            order = 1000000 - version,
            name = versionString,
            type = "group",
            args = page,
        }
    end

    return changelogArgs
end

-- ============================================================
-- Add MagguuUI to ElvUI Options Menu
-- ============================================================
local function InsertMagguuUIOptions()
    if not E.Options or not E.Options.args then return end

    -- Update ElvUI options title bar to show MagguuUI (guard against duplicate appending)
    if not MUI._optionsPatched then
        E.Options.name = format(
            "%s + %s |cff" .. C.HEX_BLUE .. "%s|r",
            E.Options.name,
            MUI.title,
            MUI.version or ""
        )
        MUI._optionsPatched = true
    end

    E.Options.args.magguuui = {
        type = "group",
        childGroups = "tree",
        name = MUI.title,
        order = 100,
        args = {
            -- ========================================
            -- Logo + Title (shown above tree entries)
            -- ========================================
            logo = {
                order = 0,
                type = "description",
                name = "",
                image = "Interface\\AddOns\\MagguuUI\\Media\\Textures\\LogoTop",
                imageWidth = 256,
                imageHeight = 128,
            },
            title = {
                order = 0.1,
                type = "description",
                name = format("\n%s |cff%s%s|r\n", MUI.title, C.HEX_DIM, MUI.version or ""),
                fontSize = "large",
            },

            -- ========================================
            -- 1. Installer (Tree Entry)
            -- ========================================
            installer = {
                order = 1,
                type = "group",
                name = GradientText("Installer", C.HEX_BLUE, C.HEX_SILVER),
                icon = ICONS.installer,
                args = {
                    desc = {
                        order = 1,
                        type = "description",
                        name = format("|cff%s%s|r\n", C.HEX_DIM, ML["INSTALLER_DESC"]),
                        fontSize = "medium",
                    },
                    resolution_notice = {
                        order = 1.5,
                        type = "description",
                        name = format("|cff%s%s|r |cff%s%s|r\n", C.HEX_YELLOW, ML["RESOLUTION_NOTICE"], C.HEX_DIM, ML["RESOLUTION_NOTICE_SUB"]),
                        fontSize = "medium",
                    },
                    run_installer = {
                        order = 2,
                        type = "execute",
                        name = ML["OPEN_INSTALLER"],
                        desc = ML["OPEN_INSTALLER_DESC"],
                        func = function()
                            MUI:RunInstaller()
                        end,
                        width = "full",
                    },
                    spacer1 = {
                        order = 3,
                        type = "description",
                        name = " ",
                    },
                    install_all = {
                        order = 4,
                        type = "execute",
                        name = ML["INSTALL_ALL_PROFILES"],
                        desc = ML["INSTALL_ALL_PROFILES_DESC"],
                        func = function()
                            MUI:ProcessProfileQueue(true, MUI.INSTALL_ORDER)
                        end,
                        width = "full",
                        disabled = function()
                            return MUI.db.global.profiles ~= nil
                        end,
                    },
                    load_profiles = {
                        order = 5,
                        type = "execute",
                        name = ML["LOAD_PROFILES_BUTTON"],
                        desc = ML["LOAD_PROFILES_DESC"],
                        func = function()
                            MUI:LoadProfiles()
                        end,
                        width = "full",
                        disabled = function()
                            return not MUI.db.global.profiles
                        end,
                    },
                    spacer2 = {
                        order = 6,
                        type = "description",
                        name = "\n",
                    },
                    status_header = {
                        order = 7,
                        type = "header",
                        name = format("|cff%s%s|r", C.HEX_BLUE, ML["PROFILE_STATUS"]),
                    },
                    addon_status = {
                        order = 8,
                        type = "description",
                        name = function()
                            local lines = {}
                            for _, addon in ipairs(MUI.STATUS_ADDONS) do
                                local enabled = MUI:IsAddOnEnabled(addon)
                                local installed = MUI.db.global.profiles
                                    and MUI.db.global.profiles[addon]
                                local icon, state

                                if not enabled then
                                    icon = format("|cff%s--|r", C.HEX_DARK)
                                    state = format("|cff%s%s|r", C.HEX_DARK, ML["NOT_ENABLED"])
                                elseif installed then
                                    -- Check if MagguuUI profile is currently active
                                    local SE = MUI:GetModule("Setup")
                                    local active = SE and SE.IsProfileActive and SE.IsProfileActive(addon)

                                    if active then
                                        icon = format("|cff%s+|r", C.HEX_GREEN)
                                        state = format("|cff%s%s|r", C.HEX_GREEN, ML["ACTIVE"])
                                    else
                                        icon = format("|cff%s+|r", C.HEX_GREEN)
                                        state = format("|cff%s%s|r", C.HEX_GREEN, ML["STATUS_INSTALLED"])
                                    end
                                else
                                    icon = format("|cff%so|r", C.HEX_SOFT_RED)
                                    state = format("|cff%s%s|r", C.HEX_SOFT_RED, ML["NOT_INSTALLED"])
                                end
                                tinsert(lines, format(
                                    "  %s  |cff%s%s|r  %s",
                                    icon, C.HEX_SILVER, addon, state
                                ))
                            end
                            return table.concat(lines, "\n")
                        end,
                        fontSize = "medium",
                    },
                },
            },

            -- ========================================
            -- 2. Settings (Tree Entry with Sub-Tabs)
            -- ========================================
            settings = {
                order = 2,
                type = "group",
                childGroups = "tab",
                name = GradientText("Settings", C.HEX_BLUE, C.HEX_SILVER),
                icon = ICONS.settings,
                args = {
                    -- Tab: General
                    general = {
                        order = 1,
                        type = "group",
                        name = "General",
                        args = {
                            minimap_toggle = {
                                order = 1,
                                type = "toggle",
                                name = ML["SHOW_MINIMAP_BUTTON"],
                                desc = ML["SHOW_MINIMAP_BUTTON_DESC"],
                                get = function()
                                    return not (MUI.db.global.minimap and MUI.db.global.minimap.hide)
                                end,
                                set = function()
                                    MUI:ToggleMinimapButton()
                                end,
                                width = "full",
                            },
                            spacer1 = {
                                order = 2,
                                type = "description",
                                name = "\n",
                            },
                            changelog_popup = {
                                order = 3,
                                type = "toggle",
                                name = ML["SHOW_CHANGELOG_ON_UPDATE"],
                                desc = ML["SHOW_CHANGELOG_ON_UPDATE_DESC"],
                                get = function()
                                    if not MUI.db or not MUI.db.global then return true end
                                    return MUI.db.global.changelogDismissed ~= MUI.version
                                end,
                                set = function(_, val)
                                    if not MUI.db or not MUI.db.global then return end
                                    if val then
                                        MUI.db.global.changelogDismissed = nil
                                    else
                                        MUI.db.global.changelogDismissed = MUI.version
                                    end
                                end,
                                width = "full",
                            },
                        },
                    },

                    -- Tab: WowUp Import
                    wowup = {
                        order = 2,
                        type = "group",
                        name = format("|cff%sWowUp|r %s", C.HEX_BLUE, ML["WOWUP_ADDON_IMPORT"]),
                        args = {
                            desc = {
                                order = 1,
                                type = "description",
                                name = format("|cff%s%s|r\n\n", C.HEX_DIM, ML["WOWUP_DESC"])
                                    .. format("|cff%s%s|r |cff%s— %s|r\n", C.HEX_SOFT_RED, ML["REQUIRED"], C.HEX_DIM, ML["WOWUP_REQUIRED_DESC"])
                                    .. format("|cff%s%s — %s|r\n", C.HEX_DIM, ML["OPTIONAL"], ML["WOWUP_OPTIONAL_DESC"]),
                                fontSize = "medium",
                            },
                            howto_header = {
                                order = 2,
                                type = "header",
                                name = format("|cff%s%s|r", C.HEX_BLUE, ML["WOWUP_HOW_TO"]),
                            },
                            howto = {
                                order = 3,
                                type = "description",
                                name = format("|cff%s", C.HEX_DIM)
                                    .. format("1. Click|r |cff%sRequired|r |cff%sor|r Optional |cff%sbelow|r\n", C.HEX_SOFT_RED, C.HEX_DIM, C.HEX_DIM)
                                    .. format("|cff%s2. The string is selected — press|r |cff%sCtrl+C|r |cff%sto copy|r\n", C.HEX_DIM, C.HEX_SILVER, C.HEX_DIM)
                                    .. format("|cff%s3. Open|r |cff%sWowUp|r |cff%s> More > Import/Export Addons|r\n", C.HEX_DIM, C.HEX_BLUE, C.HEX_DIM)
                                    .. format("|cff%s4. Switch to|r |cff%sImport|r|cff%s, paste, click|r |cff%sInstall|r\n", C.HEX_DIM, C.HEX_SILVER, C.HEX_DIM, C.HEX_BLUE),
                                fontSize = "medium",
                            },
                            spacer1 = {
                                order = 4,
                                type = "description",
                                name = " ",
                            },
                            copy_required = {
                                order = 5,
                                type = "execute",
                                name = format("|cff%s%s|r", C.HEX_SOFT_RED, ML["COPY_REQUIRED_ADDONS"]),
                                desc = ML["COPY_REQUIRED_DESC"],
                                func = function()
                                    local I = MUI:GetModule("Installer")
                                    if I and I.ShowWowUpRequired then
                                        I:ShowWowUpRequired()
                                    end
                                end,
                                width = 1.5,
                            },
                            copy_optional = {
                                order = 6,
                                type = "execute",
                                name = ML["COPY_OPTIONAL_ADDONS"],
                                desc = ML["COPY_OPTIONAL_DESC"],
                                func = function()
                                    local I = MUI:GetModule("Installer")
                                    if I and I.ShowWowUpOptional then
                                        I:ShowWowUpOptional()
                                    end
                                end,
                                width = 1.5,
                            },
                            spacer2 = {
                                order = 7,
                                type = "description",
                                name = "\n",
                            },
                            required_header = {
                                order = 8,
                                type = "header",
                                name = format("|cff%s%s|r", C.HEX_SOFT_RED, ML["REQUIRED_ADDONS"]),
                            },
                            required_list = {
                                order = 9,
                                type = "description",
                                name = function()
                                    local D = MUI:GetModule("Data")
                                    if not D or not D.WowUpRequiredList or #D.WowUpRequiredList == 0 then
                                        return format("|cff%s%s|r", C.HEX_DARK, ML["NO_ADDON_DATA"])
                                    end
                                    local lines = {}
                                    for _, name in ipairs(D.WowUpRequiredList) do
                                        tinsert(lines, format("  |cff%s%s|r", C.HEX_BLUE, name))
                                    end
                                    return table.concat(lines, "\n")
                                end,
                                fontSize = "medium",
                            },
                            spacer3 = {
                                order = 10,
                                type = "description",
                                name = " ",
                            },
                            optional_header = {
                                order = 11,
                                type = "header",
                                name = format("|cff%s%s|r", C.HEX_DIM, ML["OPTIONAL_ADDONS"]),
                            },
                            optional_list = {
                                order = 12,
                                type = "description",
                                name = function()
                                    local D = MUI:GetModule("Data")
                                    if not D or not D.WowUpOptionalList or #D.WowUpOptionalList == 0 then
                                        return format("|cff%s%s|r", C.HEX_DARK, ML["NO_ADDON_DATA"])
                                    end
                                    local lines = {}
                                    for _, name in ipairs(D.WowUpOptionalList) do
                                        tinsert(lines, format("  |cff%s%s|r", C.HEX_SILVER, name))
                                    end
                                    return table.concat(lines, "\n")
                                end,
                                fontSize = "medium",
                            },
                        },
                    },
                },
            },

            -- ========================================
            -- 3. Information (Tree Entry with Sub-Tabs)
            --    Tabs: About, Changelog, System
            -- ========================================
            information = {
                order = 3,
                type = "group",
                childGroups = "tab",
                name = GradientText("Information", C.HEX_BLUE, C.HEX_SILVER),
                icon = ICONS.information,
                args = {
                    -- Tab: About
                    about = {
                        order = 1,
                        type = "group",
                        name = "About",
                        args = {
                            author_header = {
                                order = 1,
                                type = "header",
                                name = format("|cff%s%s|r", C.HEX_BLUE, ML["AUTHOR"]),
                            },
                            author = {
                                order = 2,
                                type = "description",
                                name = format("|cff%sMagguu|r", C.HEX_BLUE),
                                fontSize = "medium",
                            },
                            spacer1 = {
                                order = 3,
                                type = "description",
                                name = " ",
                            },
                            links_header = {
                                order = 4,
                                type = "header",
                                name = format("|cff%s%s|r", C.HEX_BLUE, ML["LINKS_SUPPORT"]),
                            },
                            website = {
                                order = 5,
                                type = "execute",
                                name = format("%s  |cff%sui.magguu.xyz|r", ML["WEBSITE"], C.HEX_BLUE),
                                desc = ML["OPEN_WEBSITE_DESC"],
                                func = function()
                                    MUI:ShowURLPopup(
                                        format("|cff%sWebsite|r", C.HEX_BLUE),
                                        "https://ui.magguu.xyz"
                                    )
                                end,
                                width = 1.5,
                            },
                            curseforge = {
                                order = 6,
                                type = "execute",
                                name = "CurseForge",
                                desc = "Copy the CurseForge project URL",
                                func = function()
                                    MUI:ShowURLPopup(
                                        format("|cff%sCurseForge|r", C.HEX_BLUE),
                                        "https://www.curseforge.com/wow/addons/magguuui"
                                    )
                                end,
                                width = 1.5,
                            },
                            spacer2 = {
                                order = 7,
                                type = "description",
                                name = " ",
                            },
                            license_header = {
                                order = 8,
                                type = "header",
                                name = format("|cff%s%s|r", C.HEX_BLUE, ML["LICENSE"]),
                            },
                            license = {
                                order = 9,
                                type = "description",
                                name = format("|cff%sGNU General Public License v3.0|r", C.HEX_DIM),
                                fontSize = "medium",
                            },
                        },
                    },

                    -- Tab: Changelog (with version dropdown — built lazily)
                    changelog = {
                        order = 2,
                        type = "group",
                        childGroups = "select",
                        name = "Changelog",
                        args = {},
                    },

                    -- Tab: System
                    system = {
                        order = 3,
                        type = "group",
                        name = "System",
                        args = {
                            version_header = {
                                order = 1,
                                type = "header",
                                name = format("|cff%s%s|r", C.HEX_BLUE, ML["VERSION_INFO"]),
                            },
                            magguuui_ver = {
                                order = 2,
                                type = "description",
                                name = function()
                                    return format(
                                        "  |cff%sMagguuUI|r  |cff%s%s|r",
                                        C.HEX_SILVER, C.HEX_BLUE, MUI.version or "Unknown"
                                    )
                                end,
                                fontSize = "medium",
                            },
                            elvui_ver = {
                                order = 3,
                                type = "description",
                                name = function()
                                    return format(
                                        "  |cff%sElvUI|r  |cff%s%s|r",
                                        C.HEX_SILVER, C.HEX_BLUE, E.version or "Unknown"
                                    )
                                end,
                                fontSize = "medium",
                            },
                            wow_ver = {
                                order = 4,
                                type = "description",
                                name = function()
                                    local version, build = GetBuildInfo()
                                    return format(
                                        "  |cff%sWoW|r  |cff%s%s|r |cff%s(Build %s)|r",
                                        C.HEX_SILVER, C.HEX_BLUE, version, C.HEX_DARK, build
                                    )
                                end,
                                fontSize = "medium",
                            },
                            spacer1 = {
                                order = 5,
                                type = "description",
                                name = "\n",
                            },
                            addons_header = {
                                order = 6,
                                type = "header",
                                name = format("|cff%s%s|r", C.HEX_BLUE, ML["ADDON_STATUS_HEADER"]),
                            },
                            addon_status = {
                                order = 7,
                                type = "description",
                                name = function()
                                    local lines = {}
                                    for _, addon in ipairs(MUI.SYSTEM_ADDONS) do
                                        local enabled = MUI:IsAddOnEnabled(addon)
                                        local icon = enabled
                                            and format("|cff%s+|r", C.HEX_GREEN)
                                            or format("|cff%sx|r", C.HEX_SOFT_RED)
                                        local ver = enabled
                                            and (C_AddOns.GetAddOnMetadata(addon, "Version") or "")
                                            or ""
                                        local verStr = ver ~= ""
                                            and format("  |cff%s%s|r", C.HEX_DIM, ver)
                                            or ""
                                        tinsert(lines, format(
                                            "  %s  |cff%s%s|r%s",
                                            icon, C.HEX_SILVER, addon, verStr
                                        ))
                                    end
                                    return table.concat(lines, "\n")
                                end,
                                fontSize = "medium",
                            },
                        },
                    },
                },
            },
        },
    }
end

-- ============================================================
-- Plugin Initialization Callback
-- ============================================================
local function InitializePlugin()
    InsertMagguuUIOptions()

    -- Fill changelog args now that Changelog.lua is loaded
    local clArgs = E.Options.args.magguuui
        and E.Options.args.magguuui.args.information
        and E.Options.args.magguuui.args.information.args.changelog
    if clArgs then
        clArgs.args = BuildChangelogOptions()
    end
end

-- ============================================================
-- Register with ElvUI Plugin System
-- ============================================================
if EP then
    local versionString = format("%s %s", MUI.title, MUI.version or "1.0.0")
    EP:RegisterPlugin("MagguuUI", InitializePlugin, nil, versionString)
else
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:SetScript("OnEvent", function(self, event)
        C_Timer.After(1, InitializePlugin)
        self:UnregisterAllEvents()
    end)
end
