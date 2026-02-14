local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

function SE.BetterCooldownManager(addon, import, resolution)
    local D = MUI:GetModule("Data")

    local profile = "bettercooldownmanager" .. (resolution or "")
    local BCDMDB = BCDMDB
    local db

    if import then
        BCDMG:ImportBCDM(D[profile], "MagguuUI")

        SE.CompleteSetup(addon)

        return
    end

    if not SE.IsProfileExisting(BCDMDB) then
        SE.RemoveFromDatabase(addon)

        return
    end

    db = LibStub("AceDB-3.0"):New(BCDMDB)

    db:SetProfile("MagguuUI")
end