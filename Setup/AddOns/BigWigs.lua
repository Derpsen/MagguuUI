local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local function ImportBigWigs(addon, resolution)
    local D = MUI:GetModule("Data")

    local profile = "bigwigs" .. (resolution or "")

    BigWigsAPI.RegisterProfile("BigWigs", D[profile], "MagguuUI", function(callback)
        if not callback then
            -- User clicked Cancel
            if MUI._bigWigsReloadPending then
                MUI._bigWigsReloadPending = nil

                StaticPopup_Show("MAGGUUI_RELOAD")
            end

            return
        end

        SE.CompleteSetup(addon)

        MUI.db.char.loaded = true
        MUI.db.global.version = MUI.version

        -- If a batch install was waiting for BigWigs to finish
        if MUI._bigWigsReloadPending then
            MUI._bigWigsReloadPending = nil

            StaticPopup_Show("MAGGUUI_RELOAD")
        end
    end)
end

function SE.BigWigs(addon, import, resolution)
    local BigWigs3DB = BigWigs3DB
    local db

    if import then
        ImportBigWigs(addon, resolution)
    else
        if not SE.IsProfileExisting(BigWigs3DB) then
            SE.RemoveFromDatabase(addon)

            return
        end

        db = LibStub("AceDB-3.0"):New(BigWigs3DB)

        db:SetProfile("MagguuUI")
    end
end