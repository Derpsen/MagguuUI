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
