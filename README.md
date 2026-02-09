# MagguuUI

A pre-configured World of Warcraft UI compilation that installs optimized profiles for popular addons with a single click. No more hours of tweaking settings — just install, click, and play.

Compatible with **WoW Retail 12.0+** (The War Within / Midnight).

🌐 **Website:** [ui.magguu.xyz](https://ui.magguu.xyz)

## ✨ Features

- 🚀 **One-Click Installation** — Install all addon profiles at once or step by step through the guided installer
- 🔄 **Automatic Profile Loading** — New characters automatically receive all configured profiles
- 📦 **WowUp Integration** — Built-in export string to quickly install all required addons via WowUp
- 🗺️ **Minimap Button & Addon Compartment** — Quick access to installer and settings
- 📋 **Copy Feedback** — Popups confirm successful copy and auto-close

## 🎨 Supported Addons

| Addon | Description |
|-------|-------------|
| **ElvUI** | Complete UI replacement (action bars, unit frames, nameplates, and more) |
| **ElvUI_Anchor** | Extended anchor positioning for precise frame placement |
| **ElvUI WindTools** | Enhanced ElvUI with additional skins, animations, and quality-of-life features |
| **Plater** | Customizable nameplates with threat coloring and scripting |
| **BigWigs** | Lightweight boss mod with alerts, timers, and sounds |
| **Details!** | Real-time combat meter for damage, healing, and encounters |
| **BetterCooldownManager** | Enhanced cooldown tracking with flexible bar layouts |
| **Blizzard EditMode** | Optimized layout for Blizzard's built-in HUD editor |

## 📋 Requirements

- **ElvUI** is required — [Download from tukui.org](https://tukui.org/elvui)
- All other addons are optional — disabled addons are automatically skipped

### 📦 Recommended Addons

These addons are optional but recommended for the full MagguuUI experience:

- **ElvUI_Anchor** — Extended frame positioning — [CurseForge](https://www.curseforge.com/wow/addons/elvui-anchor)
- **ElvUI WindTools** — Enhanced skins, animations, and QoL — [CurseForge](https://www.curseforge.com/wow/addons/elvui-windtools)
- **Details!** — Damage and healing meter — [CurseForge](https://www.curseforge.com/wow/addons/details)
- **Plater** — Customizable nameplates — [CurseForge](https://www.curseforge.com/wow/addons/plater-nameplates)
- **HandyNotes** — Map notes and pins — [CurseForge](https://www.curseforge.com/wow/addons/handynotes)

## 🔧 Installation

1. Install **ElvUI** from [tukui.org](https://tukui.org/elvui)
2. Install **MagguuUI** from [CurseForge](https://www.curseforge.com/wow/addons/magguuui)
3. *(Recommended)* Install **ElvUI_Anchor** from [CurseForge](https://www.curseforge.com/wow/addons/elvui-anchor)
4. Log in — the installer opens automatically on first launch
5. Click **Install All** to apply all profiles at once, or step through individually
6. Click **Reload** when prompted

### Installing Required Addons via WowUp

1. Open the MagguuUI installer in-game
2. Click **WowUp String** on the Welcome page
3. The string is automatically selected — press **Ctrl+C** to copy
4. The popup confirms "Copied!" and closes automatically
5. Open WowUp → Import/Export → Import → paste the string

## ⚙️ Settings

- **Show Minimap Button** — Toggle the minimap button on or off
- **Version** — Displays the current MagguuUI version
- **Website** — Copy the website URL to your clipboard with one click

## 💬 Chat Commands

| Command | Description |
|---------|-------------|
| `/mui install` | Toggle the installer |
| `/mui settings` | Toggle settings panel |
| `/mui minimap` | Toggle minimap button |
| `/mui version` | Show addon version |
| `/mui status` | Show installed profile status |

## 🔄 New Characters

When logging in with a new character, MagguuUI automatically asks if you want to load all existing profiles. Profiles are applied one at a time to prevent conflicts, followed by a Reload prompt.

## ❓ FAQ

**Do I need all the supported addons?**
No. Only ElvUI is required. All other addons including ElvUI_Anchor are optional — MagguuUI automatically skips any addon that isn't installed or enabled.

**Will this overwrite my existing profiles?**
MagguuUI creates a separate profile named "MagguuUI" for each addon. If a profile already exists, you'll be asked to confirm before overwriting.

**How do I reset and reinstall?**
Type `/mui install` to reopen the installer at any time.

## 💡 Feedback & Support

Found a bug or have a suggestion? Visit [ui.magguu.xyz](https://ui.magguu.xyz) or open an issue on [GitHub](https://github.com/Derpsen/MagguuUI/issues).

## 📄 License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html). See the [LICENSE](LICENSE) file for details.
