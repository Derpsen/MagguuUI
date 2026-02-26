# 📋 Changelog

All notable changes to MagguuUI will be documented in this file.

## 🔧 v12.0.10 — Logging, Robustheit & Alt-Support (2026-02-26)

### ✨ Added

- 📊 **Tiered logging** with 4 levels (ERROR/WARNING/INFO/DEBUG) — cycle with `/mui log`
- 📋 **Diagnostic report** via `/mui report` — generates copyable system info for support
- 🔄 **`/mui load`** command to load profiles on alt characters anytime
- ⚠️ **ElvUI version check** — warns on login if ElvUI is too old for current profiles
- ⚔️ **Combat queue** — profile installs during combat are queued and replayed automatically
- 🔧 **WindTools settings** applied automatically during ElvUI profile import

### 📝 Changed

- 🛡️ All setup handlers protected with **pcall** — one failed addon won't crash the queue
- 🔒 **LibDualSpec** disabled before ElvUI profile switch (prevents profile conflicts)
- ⏭️ **ElvUI installer auto-skipped** when MagguuUI is installed (no double installer)
- 🗄️ **Database migrations** now version-gated (each migration runs exactly once)
- ✅ Nil guards after DecompressData in Details and Plater handlers
- 🏗️ Centralized helpers: `CreateBasePopup`, `DBSet`, `VersionStringToCode`
- 🔢 Named constants for all magic numbers (`MUI.Constants`)
- 🔴 **IMPORTANT** changelog category added (red highlighting)

### 🛠️ Fixed

- 🐛 EditMode `ConvertStringToLayoutInfo` and `SaveLayouts` wrapped in pcall
- 🐛 BCM import wrapped in pcall — corrupt profile data no longer causes UI errors

