local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local E

do
    if MUI:IsAddOnEnabled("ElvUI") then
        E = unpack(ElvUI)
    end
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

    -- 1) Import Profile
    local profileType, _, data = DI:Decode(profileString)

    if not data or type(data) ~= "table" then
        MUI:Print("Error decompressing profile. Please contact Magguu on Discord.")

        return
    end

    DI:SetImportedProfile(profileType, "MagguuUI", data, true)

    -- 2) Import Private (Character Settings)
    if elvdata.private and elvdata.private ~= "" then
        local privType, _, privData = DI:Decode(elvdata.private)

        if privData and type(privData) == "table" then
            DI:SetImportedProfile(privType, "MagguuUI", privData, true)
        end
    end

    -- 3) Import Global Settings
    if elvdata.global and elvdata.global ~= "" then
        local globType, _, globData = DI:Decode(elvdata.global)

        if globData and type(globData) == "table" then
            DI:SetImportedProfile(globType, "MagguuUI", globData, true)
        end
    end

    -- 4) Import Aura Filters
    if elvdata.aurafilters and elvdata.aurafilters ~= "" then
        local filterType, _, filterData = DI:Decode(elvdata.aurafilters)

        if filterData and type(filterData) == "table" then
            DI:SetImportedProfile(filterType, "MagguuUI", filterData, true)
        end
    end

    SE.CompleteSetup(addon)
    E:SetupCVars(true)

    E.data.global.general.mapAlphaWhenMoving = 0.4
    E.data.global.general.UIScale = elvdata.uiscale or elvdata[2] or 0.6
    E.data.global.general.WorldMapCoordinates.position = "BOTTOM"

    MUI.db.char.loaded = true
    MUI.db.global.version = MUI.version
end

function SE.ElvUI(addon, import)
    if not E then return end

    if not import then
        if not SE.IsProfileExisting(ElvDB) then
            SE.RemoveFromDatabase(addon)

            return
        end

        -- Switch to the MagguuUI profile
        E.data:SetProfile("MagguuUI")

        -- Re-apply private, global, and aurafilters for this character
        local D = MUI:GetModule("Data")
        local DI = E.Distributor

        if D.elvui then
            -- Private (per-character, must be applied on every new char)
            if D.elvui.private and D.elvui.private ~= "" then
                local privType, _, privData = DI:Decode(D.elvui.private)

                if privData and type(privData) == "table" then
                    DI:SetImportedProfile(privType, "MagguuUI", privData, true)
                end
            end

            -- Global settings
            if D.elvui.global and D.elvui.global ~= "" then
                local globType, _, globData = DI:Decode(D.elvui.global)

                if globData and type(globData) == "table" then
                    DI:SetImportedProfile(globType, "MagguuUI", globData, true)
                end
            end

            -- Aura Filters
            if D.elvui.aurafilters and D.elvui.aurafilters ~= "" then
                local filterType, _, filterData = DI:Decode(D.elvui.aurafilters)

                if filterData and type(filterData) == "table" then
                    DI:SetImportedProfile(filterType, "MagguuUI", filterData, true)
                end
            end

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
end
