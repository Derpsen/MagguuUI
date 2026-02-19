local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format

function SE.BetterCooldownManager(addon, import, resolution)
    local D = MUI:GetModule("Data")

    local profile = "bettercooldownmanager" .. (resolution or "")
    local BCDMDB = BCDMDB
    local db

    if not D[profile] then
        MUI:Print(format("|cff999999No profile data found for|r |cff4A8FD9%s|r", addon))
        return
    end

    if import then
        if not BCDMDB then
            MUI:Print(format("|cff999999BetterCooldownManager data not available for|r |cff4A8FD9%s|r", addon))
            return
        end

        BCDMDB:ImportBCDM(D[profile], "MagguuUI")

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