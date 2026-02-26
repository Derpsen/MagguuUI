local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format
local C = MUI.Colors
local C_EditMode, Enum = C_EditMode, Enum

local function ImportBlizzard_EditMode(addon, resolution)
    local D = MUI:GetModule("Data")

    local layouts, info
    local layout = "blizzardeditmode" .. (resolution or "")

    layouts = C_EditMode.GetLayouts()

    for i = #layouts.layouts, 1, -1 do
        if layouts.layouts[i].layoutName == "MagguuUI" then
            tremove(layouts.layouts, i)
        end
    end

    if not D[layout] then
        MUI:LogWarning(format("No profile data for '%s' (key: %s)", addon, layout))
        MUI:Print(format("|cff%sNo profile data found for|r |cff%s%s|r", C.HEX_DIM, C.HEX_BLUE, addon))
        return
    end

    MUI:LogInfo(format("Importing %s layout...", addon))

    local ok, result = pcall(C_EditMode.ConvertStringToLayoutInfo, D[layout])

    if not ok or not result then
        MUI:LogError(format("EditMode ConvertStringToLayoutInfo failed: %s", tostring(result)))
        MUI:Print(format("|cff%sError converting EditMode layout data|r", C.HEX_SOFT_RED))
        return
    end

    info = result
    info.layoutName = "MagguuUI"
    info.layoutType = Enum.EditModeLayoutType.Account

    tinsert(layouts.layouts, info)

    local saveOk, saveErr = pcall(C_EditMode.SaveLayouts, layouts)

    if not saveOk then
        MUI:LogError(format("EditMode SaveLayouts failed: %s", tostring(saveErr)))
        MUI:Print(format("|cff%sError saving EditMode layouts|r", C.HEX_SOFT_RED))
        return
    end

    SE.CompleteSetup(addon)
    MUI:LogInfo(format("%s layout imported", addon))
end

function SE.Blizzard_EditMode(addon, import, resolution)
    local layout

    if import then
        ImportBlizzard_EditMode(addon, resolution)
    end

    layout = SE.FindEditModeLayout()

    if not layout then
        MUI:LogDebug("EditMode layout 'MagguuUI' not found, removing from database")
        SE.RemoveFromDatabase(addon)

        return
    end

    MUI:LogDebug(format("Activating EditMode layout %d", layout))
    C_EditMode.SetActiveLayout(layout)
end