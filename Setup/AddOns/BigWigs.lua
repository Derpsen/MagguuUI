local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format
local C = MUI.Colors

local function ImportBigWigs(addon, resolution)
    local D = MUI:GetModule("Data")

    local profile = "bigwigs" .. (resolution or "")

    if not D[profile] then
        MUI:LogWarning(format("No profile data for '%s' (key: %s)", addon, profile))
        MUI:Print(format("|cff%sNo profile data found for|r |cff%s%s|r", C.HEX_DIM, C.HEX_BLUE, addon))
        return
    end

    MUI:LogInfo(format("Importing %s profile...", addon))

    local ok, err = pcall(BigWigsAPI.RegisterProfile, "BigWigs", D[profile], "MagguuUI", function(callback)
        if not callback then
            MUI:LogDebug("BigWigs import cancelled by user")
            -- User clicked Cancel
            if MUI._bigWigsReloadPending then
                MUI._bigWigsReloadPending = nil

                StaticPopup_Show("MAGGUUI_RELOAD")
            end

            return
        end

        SE.CompleteSetup(addon)
        MUI:LogInfo(format("%s profile imported", addon))

        -- If a batch install was waiting for BigWigs to finish
        if MUI._bigWigsReloadPending then
            MUI._bigWigsReloadPending = nil

            StaticPopup_Show("MAGGUUI_RELOAD")
        end
    end)

    if not ok then
        MUI:LogError(format("BigWigs import failed: %s", tostring(err)))
        MUI:Print(format("|cff%sImport error:|r |cff%s%s|r", C.HEX_SOFT_RED, C.HEX_DIM, tostring(err)))

        -- Still show reload popup if batch was pending
        if MUI._bigWigsReloadPending then
            MUI._bigWigsReloadPending = nil
            StaticPopup_Show("MAGGUUI_RELOAD")
        end
    end
end

function SE.BigWigs(addon, import, resolution)
    local BigWigs3DB = BigWigs3DB
    local db

    if import then
        if not BigWigsAPI then
            MUI:LogError("BigWigsAPI not available — addon not fully loaded")
            MUI:Print(format("|cff%sBigWigs API not available yet — try again after /reload|r", C.HEX_DIM))
            return
        end

        ImportBigWigs(addon, resolution)
    else
        if not SE.IsProfileExisting(BigWigs3DB) then
            MUI:LogDebug(format("%s profile not found in DB, removing from database", addon))
            SE.RemoveFromDatabase(addon)

            return
        end

        MUI:LogInfo(format("Switching %s profile to MagguuUI", addon))
        db = LibStub("AceDB-3.0"):New("BigWigs3DB")

        db:SetProfile("MagguuUI")
    end
end