# MagguuUI

A pre-configured World of Warcraft UI compilation that installs optimized profiles for popular addons with a single click. No more hours of tweaking settings — just install, click, and play.

Compatible with **WoW Retail 12.0+** (The War Within / Midnight).

**Website:** [ui.magguu.xyz](https://ui.magguu.xyz)

## Features

- **One-Click Installation** — Install all addon profiles at once or step by step through the guided installer
- **Character Layouts** — Class-specific layouts that auto-select based on your active spec
- **Automatic Profile Loading** — New characters automatically receive all configured profiles
- **WowUp Integration** — Built-in export string to quickly install all required addons via WowUp
- **Minimap Button & Addon Compartment** — Quick access to installer and settings
- **Changelog Popup** — See what's new after every update, or open anytime via `/mui changelog`

## Supported Addons

| Addon | Description |
|-------|-------------|
| **ElvUI** | Complete UI replacement (action bars, unit frames, nameplates, and more) |
| **BetterCooldownManager** | Enhanced cooldown tracking with flexible bar layouts |
| **BigWigs** | Lightweight boss mod with alerts, timers, and sounds |
| **Details!** | Real-time combat meter for damage, healing, and encounters |
| **Plater** | Customizable nameplates with threat coloring and scripting |
| **Blizzard EditMode** | Optimized layout for Blizzard's built-in HUD editor |
| **Character Layouts** | Class-specific layouts for all 13 classes, matched to your spec |

## Requirements

- **ElvUI** is required — [Download from tukui.org](https://tukui.org/elvui)
- All other addons are optional — disabled addons are automatically skipped

### Recommended Addons

These addons are optional but recommended for the full MagguuUI experience:

- **ElvUI_Anchor** — Extended frame positioning — [CurseForge](https://www.curseforge.com/wow/addons/elvui-anchor)
- **ElvUI WindTools** — Enhanced skins, animations, and QoL — [CurseForge](https://www.curseforge.com/wow/addons/elvui-windtools)
- **Details!** — Damage and healing meter — [CurseForge](https://www.curseforge.com/wow/addons/details)
- **Plater** — Customizable nameplates — [CurseForge](https://www.curseforge.com/wow/addons/plater-nameplates)
- **HandyNotes** — Map notes and pins — [CurseForge](https://www.curseforge.com/wow/addons/handynotes)

## Installation

1. Install **ElvUI** from [tukui.org](https://tukui.org/elvui)
2. Install **MagguuUI** from [CurseForge](https://www.curseforge.com/wow/addons/magguuui)
3. *(Recommended)* Install **ElvUI_Anchor** from [CurseForge](https://www.curseforge.com/wow/addons/elvui-anchor)
4. Log in — the installer opens automatically on first launch
5. Click **Install All** to apply all profiles at once, or step through individually
6. Click **Reload** when prompted

### Installing Required Addons via WowUp

1. Open MagguuUI settings in-game (`/mui settings`)
2. Go to **Settings** > **WowUp Import**
3. Click **Copy Required Addons** or **Copy Optional Addons**
4. Open WowUp > Import/Export > Import > paste the string

## Settings

Access settings through the minimap button or Addon Compartment:

- **Left-click** — Open the Installer
- **Right-click** — Open ElvUI settings (MagguuUI section)
- **Middle-click** — Toggle the Changelog popup

In the settings panel (`/mui settings`) you can configure general options, import WowUp strings, and view system info.

## Chat Commands

| Command | Description |
|---------|-------------|
| `/mui install` | Toggle the installer |
| `/mui settings` | Toggle settings panel |
| `/mui minimap` | Toggle minimap button |
| `/mui version` | Show addon version |
| `/mui changelog` | Show the changelog popup |
| `/mui status` | Show installed profile status |

## New Characters

When logging in with a new character, MagguuUI automatically asks if you want to load all existing profiles. Profiles are applied one at a time to prevent conflicts, followed by a Reload prompt.

## FAQ

**Do I need all the supported addons?**
No. Only ElvUI is required. All other addons are optional — MagguuUI automatically skips any addon that isn't installed or enabled.

**Will this overwrite my existing profiles?**
MagguuUI creates a separate profile named "MagguuUI" for each addon. If a profile already exists, you'll be asked to confirm before overwriting.

**How do I reset and reinstall?**
Type `/mui install` to reopen the installer at any time.

## Feedback & Support

Found a bug or have a suggestion? Visit [ui.magguu.xyz](https://ui.magguu.xyz) or open an issue on [GitHub](https://github.com/Derpsen/MagguuUI/issues).

## License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).
