local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

local format = format
local C = MUI.Colors

local function GetClassKey()
    local _, class = UnitClass("player")

    return class and strlower(class)
end

local function GetSpecName()
    local specIndex = GetSpecialization()

    if specIndex then
        local _, specName = GetSpecializationInfo(specIndex)

        return specName
    end
end

local function HasExistingClassLayouts()
    if not CooldownViewerSettings then return false end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager or not layoutManager.layouts then return false end

    for _, layout in pairs(layoutManager.layouts) do
        if layout then
            local layoutName = layout.layoutName or layout.name

            if layoutName and layoutName:find("MagguuUI - ", 1, true) == 1 then
                return true
            end
        end
    end

    return false
end

local function RemoveExistingClassLayouts()
    if not CooldownViewerSettings then return 0 end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager or not layoutManager.layouts then return 0 end

    local layouts = layoutManager.layouts
    if not next(layouts) then return 0 end

    local toRemove = {}

    for layoutID, layout in pairs(layouts) do
        if layout then
            local layoutName = layout.layoutName or layout.name

            if layoutName and layoutName:find("MagguuUI - ", 1, true) == 1 then
                toRemove[#toRemove + 1] = layoutID
            end
        end
    end

    if #toRemove == 0 then return 0 end

    table.sort(toRemove, function(a, b) return a > b end)

    for _, layoutID in ipairs(toRemove) do
        layoutManager.layouts[layoutID] = nil
    end

    local newLayouts = {}

    for _, layout in pairs(layoutManager.layouts) do
        if layout then
            newLayouts[#newLayouts + 1] = layout
            layout.layoutID = #newLayouts
        end
    end

    for k in pairs(layoutManager.layouts) do
        layoutManager.layouts[k] = nil
    end

    for i, layout in ipairs(newLayouts) do
        layoutManager.layouts[i] = layout
    end

    if layoutManager.SaveLayouts then
        pcall(function() layoutManager:SaveLayouts() end)
    end

    return #toRemove
end

local function ImportClassCooldowns()
    local D = MUI:GetModule("Data")

    if InCombatLockdown() then
        MUI:LogWarning("ClassCooldowns import blocked — in combat")
        return false
    end

    if not CooldownViewerSettings then
        MUI:LogWarning("CooldownViewerSettings not available — BCM not loaded")
        return false
    end

    local classKey = GetClassKey()
    local classData = D[classKey]

    if not classData then
        MUI:LogWarning(format("No class layout data for '%s'", classKey or "nil"))
        return false
    end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager then
        MUI:LogError("CooldownViewerSettings:GetLayoutManager() returned nil")
        return false
    end

    MUI:LogInfo(format("Importing class layouts for %s...", classKey))

    local removed = RemoveExistingClassLayouts()
    if removed > 0 then
        MUI:LogDebug(format("Removed %d existing class layout(s)", removed))
    end

    -- Import new layouts
    local specName = GetSpecName()
    local allLayoutIDs = {}

    if type(classData) == "table" then
        for _, specString in ipairs(classData) do
            if specString and specString ~= "" then
                local ok, layoutIDs = pcall(layoutManager.CreateLayoutsFromSerializedData, layoutManager, specString)

                if ok and layoutIDs then
                    for _, id in ipairs(layoutIDs) do
                        tinsert(allLayoutIDs, id)
                    end
                elseif not ok then
                    MUI:LogError(format("Class layout import error: %s", tostring(layoutIDs)))
                    MUI:Print(format("|cff%sClass layout import error:|r |cff%s%s|r", C.HEX_DIM, C.HEX_SOFT_RED, tostring(layoutIDs)))
                end
            end
        end
    else
        if classData == "" then return false end

        local ok, layoutIDs = pcall(layoutManager.CreateLayoutsFromSerializedData, layoutManager, classData)

        if ok and layoutIDs then
            allLayoutIDs = layoutIDs
        elseif not ok then
            MUI:LogError(format("Class layout import error: %s", tostring(layoutIDs)))
            MUI:Print(format("|cff%sClass layout import error:|r |cff%s%s|r", C.HEX_DIM, C.HEX_SOFT_RED, tostring(layoutIDs)))
        end
    end

    if #allLayoutIDs == 0 then
        MUI:LogWarning("No class layouts were imported (0 layout IDs)")
        return false
    end

    local activeLayoutID = allLayoutIDs[1]

    if specName and layoutManager.layouts then
        for _, layoutID in ipairs(allLayoutIDs) do
            local layout = layoutManager.layouts[layoutID]

            if layout and layout.name and layout.name:find(specName) then
                activeLayoutID = layoutID
                break
            end
        end
    end

    layoutManager:SetActiveLayoutByID(activeLayoutID)
    layoutManager:SaveLayouts()

    MUI:LogInfo(format("%d class layout(s) imported, active: %d", #allLayoutIDs, activeLayoutID))

    if StaticPopup1 and StaticPopup1:IsShown() and StaticPopup1Button2 then
        StaticPopup1Button2:Click()
    end

    return true
end

function SE.ClassCooldowns(addon)
    if ImportClassCooldowns() then
        SE.CompleteSetup(addon)
    end

    local layout = SE.FindEditModeLayout()

    if not layout then
        MUI:LogDebug("EditMode layout not found for ClassCooldowns")
        return
    end

    MUI:LogDebug(format("Activating EditMode layout %d for ClassCooldowns", layout))
    C_EditMode.SetActiveLayout(layout)
end

function SE.GetPlayerClassDisplayName()
    local _, className = UnitClass("player")

    return LOCALIZED_CLASS_NAMES_MALE[className] or className
end

function SE.HasExistingClassLayouts()
    return HasExistingClassLayouts()
end

function SE.IsClassLayoutActive()
    if not CooldownViewerSettings then return false end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager or not layoutManager.layouts then return false end

    local specName = GetSpecName()
    if not specName then return false end

    for _, layout in pairs(layoutManager.layouts) do
        if layout then
            local name = layout.layoutName or layout.name

            if name and name:find("MagguuUI - ", 1, true) == 1 and name:find(specName, 1, true) then
                return true
            end
        end
    end

    return false
end
