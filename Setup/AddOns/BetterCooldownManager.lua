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
        MUI:Print(format("|cff%sNo profile data found for|r |cff%s%s|r", C.HEX_DIM, C.HEX_BLUE, addon))
        return
    end

    if import then
        if not BCDMG then
            MUI:Print(format("|cff%sBetterCooldownManager API not available|r", C.HEX_DIM))
            return
        end

        BCDMG:ImportBCDM(D[profile], "MagguuUI")

        SE.CompleteSetup(addon)

        return
    end

    if not SE.IsProfileExisting(BCDMDB) then
        SE.RemoveFromDatabase(addon)

        return
    end

    db = LibStub("AceDB-3.0"):New("BCDMDB")

    db:SetProfile("MagguuUI")
end