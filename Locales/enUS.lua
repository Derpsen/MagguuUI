local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "enUS", true)

-- Minimap Tooltip
L["LEFT_CLICK"] = "Toggle Installer"
L["RIGHT_CLICK"] = "Toggle Settings"
L["MIDDLE_CLICK"] = "Toggle Changelog"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "Minimap button |cff00ff88enabled|r."
L["MINIMAP_DISABLED"] = "Minimap button |cffff4444disabled|r."

-- Chat Commands
L["COMBAT_ERROR"] = "Cannot run installer during combat."
L["AVAILABLE_COMMANDS"] = "Available commands:"
L["CMD_INSTALL"] = "Toggle the installer"
L["CMD_SETTINGS"] = "Toggle settings panel"
L["CMD_MINIMAP"] = "Toggle minimap button"
L["CMD_VERSION"] = "Show addon version"
L["CMD_STATUS"] = "Show installed profiles"
L["CMD_CHANGELOG"] = "Show changelog"
L["ADDON_STATUS"] = "Addon Status:"
L["STATUS_INSTALLED"] = "Installed"
L["STATUS_ENABLED_NOT_INSTALLED"] = "Enabled, not installed"
L["STATUS_NOT_ENABLED"] = "Not enabled"
L["NO_PROFILES_TO_LOAD"] = "No profiles to load."
L["NO_SUPPORTED_ADDONS"] = "No supported addons are enabled."

-- Profile Queue
L["INSTALLING"] = "Installing"
L["LOADING"] = "Loading"
L["ALL_PROFILES_INSTALLED"] = "All %d profiles installed."
L["ALL_PROFILES_LOADED"] = "All %d profiles loaded."

-- Popups
L["RELOAD_TEXT"] = "All profiles loaded successfully.\nClick Reload to apply your settings."
L["RELOAD_BUTTON"] = "Reload"
L["NEW_CHAR_TEXT"] = "Profiles have been installed on another character.\nWould you like to load all profiles onto this character?"
L["NEW_CHAR_LOAD_ALL"] = "Load All Profiles"
L["NEW_CHAR_SKIP"] = "Skip"
L["NEW_CHAR_APPLIED"] = "Profiles will be applied one at a time."
L["OVERWRITE_TEXT"] = "A profile named |cff4A8FD9MagguuUI|r already exists for |cffC0C8D4%s|r.\n\nDo you want to overwrite it?"
L["OVERWRITE_BUTTON"] = "Overwrite"
L["CANCEL"] = "Cancel"

-- Installer Pages
L["INSTALLATION"] = "Installation"
L["WELCOME_TO"] = "Welcome to"
L["INSTALL_ALL_DESC"] = "Click |cff4A8FD9Install All|r to set up all profiles at once, or click |cffC0C8D4Continue|r to install individually"
L["LOAD_PROFILES_INSTALLER_DESC"] = "Click |cff4A8FD9Load Profiles|r to apply your profiles, or click |cffC0C8D4Continue|r to reinstall individually"
L["OPTIMIZED_4K"] = "Optimized for 4K."
L["OTHER_RESOLUTIONS"] = "Other resolutions may need manual adjustments."
L["MISSING_ADDONS"] = "Missing addons? Copy a |cff4A8FD9WowUp|r import string:"
L["INSTALL_ALL"] = "Install All"
L["LOAD_PROFILES"] = "Load Profiles"
L["REQUIRED"] = "Required"
L["OPTIONAL"] = "Optional"
L["INSTALL"] = "Install"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "Enable ElvUI to unlock this step"
L["ELVUI_DESC1"] = "Complete UI replacement for action bars, unit frames, and more"
L["ELVUI_DESC2"] = "Pre-configured layout with clean, modern styling"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "Enable BetterCooldownManager to unlock this step"
L["BCM_DESC1"] = "Enhanced cooldown tracking with flexible bar layouts"
L["BCM_DESC2"] = "Pre-configured bars for spells, items, and trinkets"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "Enable BigWigs to unlock this step"
L["BIGWIGS_DESC1"] = "Lightweight boss mod with alerts, timers, and sounds"
L["BIGWIGS_DESC2"] = "Pre-configured bar positions and sound settings"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "Blizzard's built-in UI layout editor for HUD elements"
L["EDITMODE_DESC2"] = "Installs a pre-configured MagguuUI layout"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "Enable Details to unlock this step"
L["DETAILS_DESC1"] = "Real-time combat meter for damage, healing, and more"
L["DETAILS_DESC2"] = "Pre-configured window layout with clean styling"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "Enable Plater to unlock this step"
L["PLATER_DESC1"] = "Customizable nameplates with health and cast bars"
L["PLATER_DESC2"] = "Pre-configured with threat coloring and clean styling"
L["REQUIRES_RELOAD"] = "Requires a UI reload after installation"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "Class-specific layouts for"
L["CLASS_LAYOUTS_DESC2"] = "Auto-selects layout matching your active spec"
L["CLASS_LAYOUTS_DESC3"] = "Old layouts will be replaced automatically"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "Installation Complete"
L["COMPLETED_DESC1"] = "You have completed the installation process"
L["COMPLETED_DESC2"] = "Click |cffC0C8D4Reload|r to save your settings"

-- Installer: Step Titles
L["STEP_WELCOME"] = "Welcome"
L["STEP_COMPLETE"] = "Complete"
L["STEP_LAYOUTS"] = "Class Layouts"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "Profile: Active"
L["PROFILE_INSTALLED"] = "Profile: Installed"
L["PROFILE_NOT_INSTALLED"] = "Profile: Not installed"

