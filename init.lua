local _G = _G

local C_AddOns_GetAddOnEnableState = C_AddOns.GetAddOnEnableState

local AceAddon = _G.LibStub("AceAddon-3.0")

local AddOnName, Engine = ...
local MUI = AceAddon:NewAddon(AddOnName, "AceConsole-3.0")

Engine[1] = MUI
_G.MagguuUI = Engine

MUI.Data = MUI:NewModule("Data")
MUI.Installer = MUI:NewModule("Installer")
MUI.Setup = MUI:NewModule("Setup", "AceHook-3.0")

MUI.Retail = true

do
    function MUI:AddonCompartmentFunc(_, _, _, _, mouseButton)
        if mouseButton == "LeftButton" then
            MUI:ToggleInstaller()
        else
            MUI:ToggleSettings()
        end
    end

    _G.MagguuUI_AddonCompartmentFunc = MUI.AddonCompartmentFunc
end

function MUI:GetAddOnEnableState(addon, character)
    return C_AddOns_GetAddOnEnableState(addon, character)
end

function MUI:IsAddOnEnabled(addon)
    return MUI:GetAddOnEnableState(addon, MUI.myname) == 2
end

function MUI:OnEnable()
    MUI:Initialize()
    MUI:CreateMinimapButton()
end

function MUI:OnInitialize()
    self.db = _G.LibStub("AceDB-3.0"):New("MagguuDB")

    if self.db.global.version and type(self.db.global.version) == "number" then
        self.db:ResetDB()
    end

    self:RegisterChatCommand("mui", "HandleChatCommand")
    _G.LibStub("AceConfig-3.0"):RegisterOptionsTable("MagguuUI", self.options)

    self.category = select(2, _G.LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MagguuUI"))
end
