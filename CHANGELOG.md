# 📋 Changelog

All notable changes to MagguuUI will be documented in this file.

## 🔧 v12.0.8 — Class Layouts & Installer Redesign (2026-02-19)

### ✨ Added

- 🎯 **Class Layouts** integrated into **Install All** and **Load Profiles** queue
- 🎨 **Class and spec names** shown in class colors on Class Layouts installer page

### 📝 Changed

- 📄 Installer pages reformatted with cleaner multi-line descriptions
- 🔄 Class Layouts replaces old layouts instead of duplicating on reinstall
- 🌐 STEP_LAYOUTS renamed to "Class Layouts" in all 11 locales

### 🛠️ Fixed

- 🐛 Load Profiles now correctly checks addon dependencies for ClassCooldowns
- 🐛 Replaced hardcoded hex color codes with MUI.Colors.HEX_* constants
- 🐛 Fixed locale key for Ignore button

## 🔧 v12.0.7 — Localization, Minimap & Profile Status (2026-02-18)

### ✨ Added

- 🌍 **Localization** support (9 languages) via AceLocale-3.0 (EN, DE, FR, ES, PT, IT, RU, KO, ZH)
- 🗺️ **LibDataBroker minimap button** replaces custom implementation (standard LibDBIcon dragging)
- 🟢 **Active profile status** on installer pages 2-8 (green/yellow/red)
- ⚠️ **Reinstall warning** on Character Layouts page (delete old layouts manually)

### 📝 Changed

- 🌐 All user-facing strings use locale keys instead of hardcoded text
- 📊 Profile status shown in Settings panel with color coding
- 🔴 Not installed profiles now shown in red instead of gray
- 🧹 Removed unused color constants and dead locale keys

### 🛠️ Fixed

- 🐛 BCM profile status always showed "Not installed" (wrong SavedVariable name)
- 🐛 Duplicate LOAD_PROFILES_DESC locale key caused wrong text
- 🐛 embeds.xml used Include instead of Script for .lua library files
- 🐛 Settings title showed "vv12.0.x" instead of "v12.0.x"

## 🔧 v12.0.6 — Update Flow (2026-02-15)

### 📝 Changed

- 📝 Changelog [Got it!] opens installer automatically on version update

## 🔧 v12.0.5 — Bugfix & Profile Update (2026-02-15)

### 📝 Changed

- 🔄 Installer detects version updates and requires Install All before Load Profiles
- 🔢 Version strings with v-prefix handled correctly everywhere
- 🔄 Updated addon profiles (ElvUI, Plater, Details, BCM, EditMode)

### 🛠️ Fixed

- 🐛 Changelog popup showed "vv12.0.4" instead of "v12.0.4"
- 🐛 Changelog popup did not appear when upgrading from older versions

## 🔧 v12.0.4 — Settings & Popup Overhaul (2026-02-14)

### ✨ Added

- 🌳 **Tree layout with sub-tabs** in ElvUI settings (Installer / Settings / Information)
- 🖱️ **Minimap middle-click** toggles Changelog popup
- 🖱️ **Minimap right-click** opens ElvUI settings directly to MagguuUI section
- 🔗 **URL copy popup** for Website and CurseForge links
- 📦 **WowUp strings** split into Required and Optional
- 📝 **Changelog popup** on version update with version select in ElvUI settings
- 📋 **Changelog tab** in ElvUI settings with categorized entries, version dropdown, and "I got it!" button

### 📝 Changed

- 🎨 All popups now match Installer design (ElvUI Transparent template)
- 🗂️ Settings restructured into tree navigation with sub-tabs
- 📐 Scroll frames use fully relative anchoring (no hardcoded pixel offsets)
- 📦 Installer buttons: Required (red) / Optional (gray)
- 🔗 Unified URL copy popup across all settings (ElvUI and standalone share the same popup)
- ⚙️ Standalone Blizzard settings hidden when ElvUI is active (ElvUI handles everything)
- 🧹 Removed dead code and unused variables across all files
- 📁 Config files restructured into Config/ folder (Options, Changelog, ElvUI_MagguuUI)

### 🛠️ Fixed

- 🔗 URL copy buttons in Settings now work reliably
- 🖱️ ElvUI config navigation via right-click
- 🐛 Fixed changelog data format (no more tinsert errors)
- 🐛 Fixed version comparison for changelog read status (number vs string)

## 🔧 v12.0.3 — Patch (2026-02-09)

### 📝 Changed

- 🖼️ Updated **Blizzard EditMode** profile string

## 🔧 v12.0.2 — Update (2026-02-09)

### ✨ Added

- 🔗 **ElvUI_Anchor** as recommended optional dependency for frame positioning
- 📋 **Version info** displayed in Settings panel
- 🌐 **Website link** with copy-to-clipboard popup in Settings
- 🖥️ Custom styled popups for URL and WowUp string (dark theme, blue accent)
- 📋 **Copy feedback** — popups show "Copied!" and auto-close after pressing Ctrl+C

### 🛠️ Fixed

- ❌ Removed broken Accept button from WowUp settings page
- 📋 WowUp string in Settings now opens the styled popup (no more empty input field)
- 🌐 Website URL popup works reliably (replaced broken StaticPopup with custom frame)

### 📝 Changed

- 📄 License changed to **GNU General Public License v3.0 (GPLv3)**
- 🔢 Version scheme changed to **12.0.x** to reflect WoW Retail compatibility
- 📦 WowUp popup: removed Copy button, Close button centered, click-to-select
- 🏷️ Version now uses `@project-version@` for automatic versioning via packager
- 📋 Updated README, CurseForge description, and all metadata

## 🔧 v12.0.1 — Patch (2026-02-09)

### ✨ Added

- 🔧 **ElvUI WindTools** as optional dependency
- 🌐 Website link to **ui.magguu.xyz** for class-specific cooldown layouts
- 📖 BCM installer step now references ui.magguu.xyz

### 🛠️ Fixed

- 🔗 ElvUI download link corrected to `tukui.org/elvui`
- 🧹 Removed leftover HidingBar code from settings

### 📝 Changed

- 📋 Changelog and README redesigned with emojis
- 📄 Updated addon list to include WindTools

## 🎉 v12.0.0 — Initial Release (2026-02-08)

### ✨ Features

- 🚀 One-click **Install All** to apply every profile at once
- 📖 Guided step-by-step installer for individual addon setup
- 🔄 Automatic profile loading for new characters
- 📦 WowUp import string to quickly install all required addons
- 🗺️ Minimap button with drag-to-reposition
- 🧩 Addon Compartment integration (left-click = installer, right-click = settings)
- 💬 Chat commands: `/mui install`, `/mui settings`, `/mui minimap`, `/mui version`, `/mui status`

### 🎨 Supported Addon Profiles

- 🖥️ **ElvUI** — Full profile including private, global, and aura filters
- ⚔️ **Plater** — Customized nameplates with threat coloring
- 🔔 **BigWigs** — Boss encounter alerts and timers
- 📊 **Details!** — Damage and healing meter layout
- ⏱️ **BetterCooldownManager** — Cooldown tracking bars
- 🔧 **ElvUI WindTools** — Enhanced skins, animations, and QoL features
- 🖼️ **Blizzard EditMode** — Optimized HUD layout

### 🛡️ Quality of Life

- ⚠️ Overwrite confirmation before replacing existing profiles
- 🔍 Automatic addon detection — disabled addons are skipped
- 🔃 Safe reload system — Reload button instead of auto-reload
- 🎯 BigWigs installs last to handle its Accept popup correctly
- 💙 Custom MagguuUI branding (blue/silver theme)