-- WowUp Popup
L["COPY_HINT"] = "Click the text below to select all, then press |cffC0C8D4Ctrl+C|r to copy"
L["COPIED"] = "Copied!"
L["CLOSE"] = "Close"
L["NO_WOWUP_STRING"] = "No WowUp string configured"
L["NO_REQUIRED_STRING"] = "No required addons string configured"
L["NO_OPTIONAL_STRING"] = "No optional addons string configured"

-- URL Popup
L["PRESS_CTRL_C"] = "Press |cffC0C8D4Ctrl+C|r to copy"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "Show Minimap Button"
L["SHOW_MINIMAP_BUTTON_DESC"] = "Toggle the minimap button on or off"
L["SHOW_CHANGELOG_ON_UPDATE"] = "Show Changelog on Update"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "Show the changelog popup when a new version is detected"

-- Settings: Installer
L["INSTALLER_DESC"] = "Install or load MagguuUI profiles for all supported addons."
L["RESOLUTION_NOTICE"] = "Optimized for 4K (3840x2160)."
L["RESOLUTION_NOTICE_SUB"] = "Other resolutions may need manual adjustments."
L["OPEN_INSTALLER"] = "Open Installer"
L["OPEN_INSTALLER_DESC"] = "Opens the MagguuUI step-by-step installation wizard"
L["INSTALL_ALL_PROFILES"] = "Install All Profiles"
L["INSTALL_ALL_PROFILES_DESC"] = "Install all MagguuUI profiles at once (ElvUI, BCM, EditMode, Details, Plater)"
L["LOAD_PROFILES_BUTTON"] = "Load Profiles"
L["LOAD_PROFILES_DESC"] = "Load previously saved profiles on this character"
L["PROFILE_STATUS"] = "Profile Status"

-- Settings: Profile Status
L["ACTIVE"] = "Active"
L["NOT_INSTALLED"] = "Not installed"
L["NOT_ENABLED"] = "Not enabled"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "Addon Import"
L["WOWUP_DESC"] = "MagguuUI uses several addons. You can install them using |cff4A8FD9WowUp|r's import feature."
L["WOWUP_REQUIRED_DESC"] = "Core addons needed for MagguuUI"
L["WOWUP_OPTIONAL_DESC"] = "Extra addons for the best experience"
L["WOWUP_HOW_TO"] = "How to use"
L["COPY_REQUIRED_ADDONS"] = "Copy Required Addons"
L["COPY_REQUIRED_DESC"] = "Opens a popup with the WowUp import string for required addons"
L["COPY_OPTIONAL_ADDONS"] = "Copy Optional Addons"
L["COPY_OPTIONAL_DESC"] = "Opens a popup with the WowUp import string for optional addons"
L["REQUIRED_ADDONS"] = "Required Addons"
L["OPTIONAL_ADDONS"] = "Optional Addons"
L["NO_ADDON_DATA"] = "No addon data available."
L["NO_ADDON_DATA_RELOAD"] = "No addon data available. Run /reload after updating."

-- Settings: Information
L["AUTHOR"] = "Author"
L["LINKS_SUPPORT"] = "Links & Support"
L["WEBSITE"] = "Website"
L["OPEN_WEBSITE"] = "Open Website"
L["OPEN_WEBSITE_DESC"] = "Copies the website URL to your clipboard"
L["LICENSE"] = "License"
L["VERSION_INFO"] = "Version Info"
L["ADDON_STATUS_HEADER"] = "Addon Status"
L["SHOW_CHANGELOG"] = "Show Changelog"
L["SHOW_CHANGELOG_DESC"] = "Show what changed in recent updates"

-- Changelog
L["WHATS_NEW"] = "What's new in this update"
L["GOT_IT"] = "Got it!"
L["GOT_IT_DESC"] = "Mark as read — the changelog popup won't show for this version on next login."
L["RELEASED"] = "Released"

-- Settings: Debugger
L["DEBUGGER"] = "Debugger"
L["DEBUGGER_DESC"] = "Troubleshoot issues by temporarily disabling all addons except ElvUI and MagguuUI."
L["DEBUG_MODE_STATUS"] = "Debug Mode Status"
L["DEBUG_MODE_ACTIVE"] = "Debug mode is currently |cff00ff88active|r. Only essential addons are loaded."
L["DEBUG_MODE_INACTIVE"] = "Debug mode is |cffff4444inactive|r. All addons are loaded normally."
L["ENABLE_DEBUG_MODE"] = "Enable Debug Mode"
L["ENABLE_DEBUG_MODE_DESC"] = "Disables all addons except ElvUI + MagguuUI and reloads the UI. Use this to check if a problem is caused by another addon."
L["DISABLE_DEBUG_MODE"] = "Disable Debug Mode"
L["DISABLE_DEBUG_MODE_DESC"] = "Re-enables all previously disabled addons and reloads the UI."
L["DEBUG_ENABLED_COUNT"] = "%d addons disabled. Reloading..."
L["DEBUG_DISABLED_COUNT"] = "%d addons re-enabled. Reloading..."
L["DEBUG_ALREADY_ACTIVE"] = "Debug mode is already active."
L["DEBUG_NOT_ACTIVE"] = "Debug mode is not active."
L["DEBUG_STARTUP_WARNING"] = "Debug mode is active — only essential addons are loaded. Type |cff4A8FD9/mui debug|r to exit."
L["CMD_DEBUG"] = "Toggle debug mode"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "Profiles"
L["SETTINGS"] = "Settings"
L["SETUP_ADDON"] = "Setup %s"
L["SUCCESS"] = "Success"
L["YOUR_CLASS"] = "your class"
