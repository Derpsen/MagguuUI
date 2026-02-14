# ElvUI WindTools - Referenz & Design-Dokumentation

## Addon-Übersicht
- **Name:** ElvUI_WindTools (Wind Tools for ElvUI)
- **Aktuelle Version:** 4.11
- **Release-Datum:** 2026/02/12
- **Kompatibilität:** WoW API 12.0.1, ElvUI >= 15.05
- **Autor:** fang2hou (Tabimonk @ Shadowmoon TW)
- **GitHub:** https://github.com/wind-addons/ElvUI_WindTools/issues
- **Discord:** https://discord.gg/CMDsBmhvyW
- **Patreon:** https://www.patreon.com/fang2hou

---

## Changelog v4.11 (2026/02/12)

### Wichtig
- Kompatibel mit 12.0.1 API
- Minimum ElvUI Version: 15.05
- SetPassThroughButtons Fix standardmäßig deaktiviert (aktivierbar unter [Advanced])
- Darkest Night API Fix entfernt → ElvUI API für minimalen Fix
- [Announcement] Utility-Skills Ankündigungsfunktion komplett neu geschrieben (keine Blizzard-Einschränkungen mehr)
- [Who Clicked Minimap] Modul entfernt (Blizzard hat Minimap-Click-Events vollständig verschlüsselt)

### Neu
- [Combat Reminder] Sound-Einstellungen für Kampfbeitritt/-verlassen (Standard: aus)
- [Skins] Shadow-Skin für ElvUI Nameplates
- [Objective Tracker] Position/Scale für POI-Button anpassbar (Standard: aus)
- [Move Frames] Auto-Reset für Off-Screen Frames (Standard: an)

### Verbesserungen
- Globale Variable Leak optimiert
- [Announcement] Alle kampfbeschränkten Features entfernt
- [Absorb] Custom Textures nur noch für Damage Absorbs
- [Extra Items Bar] Quest-Items nach Questdistanz sortiert
- [Skins] Cooldown Manager Skin optimiert (keine Lücken mehr)
- [Move Frames] Stabilere Frame-Position-Speicherung & minimierte Daten-Schreibvorgänge

---

## Changelog v4.00 (2025/10/09)

### Wichtig
- Support für WoW 11.2.5
- Minimum ElvUI Version: 14.02
- [Inspect] Modul komplett neu geschrieben (Optionen werden zurückgesetzt)

### Neu
- Fonts: LINE Seed, Chivo Mono
- [Skins] Blizzard Game Menu, Advanced Interface Options, Rematch
- [Others] Achievement Tracker Modul (von Dack)
- [Friend List] Legion Remix Icons

---

## Options-Kategorien & Design-Struktur

Die Settings/Options sind in folgende Hauptkategorien unterteilt:

| Kategorie | Order | Beschreibung |
|-----------|-------|--------------|
| Item | 101 | QoL-Features (Already Known, Fast Loot, Extra Items Bar, Inspect, Contacts, Delete, Trade, Item Level) |
| Combat | 102 | Combat Alert, Raid Markers, Quick Keystone |
| Maps | 103 | Event Tracker, Rectangle Minimap, Minimap Buttons, Super Tracker, World Map, Instance Difficulty |
| Quest & Achieve | 104 | Progress, Switch Buttons, Turn In, Achievement Screenshot, Achievement Tracker, Objective Tracker |
| Social | 105 | Chat Bar, Chat Link, Chat Text, Emote, Friend List, Context Menu, Smart Tab |
| Announcement | 106 | Goodbye, Quest, Reset Instance, Utility, Keystone |
| Tooltips | 107 | ElvUI Tweaks, Keystone, Group Info, Progression, Title Icon, Faction Icon, etc. |
| Unit Frames | 108 | Absorb, Quick Focus, Role Icon, Tags |
| Skins | 109 | Vignetting, Widgets, Cooldown Viewer, Shadow, Blizzard/ElvUI/Addon Skins |
| Misc | 110 | Game Bar, Automation, Move Frames, LFG List, Mute, Skip Cutscene, etc. |
| Advanced | 111 | Erweiterte Einstellungen |
| Information | 112 | Credits, Changelog, Help, Donators, Version |

---

## Design-Farbschema

### Gradient-Titel-Farben (Options UI)
```
#f0772f → #f34a62 → #bb77ed → #1cdce8
```
Diese Farben werden als Gradient über die Kategorie-Namen im Options-Tree gelegt.

### Widget-Standard-Farben (Skins)
- **Button Backdrop:** `{ r = 0.145, g = 0.353, b = 0.698 }` (Dunkelblau)
- **Button Selected:** `{ r = 0.322, g = 0.608, b = 0.961 }` (Hellblau)
- **Checkbox/Slider:** `{ r = 0.322, g = 0.608, b = 0.961, a = 0.8 }`
- **Tab Normal Text:** `{ r = 1, g = 0.82, b = 0 }` (Gold)
- **Tab Selected Text:** `{ r = 1, g = 1, b = 1 }` (Weiß)
- **Border Selected:** `{ r = 0.145, g = 0.353, b = 0.698 }`

### Cooldown Viewer / BigWigs Bar Farben
- **Normal Bar Links:** `{ r = 0.329, g = 0.522, b = 0.933 }` (Blau)
- **Normal Bar Rechts:** `{ r = 0.259, g = 0.843, b = 0.867 }` (Cyan)
- **Emphasized Bar Links:** `{ r = 0.925, g = 0.000, b = 0.549 }` (Pink)
- **Emphasized Bar Rechts:** `{ r = 0.988, g = 0.404, b = 0.404 }` (Rot)

