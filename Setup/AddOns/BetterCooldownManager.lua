local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format
local C = MUI.Colors

function SE.BetterCooldownManager(addon, import, resolution)
    local D = MUI:GetModule("Data")

    local profile = "bettercooldownmanager" .. (resolution or "")
    local BCDMDB = BCDMDB
    local db

    if not D[profile] then
        MUI:LogWarning(format("No profile data for '%s' (key: %s)", addon, profile))
        MUI:Print(format("|cff%sNo profile data found for|r |cff%s%s|r", C.HEX_DIM, C.HEX_BLUE, addon))
        return
    end

    if import then
        if not BCDMG then
            MUI:LogError("BCDMG API not available — BetterCooldownManager not fully loaded")
            MUI:Print(format("|cff%sBetterCooldownManager API not available|r", C.HEX_DIM))
            return
        end

        MUI:LogInfo(format("Importing %s profile...", addon))

        local ok, err = pcall(BCDMG.ImportBCDM, BCDMG, D[profile], "MagguuUI")

        if not ok then
            MUI:LogError(format("BCM import failed: %s", tostring(err)))
            MUI:Print(format("|cff%sImport error:|r |cff%s%s|r", C.HEX_SOFT_RED, C.HEX_DIM, tostring(err)))
            return
        end

        SE.CompleteSetup(addon)
        MUI:LogInfo(format("%s profile imported", addon))

        return
    end

    if not SE.IsProfileExisting(BCDMDB) then
        MUI:LogDebug(format("%s profile not found in DB, removing from database", addon))
        SE.RemoveFromDatabase(addon)

        return
    end

    MUI:LogInfo(format("Switching %s profile to MagguuUI", addon))
    db = LibStub("AceDB-3.0"):New("BCDMDB")

    db:SetProfile("MagguuUI")
end