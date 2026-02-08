# MagguuUI

A pre-configured World of Warcraft UI compilation that installs optimized profiles for popular addons with a single click.

## Features

- **One-Click Installation** — Install all addon profiles at once or step by step through the guided installer
- **Automatic Profile Loading** — New characters automatically receive all configured profiles
- **WowUp Integration** — Built-in export string to quickly install all required addons via WowUp
- **Minimap Button & Addon Compartment** — Quick access to installer and settings

## Supported Addons

| Addon | Description |
|-------|-------------|
| **ElvUI** | Complete UI replacement (action bars, unit frames, nameplates, and more) |
| **Plater** | Customizable nameplates with threat coloring and scripting |
| **BigWigs** | Lightweight boss mod with alerts, timers, and sounds |
| **Details!** | Real-time combat meter for damage, healing, and encounters |
| **BetterCooldownManager** | Enhanced cooldown tracking with flexible bar layouts |
| **Blizzard EditMode** | Optimized layout for Blizzard's built-in HUD editor |

## Requirements

- **ElvUI** (required) — [Download from tukui.org](https://www.tukui.org/addons.php?id=2)
- All other addons are optional — disabled addons are automatically skipped

## Installation

1. Install **ElvUI** from [tukui.org](https://www.tukui.org/addons.php?id=2)
2. Install **MagguuUI** into your `Interface/AddOns/` folder
3. Log in — the installer opens automatically on first launch
4. Click **Install All** to apply all profiles at once, or step through individually
5. Click **Reload** when prompted

### Installing Required Addons via WowUp

1. Open the MagguuUI installer in-game
2. Click **WowUp String** on the Welcome page
3. Copy the import string (Ctrl+C)
4. Open WowUp → Import/Export → Import → paste the string

## Chat Commands

| Command | Description |
|---------|-------------|
| `/mui install` | Toggle the installer |
| `/mui settings` | Toggle settings panel |
| `/mui minimap` | Toggle minimap button |
| `/mui version` | Show addon version |
| `/mui status` | Show installed profile status |

## New Characters

When logging in with a new character, MagguuUI automatically asks if you want to load all existing profiles. Profiles are applied one at a time to prevent conflicts, followed by a Reload prompt.

## FAQ

**Q: Do I need all the supported addons?**
A: No. Only ElvUI is required. All other addons are optional — MagguuUI automatically skips any addon that isn't installed or enabled.

**Q: Will this overwrite my existing profiles?**
A: MagguuUI creates a separate profile named "MagguuUI" for each addon. If a "MagguuUI" profile already exists, you'll be asked to confirm before overwriting.

**Q: How do I reset and reinstall?**
A: Type `/mui install` to reopen the installer at any time.

## Feedback & Support

Found a bug or have a suggestion? Please open an issue on GitHub or reach out on Discord.

## License

All Rights Reserved © Magguu
