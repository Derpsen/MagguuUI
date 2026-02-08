local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local function ImportPlater(addon, resolution)
    local D = MUI:GetModule("Data")

    local Plater = Plater
    local profile = "plater" .. (resolution or "")
    local data = Plater.DecompressData(D[profile], "print")

    if not SE:IsHooked(Plater, "OnProfileCreated") then
        SE:RawHook(Plater, "OnProfileCreated", function()
            C_Timer.After (.5, function()
                Plater.ImportScriptsFromLibrary()
                Plater.ApplyPatches()
                Plater.CompileAllScripts("script")
                Plater.CompileAllScripts("hook")
                
                Plater:RefreshConfig()
                Plater.UpdatePlateClickSpace()
            end)
        end)
    end

    SE.CompleteSetup(addon)
    Plater.ImportAndSwitchProfile("MagguuUI", data, false, false, true, true)

    MUI.db.char.loaded = true
    MUI.db.global.version = MUI.version
end

function SE.Plater(addon, import, resolution)
    local Plater = Plater

    if not SE:IsHooked(Plater, "RefreshConfigProfileChanged") then
        SE:RawHook(Plater, "RefreshConfigProfileChanged", function() Plater:RefreshConfig() end)
    end

    if import then
        ImportPlater(addon, resolution)
    else
        if not SE.IsProfileExisting(PlaterDB) then
            SE.RemoveFromDatabase(addon)

            return
        end

        Plater.db:SetProfile("MagguuUI")
    end
end