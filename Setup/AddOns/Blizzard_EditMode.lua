local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format
local C = MUI.Colors
local C_EditMode, Enum = C_EditMode, Enum

local function IsLayoutExisting()
    local layouts = C_EditMode.GetLayouts()

    for i, v in ipairs(layouts.layouts) do
        if v.layoutName == "MagguuUI" then

            return Enum.EditModePresetLayoutsMeta.NumValues + i
        end
    end
end

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
        MUI:Print(format("|cff%sNo profile data found for|r |cff%s%s|r", C.HEX_DIM, C.HEX_BLUE, addon))
        return
    end

    info = C_EditMode.ConvertStringToLayoutInfo(D[layout])
    info.layoutName = "MagguuUI"
    info.layoutType = Enum.EditModeLayoutType.Account

    tinsert(layouts.layouts, info)
    C_EditMode.SaveLayouts(layouts)

    SE.CompleteSetup(addon)
end

function SE.Blizzard_EditMode(addon, import, resolution)
    local layout

    if import then
        ImportBlizzard_EditMode(addon, resolution)
    end

    layout = IsLayoutExisting()

    if not layout then
        SE.RemoveFromDatabase(addon)

        return
    end

    C_EditMode.SetActiveLayout(layout)
end