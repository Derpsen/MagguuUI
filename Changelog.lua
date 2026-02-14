local MUI = unpack(MagguuUI)

-- ============================================================
-- Changelog Data (newest first)
-- ============================================================
local CHANGELOG = {
    {
        version = "12.0.4",
        date = "2026-02-10",
        title = "WowUp Split & Changelog",
        entries = {
            "|cff00ff88New:|r WowUp strings split into |cffFF6666Required|r and |cff999999Optional|r",
            "|cff00ff88New:|r Changelog popup on version update",
            "|cff00ff88New:|r Updated addon lists in Settings",
            "|cffFFFF00Changed:|r WowUp description explains Required vs Optional",
            "|cffFFFF00Changed:|r Installer buttons: |cffFF6666Required|r (red) / |cff999999Optional|r (gray)",
        }
    },
    {
        version = "12.0.3",
        date = "2026-02-09",
        title = "EditMode Update",
        entries = {
            "|cffFFFF00Changed:|r Updated Blizzard EditMode profile string",
        }
    },
    {
        version = "12.0.2",
        date = "2026-02-09",
        title = "Settings Overhaul",
        entries = {
            "|cff00ff88New:|r ElvUI_Anchor as recommended dependency",
            "|cff00ff88New:|r Version info in Settings",
            "|cff00ff88New:|r Website link with copy popup",
            "|cff00ff88New:|r Copy feedback — popups show |cff00ff88Copied!|r and auto-close",
            "|cffFF6666Fixed:|r Removed broken Accept button from WowUp settings",
            "|cffFF6666Fixed:|r Website URL popup now works reliably",
            "|cffFFFF00Changed:|r License to GPLv3",
            "|cffFFFF00Changed:|r Version scheme to 12.0.x",
        }
    },
    {
        version = "12.0.1",
        date = "2026-02-09",
        title = "Patch",
        entries = {
            "|cff00ff88New:|r ElvUI WindTools as optional dependency",
            "|cff00ff88New:|r Website link for class-specific BCM layouts",
            "|cffFF6666Fixed:|r ElvUI download link corrected",
        }
    },
    {
        version = "12.0.0",
        date = "2026-02-08",
        title = "Initial Release",
        entries = {
            "|cff00ff88New:|r One-click Install All",
            "|cff00ff88New:|r Guided step-by-step installer",
            "|cff00ff88New:|r Automatic profile loading for new characters",
            "|cff00ff88New:|r WowUp import string",
            "|cff00ff88New:|r Minimap button & Addon Compartment",
            "|cff00ff88New:|r Chat commands: /mui install, settings, minimap, version, status",
        }
    },
}

-- Use centralized colors
local C = MUI.Colors
local BLUE = C.BLUE
local POPUP_BG = C.POPUP_BG
local POPUP_BORDER = C.POPUP_BORDER
local CONTENT_BG = C.CONTENT_BG

-- ============================================================
-- Build changelog text for display
-- ============================================================
local function BuildChangelogText(fromVersion)
    local lines = {}

    for _, entry in ipairs(CHANGELOG) do
        -- Show the latest version always, or all versions newer than lastSeen
        if not fromVersion or entry.version > fromVersion or entry.version == CHANGELOG[1].version then
            tinsert(lines, format("|cff4A8FD9v%s|r |cff666666— %s|r |cffC0C8D4%s|r", entry.version, entry.date, entry.title))
            tinsert(lines, "")

            for _, text in ipairs(entry.entries) do
                tinsert(lines, "  • " .. text)
            end

            tinsert(lines, "")
            tinsert(lines, "")
        end
    end

    return table.concat(lines, "\n")
end

