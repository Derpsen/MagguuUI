local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local E

do
    if MUI:IsAddOnEnabled("ElvUI") then
        E = unpack(ElvUI)
    end
end

-- Shared helper: import private, global, aurafilters from elvdata via ElvUI Distributor
local function ApplyElvUIExtras(DI, elvdata)
    local keys = {"private", "global", "aurafilters"}

    for _, key in ipairs(keys) do
        if elvdata[key] and elvdata[key] ~= "" then
            local dataType, _, data = DI:Decode(elvdata[key])

            if data and type(data) == "table" then
                DI:SetImportedProfile(dataType, "MagguuUI", data, true)
            end
        end
    end
end

-- ============================================================
-- LibDualSpec: Disable before profile switch to prevent conflicts
-- (LibDualSpec can auto-switch profiles per spec, interfering with install)
-- ============================================================
local function DisableLibDualSpec()
    if not ElvDB or not ElvDB.namespaces then return end

    local lds = ElvDB.namespaces["LibDualSpec-1.0"]
    if not lds then return end

    local charKey = MUI.myname .. " - " .. GetRealmName()

    if not lds.char then lds.char = {} end
    if not lds.char[charKey] then lds.char[charKey] = {} end

    lds.char[charKey].enabled = false
    MUI:LogDebug("LibDualSpec disabled for", charKey)
end

-- ============================================================
-- WindTools: Apply MagguuUI-specific WT settings if installed
-- Uses MUI:DBSet() so renamed/removed keys are silently skipped
-- ============================================================
local function ApplyWindToolsSettings()
    if not MUI:IsAddOnEnabled("ElvUI_WindTools") then return end

    local Set = function(tbl, path, value)
        MUI:DBSet(tbl, path, value)
    end

    -- Skins
    Set(E.private, "WT.skins.shadow", false)
    Set(E.private, "WT.skins.removeParchment", false)
    Set(E.private, "WT.skins.elvui.auras", false)
    Set(E.private, "WT.skins.elvui.unitFrames", false)
    Set(E.private, "WT.skins.blizzard.cooldownViewer", false)
    Set(E.private, "WT.skins.cooldownViewer.enable", false)

    -- Minimap Buttons
    Set(E.private, "WT.maps.minimapButtons.backdrop", false)
    Set(E.private, "WT.maps.minimapButtons.mouseOver", true)

    -- Misc
    Set(E.private, "WT.misc.guildNewsItemLevel", false)
    Set(E.private, "WT.tooltips.progression.specialAchievement.enable", false)
    Set(E.private, "WT.tooltips.titleIcon.enable", false)
    Set(E.private, "WT.unitFrames.roleIcon.enable", false)

    MUI:LogInfo("WindTools settings applied")
end

local function ImportElvUI(addon)
    local D = MUI:GetModule("Data")
    local DI = E.Distributor
    local elvdata = D.elvui

    if not elvdata then
        MUI:Print("No ElvUI profile data found.")

        return
    end

    -- Support both new named-key format and old array format
    local profileString = elvdata.profile or elvdata[1]

    if not profileString then
        MUI:Print("No ElvUI profile data found.")

        return
    end

    -- Disable LibDualSpec before importing to prevent profile conflicts
    DisableLibDualSpec()

    -- 1) Import Profile
    local profileType, _, data = DI:Decode(profileString)

    if not data or type(data) ~= "table" then
        MUI:Print("Error decompressing profile. Please contact Magguu on Discord.")

        return
    end

    DI:SetImportedProfile(profileType, "MagguuUI", data, true)

    -- 2) Import Private, Global, Aura Filters
    ApplyElvUIExtras(DI, elvdata)

    SE.CompleteSetup(addon)
    pcall(E.SetupCVars, E, true)

    E.data.global.general.mapAlphaWhenMoving = 0.4
    E.data.global.general.UIScale = elvdata.uiscale or elvdata[2] or 0.6
    E.data.global.general.WorldMapCoordinates.position = "BOTTOM"
end

function SE.ElvUI(addon, import)
    if not E then return end

    if not import then
        if not SE.IsProfileExisting(ElvDB) then
            SE.RemoveFromDatabase(addon)

            return
        end

        -- Disable LibDualSpec before switching to prevent conflicts
        DisableLibDualSpec()

        -- Switch to the MagguuUI profile
        E.data:SetProfile("MagguuUI")

        -- Re-apply private, global, and aurafilters for this character
        local D = MUI:GetModule("Data")
        local DI = E.Distributor

        if D.elvui then
            ApplyElvUIExtras(DI, D.elvui)

            -- UI Scale
            E.data.global.general.UIScale = D.elvui.uiscale or D.elvui[2] or 0.6
        end
    else
        ImportElvUI(addon)
    end

    if MUI.Retail then
        E.private.general.chatBubbleFontSize = 10
        E.private.skins.blizzard.cooldownManager = false
    else
        E.private.general.chatBubbleFontSize = 11
    end

    E.private.general.chatBubbleFont = "Expressway"
    E.private.general.chatBubbleFontOutline = "OUTLINE"
    E.private.general.dmgfont = "Expressway"
    E.private.general.glossTex = "Melli"
    E.private.general.minimap.hideTracking = true
    E.private.general.namefont = "Expressway"
    E.private.general.normTex = "Melli"
    E.private.nameplates.enable = false

    -- Apply WindTools settings if installed (uses DBSet for fault-tolerance)
    ApplyWindToolsSettings()
end
