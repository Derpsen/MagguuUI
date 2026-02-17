local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

function SE.Details(addon, import, resolution)
    local D = MUI:GetModule("Data")

    local data, decompressedData
    local profile = "details" .. (resolution or "")
    local Details = Details

    if not D[profile] then
        MUI:Print(format("|cff999999No profile data found for|r |cff4A8FD9%s|r", addon))
        return
    end

    if import then
        data = DetailsFramework:Trim(D[profile])
        decompressedData = Details:DecompressData(data, "print")

        Details:EraseProfile("MagguuUI")
        Details:ImportProfile(D[profile], "MagguuUI", false, false, true)

        for i, v in Details:ListInstances() do
            DetailsFramework.table.copy(v.hide_on_context, decompressedData.profile.instances[i].hide_on_context)
        end

        SE.CompleteSetup(addon)
    else
        if not Details:GetProfile("MagguuUI") then
            SE.RemoveFromDatabase(addon)

            return
        end

        Details:ApplyProfile("MagguuUI")
    end
end