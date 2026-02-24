# 📋 Changelog

All notable changes to MagguuUI will be documented in this file.

## 🔧 v12.0.9 — Debug Mode & Settings Restructure (2026-02-23)

### ✨ Added

- 🐛 **Debug mode**: disables all non-essential addons for troubleshooting — toggle via `/mui debug`

### 📝 Changed

- 🔧 **Debugger** moved into **Information** tab (alongside About, Changelog, System)
- 📦 **WowUp** tab restructured with **Required** and **Optional** subtabs and HowTo section
- 🔄 **Class layout reinstall** properly reindexes layout IDs after removal (no gaps)
- 📁 Core files reorganized into `Core/` and `Installer/` subfolders

### 🛠️ Fixed

- 🐛 SaveLayouts error on class layout reinstall now handled safely
- 🐛 Updated ElvUI Anchor profile (addon was reset by author — reinstall required)

