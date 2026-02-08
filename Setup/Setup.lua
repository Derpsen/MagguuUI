local MUI = unpack(MagguuUI)
local SE = MUI:GetModule("Setup")

StaticPopupDialogs["MAGGUUI_OVERWRITE_PROFILE"] = {
    text = "A profile named |cff4A8FD9MagguuUI|r already exists for |cffC0C8D4%s|r.\n\nDo you want to overwrite it?",
    button1 = "Overwrite",
    button2 = "Cancel",
    OnAccept = function(self)
        if self.data and self.data.callback then
            self.data.callback()
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function SE:Setup(addon, ...)
    local setup = self[addon]

    setup(addon, ...)
end

function SE:SetupWithConfirmation(addon, ...)
    local args = {...}

    if self:ProfileExistsForAddon(addon) then
        local dialog = StaticPopup_Show("MAGGUUI_OVERWRITE_PROFILE", addon)

        if dialog then
            dialog.data = {
                callback = function()
                    SE:Setup(addon, unpack(args))
                end
            }
        end
    else
        self:Setup(addon, unpack(args))
    end
end

function SE:ProfileExistsForAddon(addon)
    if addon == "ElvUI" then
        return MUI:IsAddOnEnabled("ElvUI") and self.IsProfileExisting(ElvDB)
    elseif addon == "Plater" then
        return MUI:IsAddOnEnabled("Plater") and self.IsProfileExisting(PlaterDB)
    elseif addon == "BigWigs" then
        return MUI:IsAddOnEnabled("BigWigs") and self.IsProfileExisting(BigWigs3DB)
    elseif addon == "Details" then
        if MUI:IsAddOnEnabled("Details") and Details then
            return Details:GetProfile("MagguuUI") ~= nil
        end
    elseif addon == "Blizzard_EditMode" then
        if C_EditMode then
            local layouts = C_EditMode.GetLayouts()

            for _, v in ipairs(layouts.layouts) do
                if v.layoutName == "MagguuUI" then
                    return true
                end
            end
        end
    elseif addon == "BetterCooldownManager" then
        return MUI:IsAddOnEnabled("BetterCooldownManager") and BetterCooldownManagerDB and self.IsProfileExisting(BetterCooldownManagerDB)
    end

    return false
end

function SE.CompleteSetup(addon)
    local PluginInstallStepComplete = PluginInstallStepComplete

    if PluginInstallStepComplete then
        if PluginInstallStepComplete:IsShown() then
            PluginInstallStepComplete:Hide()
        end

        PluginInstallStepComplete.message = "Success"

        PluginInstallStepComplete:Show()
    end

    if not MUI.db.global.profiles then
        MUI.db.global.profiles = {}
    end

    MUI.db.global.profiles[addon] = true
end

function SE.IsProfileExisting(table)
    local db = LibStub("AceDB-3.0"):New(table)
    local profiles = db:GetProfiles()

    for i = 1, #profiles do
        if profiles[i] == "MagguuUI" then

            return true
        end
    end
end

function SE.RemoveFromDatabase(addon)
    MUI.db.global.profiles[addon] = nil

    if MUI.db.global.profiles and #MUI.db.global.profiles == 0 then
        for k in pairs(MUI.db.char) do
            k = nil
        end

        MUI.db.global.profiles = nil
    end
end
