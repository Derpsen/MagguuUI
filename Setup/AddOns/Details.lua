local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format
local C = MUI.Colors

function SE.Details(addon, import, resolution)
    local D = MUI:GetModule("Data")

    local data, decompressedData
    local profile = "details" .. (resolution or "")
    local Details = Details

    if not D[profile] then
        MUI:LogWarning(format("No profile data for '%s' (key: %s)", addon, profile))
        MUI:Print(format("|cff%sNo profile data found for|r |cff%s%s|r", C.HEX_DIM, C.HEX_BLUE, addon))
        return
    end

    if import then
        if not DetailsFramework then
            MUI:LogError("DetailsFramework not available — Details not fully loaded")
            MUI:Print(format("|cff%sDetailsFramework not available|r", C.HEX_DIM))
            return
        end

        MUI:LogInfo(format("Importing %s profile...", addon))

        data = DetailsFramework:Trim(D[profile])
        decompressedData = Details:DecompressData(data, "print")

        if not decompressedData or not decompressedData.profile then
            MUI:LogError("Details DecompressData returned invalid data")
            MUI:Print(format("|cff%sError decompressing Details profile|r", C.HEX_SOFT_RED))
            return
        end

        Details:EraseProfile("MagguuUI")
        Details:ImportProfile(D[profile], "MagguuUI", false, false, true)

        -- Copy hide_on_context settings (safely iterate with nil checks)
        local instances = decompressedData.profile.instances
        if instances then
            for i, v in Details:ListInstances() do
                if instances[i] and instances[i].hide_on_context then
                    DetailsFramework.table.copy(v.hide_on_context, instances[i].hide_on_context)
                end
            end
        end

        SE.CompleteSetup(addon)
        MUI:LogInfo(format("%s profile imported", addon))
    else
        if not Details:GetProfile("MagguuUI") then
            MUI:LogDebug(format("%s profile not found, removing from database", addon))
            SE.RemoveFromDatabase(addon)

            return
        end

        MUI:LogInfo(format("Switching %s profile to MagguuUI", addon))
        Details:ApplyProfile("MagguuUI")
    end
end