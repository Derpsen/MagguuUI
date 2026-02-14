# 📋 Changelog

All notable changes to MagguuUI will be documented in this file.

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