### Objective Tracker Farben
- **Cosmetic Bar Gradient:** `{ r = 0.329, g = 0.522, b = 0.933 }` → `{ r = 0.259, g = 0.843, b = 0.867 }`
- **Title Normal:** `{ r = 0.000, g = 0.659, b = 1.000 }` (Cyan)
- **Title Highlight:** `{ r = 0.282, g = 0.859, b = 0.984 }`
- **Info Normal:** `{ r = 0.842, g = 0.815, b = 0.677 }` (Beige)
- **Info Highlight:** `{ r = 0.992, g = 0.965, b = 0.827 }`

### Quest Progress Farben (Tailwind-Templates)
- **Tag:** sky-500 / sky-300
- **Suggested Group:** rose-400 / rose-300
- **Level:** fuchsia-500 / pink-400
- **Daily:** cyan-400 / cyan-200
- **Weekly:** teal-400 / teal-200
- **Title:** amber-400 / amber-200
- **Quest Complete:** green-400 / emerald-300
- **Quest Accepted:** blue-400 / sky-300
- **Combat Enter:** rose-500 / rose-300
- **Combat Leave:** emerald-500 / emerald-300

---

## Textur-Referenzen
- **Haupt-Textur:** "WindTools Glow" (für Bars, Tabs, Cosmetic Bars, etc.)
- **Fonts:** Montserrat (ExtraBold), Chivo Mono, AccidentalPresidency, Roadway, LINE Seed
- **Animations:** fade, Easing-Typen: linear, quadratic, cubic, quartic, quintic, sinusoidal, exponential, circular, bounce

---

## Skin-System

### Unterstützte Blizzard-Frames (74+ Frames)
Achievements, Addon Manager, Auction House, Bags, Calendar, Character, Collections, Communities, Encounter Journal, Friends, Game Menu, Guild, Mail, Merchant, Professions, Quest, Settings Panel, Tooltips, Trade, World Map, und viele mehr.

### Unterstützte ElvUI-Frames
Action Bars (Backdrop + Button), AFK, Alt Power Bar, Auras, Bags, Cast Bars, Chat Panels, Class Bars, Data Bars, Data Panels, Loot Roll, Minimap, Nameplates, Options, Panels, Raid Utility, Static Popup, Status Report, Totem Tracker, Unit Frames

### Unterstützte Addon-Skins
Advanced Interface Options, Angry Keystones, Auctionator, BigWigs, BtWQuests, BugSack, Collectionator, Immersion, Manuscripts Journal, Meeting Stone, Multi Language, Murlok Export, MySlot, Mythic Dungeon Tools, OmniCD, Paragon Reputation, Plumber, Postal, Premade Groups Filter, Raider.IO, Rare Scanner, Rematch, Silver Dragon, Simple Addon Manager, Simulationcraft, Talent Loadouts Ex, TomCats, TomTom, Warp Deplete, Whisper Pop, World Quest Tab

---

## Settings-Datenstruktur

### ProfileDB (pro Profil, teilbar)
- `announcement` - Ankündigungs-Einstellungen (Goodbye, Quest, Reset Instance, Utility, Keystone)
- `combat` - Combat Alert, Raid Markers, Quick Keystone
- `item` - Contacts, Delete, Already Known, Fast Loot, Trade, Extra Items Bar (5 Bars), Inspect, Item Level
- `maps` - Event Tracker (18+ Events), Rectangle Minimap
- `skins` - Vignetting
- `social` - Chat Bar, Chat Link, Chat Text, Emote, Friend List, Context Menu, Smart Tab
- `quest` - Progress, Switch Buttons, Turn In, Achievement Screenshot, Achievement Tracker
- `tooltips` - ElvUI Tweaks, Keystone, Group Info
- `unitFrames` - Absorb
- `misc` - Game Bar, Automation, Keybind Alias, Exit Phase Diving, Disable Talking Head, etc.

### PrivateDB (pro Charakter, nicht teilbar)
- `combat` - (leer, reserviert)
- `item` - Extend Merchant Pages
- `maps` - Instance Difficulty, Super Tracker, World Map, Minimap Buttons
- `misc` - Move Frames, Mute, LFG List, Move Speed, Skip Cutscene, etc.
- `quest` - Objective Tracker
- `skins` - Haupt-Skin-Einstellungen, Widget-Stile, Cooldown Viewer, Addon/Blizzard/ElvUI Skins
- `tooltips` - Modifier, Title Icon, Progression, Tier Set, etc.
- `social` - Smart Tab Whisper Targets
- `unitFrames` - Quick Focus, Role Icon, Tags

### GlobalDB (accountweit)
- `core` - Compatibility Check, Changelog Popup, ElvUI Version Popup, Login Message
- `developer` - Log Level, Table Attribute Display
- `item` - Contacts (Alts, Favorites)
- `combat` - Covenant Helper
- `misc` - Watched Movies, LFG List
- `maps` - Event Tracker

---

## Contributors
fang2hou, DakJaniels, mcc1, someblu, keludechu, LiangYuxuan, asdf12303116, KurtzPT, 404Polaris, fubaWoW, ryanfys, MouJiaoZi, Jaenichen, mattiagraziani-it, ylt, AngelosNaoumis, LvWind, DaguDuiyuan

## Deutsche Übersetzer
imna1975 (CurseForge), Merathilis, Dlarge
