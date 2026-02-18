<div align="center">

<img src="https://raw.githubusercontent.com/Derpsen/MagguuUI/main/Media/Textures/LogoTop.png" width="256" alt="MagguuUI Logo">

# MagguuUI

**A pre-configured World of Warcraft UI — install, click, play.**

[![WoW Version](https://img.shields.io/badge/WoW-12.0%2B-blue?style=flat-square&logo=battle.net&logoColor=white)](https://worldofwarcraft.blizzard.com)
[![Resolution](https://img.shields.io/badge/Optimized-4K%20(3840%C3%972160)-blueviolet?style=flat-square)](https://ui.magguu.xyz)
[![Website](https://img.shields.io/badge/Website-ui.magguu.xyz-4A8FD9?style=flat-square)](https://ui.magguu.xyz)
[![License](https://img.shields.io/badge/License-GPLv3-green?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0.html)

> **Optimized for 4K (3840x2160).** Other resolutions may need manual adjustments.

---

</div>

## ✨ Features

| | Feature | Description |
|---|---|---|
| 🚀 | **One-Click Installation** | Install all addon profiles at once or step by step |
| 🎭 | **Character Layouts** | Class-specific layouts that auto-select based on your spec |
| 🔄 | **Automatic Profile Loading** | New characters automatically receive all profiles |
| 📦 | **WowUp Integration** | Built-in export string to install all addons via WowUp |
| 🗺️ | **Minimap Button** | Quick access to installer and settings |
| 📋 | **Changelog Popup** | See what's new after every update |

## 🧩 Supported Addons

| Addon | Description |
|:------|:------------|
| 🔷 **ElvUI** | Complete UI replacement (action bars, unit frames, and more) |
| ⏱️ **BetterCooldownManager** | Enhanced cooldown tracking with flexible bar layouts |
| 🐉 **BigWigs** | Lightweight boss mod with alerts, timers, and sounds |
| 📊 **Details!** | Real-time combat meter for damage, healing, and encounters |
| 🏷️ **Plater** | Customizable nameplates with threat coloring and scripting |
| 🖼️ **Blizzard EditMode** | Optimized layout for Blizzard's built-in HUD editor |
| 🎯 **Character Layouts** | Class-specific layouts for all 13 classes |

## 📥 Installation

```
1.  Install ElvUI          →  tukui.org/elvui
2.  Install MagguuUI       →  CurseForge / Wago / WowInterface
3.  Install ElvUI_Anchor   →  CurseForge (recommended)
4.  Log in                 →  Installer opens automatically
5.  Click "Install All"    →  All profiles applied at once
6.  Click "Reload"         →  Done!
```

## ⚙️ Requirements

| | Addon | Status |
|---|---|---|
| ✅ | **ElvUI** | Required — [Download](https://tukui.org/elvui) |
| ➖ | All other addons | Optional — skipped if not installed |

### 💡 Recommended Addons

| Addon | Description | Link |
|:------|:------------|:----:|
| **ElvUI_Anchor** | Extended frame positioning | [CurseForge](https://www.curseforge.com/wow/addons/elvui-anchor) |
| **ElvUI WindTools** | Enhanced skins, animations, QoL | [CurseForge](https://www.curseforge.com/wow/addons/elvui-windtools) |
| **Details!** | Damage and healing meter | [CurseForge](https://www.curseforge.com/wow/addons/details) |
| **Plater** | Customizable nameplates | [CurseForge](https://www.curseforge.com/wow/addons/plater-nameplates) |
| **HandyNotes** | Map notes and pins | [CurseForge](https://www.curseforge.com/wow/addons/handynotes) |

## 🖱️ Minimap Controls

| Click | Action |
|:------|:-------|
| **Left-click** | Open the Installer |
| **Right-click** | Open ElvUI settings (MagguuUI section) |
| **Middle-click** | Toggle the Changelog popup |

## 💬 Chat Commands

| Command | Description |
|:--------|:------------|
| `/mui install` | Toggle the installer |
| `/mui settings` | Toggle settings panel |
| `/mui minimap` | Toggle minimap button |
| `/mui version` | Show addon version |
| `/mui changelog` | Show the changelog popup |
| `/mui status` | Show installed profile status |

## 📦 WowUp Import

1. Open MagguuUI settings in-game (`/mui settings`)
2. Go to **Settings** → **WowUp Import**
3. Click **Copy Required Addons** or **Copy Optional Addons**
4. Open WowUp → Import/Export → Import → paste the string

## 🔄 New Characters

When logging in with a new character, MagguuUI automatically asks if you want to load all existing profiles. Profiles are applied one at a time to prevent conflicts, followed by a Reload prompt.

## ❓ FAQ

<details>
<summary><b>Do I need all the supported addons?</b></summary>
<br>
No. Only ElvUI is required. All other addons are optional — MagguuUI automatically skips any addon that isn't installed or enabled.
</details>

<details>
<summary><b>Will this overwrite my existing profiles?</b></summary>
<br>
MagguuUI creates a separate profile named "MagguuUI" for each addon. If a profile already exists, you'll be asked to confirm before overwriting.
</details>

<details>
<summary><b>How do I reset and reinstall?</b></summary>
<br>
Type <code>/mui install</code> to reopen the installer at any time.
</details>

---

<div align="center">

**Found a bug or have a suggestion?** Visit [ui.magguu.xyz](https://ui.magguu.xyz) or open an [issue on GitHub](https://github.com/Derpsen/MagguuUI/issues).

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).

</div>
