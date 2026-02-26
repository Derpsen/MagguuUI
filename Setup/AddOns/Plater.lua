local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format
local C = MUI.Colors

local function ImportPlater(addon, resolution)
    local D = MUI:GetModule("Data")

    local Plater = Plater
    local profile = "plater" .. (resolution or "")

    if not D[profile] then
        MUI:LogWarning(format("No profile data for '%s' (key: %s)", addon, profile))
        MUI:Print(format("|cff%sNo profile data found for|r |cff%s%s|r", C.HEX_DIM, C.HEX_BLUE, addon))
        return
    end

    MUI:LogInfo(format("Importing %s profile...", addon))

    local data = Plater.DecompressData(D[profile], "print")

    if not data then
        MUI:LogError("Plater DecompressData returned nil")
        MUI:Print(format("|cff%sError decompressing Plater profile|r", C.HEX_SOFT_RED))
        return
    end

    if not SE:IsHooked(Plater, "OnProfileCreated") then
        SE:RawHook(Plater, "OnProfileCreated", function()
            C_Timer.After(MUI.Constants.PLATER_RELOAD_DELAY, function()
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
    MUI:LogInfo(format("%s profile imported", addon))
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
            MUI:LogDebug(format("%s profile not found in DB, removing from database", addon))
            SE.RemoveFromDatabase(addon)

            return
        end

        MUI:LogInfo(format("Switching %s profile to MagguuUI", addon))
        Plater.db:SetProfile("MagguuUI")
    end
end