-- ============================================================
-- Changelog Popup
-- ============================================================
local function GetOrCreateChangelogPopup()
    if MUI.ChangelogPopup then return MUI.ChangelogPopup end

    local popup = CreateFrame("Frame", "MagguuUIChangelogPopup", UIParent, "BackdropTemplate")
    popup:SetSize(500, 420)
    popup:SetPoint("CENTER")
    popup:SetFrameStrata("FULLSCREEN_DIALOG")
    popup:SetFrameLevel(500)
    popup:SetMovable(true)
    popup:EnableMouse(true)
    popup:RegisterForDrag("LeftButton")
    popup:SetScript("OnDragStart", popup.StartMoving)
    popup:SetScript("OnDragStop", popup.StopMovingOrSizing)

    popup:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    popup:SetBackdropColor(POPUP_BG[1], POPUP_BG[2], POPUP_BG[3], 0.98)
    popup:SetBackdropBorderColor(POPUP_BORDER[1], POPUP_BORDER[2], POPUP_BORDER[3], 1)

    -- Accent line top
    local accent = popup:CreateTexture(nil, "OVERLAY")
    accent:SetHeight(2)
    accent:SetPoint("TOPLEFT", popup, "TOPLEFT", 0, 0)
    accent:SetPoint("TOPRIGHT", popup, "TOPRIGHT", 0, 0)
    accent:SetColorTexture(BLUE[1], BLUE[2], BLUE[3], 1)

    -- Title
    local title = popup:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", popup, "TOP", 0, -16)
    popup.title = title

    -- Subtitle
    local subtitle = popup:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    subtitle:SetPoint("TOP", title, "BOTTOM", 0, -4)
    subtitle:SetText("|cff999999What's new in this update|r")

    -- ScrollFrame
    local scrollFrame = CreateFrame("ScrollFrame", nil, popup, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", popup, "TOPLEFT", 14, -58)
    scrollFrame:SetPoint("BOTTOMRIGHT", popup, "BOTTOMRIGHT", -32, 50)

    -- Scrollframe backdrop
    local sfBg = CreateFrame("Frame", nil, popup, "BackdropTemplate")
    sfBg:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", -4, 4)
    sfBg:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 20, -4)
    sfBg:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    sfBg:SetBackdropColor(CONTENT_BG[1], CONTENT_BG[2], CONTENT_BG[3], 1)
    sfBg:SetBackdropBorderColor(POPUP_BORDER[1], POPUP_BORDER[2], POPUP_BORDER[3], 1)
    sfBg:SetFrameLevel(popup:GetFrameLevel() + 1)
    scrollFrame:SetFrameLevel(sfBg:GetFrameLevel() + 1)

    -- Content text
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetWidth(scrollFrame:GetWidth() - 10)
    content:SetHeight(1)

    local text = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    text:SetPoint("TOPLEFT", content, "TOPLEFT", 8, -8)
    text:SetPoint("TOPRIGHT", content, "TOPRIGHT", -8, -8)
    text:SetJustifyH("LEFT")
    text:SetJustifyV("TOP")
    text:SetSpacing(3)

    scrollFrame:SetScrollChild(content)
    popup.content = content
    popup.text = text

    -- Close button
    local closeBtn = CreateFrame("Button", nil, popup, "UIPanelButtonTemplate")
    closeBtn:SetSize(120, 26)
    closeBtn:SetPoint("BOTTOM", popup, "BOTTOM", 0, 12)
    closeBtn:SetText("|cffC0C8D4Got it!|r")
    closeBtn:SetScript("OnClick", function() popup:Hide() end)

    -- ESC to close
    tinsert(UISpecialFrames, "MagguuUIChangelogPopup")

    popup:Hide()
    MUI.ChangelogPopup = popup

    return popup
end

local function ShowChangelog(fromVersion)
    local popup = GetOrCreateChangelogPopup()
    local version = MUI.version or "Unknown"

    popup.title:SetText(format("|cff4A8FD9MagguuUI|r |cffC0C8D4v%s|r", version))

    local changelogText = BuildChangelogText(fromVersion)
    popup.text:SetText(changelogText)

    -- Resize content frame to fit text
    C_Timer.After(0.01, function()
        local textHeight = popup.text:GetStringHeight() + 16
        popup.content:SetHeight(textHeight)
    end)

    popup:Show()
    popup:Raise()
end

-- ============================================================
-- Version Check on Login
-- ============================================================
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, isInitialLogin, isReloadingUi)
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")

    -- Wait a moment for UI to settle
    C_Timer.After(2, function()
        if not MUI.db or not MUI.db.global then return end

        local currentVersion = MUI.version
        local lastSeen = MUI.db.global.lastSeenVersion

        if not currentVersion then return end

        -- Don't show on first ever install (installer handles that)
        if not lastSeen then
            MUI.db.global.lastSeenVersion = currentVersion

            return
        end

        -- Show changelog if version changed
        if lastSeen ~= currentVersion then
            ShowChangelog(lastSeen)
            MUI.db.global.lastSeenVersion = currentVersion
        end
    end)
end)

-- ============================================================
-- Manual access via chat command or settings
-- ============================================================
function MUI:ShowChangelog()
    ShowChangelog(nil)
end
