#!/usr/bin/env python3
"""
sync-profiles.py — MagguuUI Profile Sync (Nuxt v2 API)

Fetches addon profile data, WowUp strings, and class layouts from the
MagguuUI website and updates the Data/ Lua files in the repository.

API endpoints (Nuxt v2):
  GET {API_URL}/api/v1/profiles          → Addon profiles grouped by addon name
  GET {API_URL}/api/v1/wowup             → WowUp import strings (Required/Optional)
  GET {API_URL}/api/v1/layouts/grouped    → Character layouts grouped by class name

Directory structure:
  Data/
  ├── AddOns/          ← Addon profiles + WowUp strings
  │   ├── ElvUI.lua
  │   ├── Plater.lua
  │   ├── WowUp.lua
  │   └── ...
  └── Classes/         ← Class cooldown/layout strings
      ├── Warrior.lua
      ├── Mage.lua
      └── ...

Environment:
  API_URL  – Base URL of the website (e.g. https://ui.magguu.xyz)
"""

import base64
import json
import os
import sys
import requests

# ─── Config ──────────────────────────────────────────

API_URL = os.environ.get("API_URL", "").rstrip("/")
if not API_URL:
    print("ERROR: API_URL secret not set")
    sys.exit(1)

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
REPO_ROOT = os.path.normpath(os.path.join(SCRIPT_DIR, "..", ".."))
ADDONS_DIR = os.path.join(REPO_ROOT, "Data", "AddOns")
CLASSES_DIR = os.path.join(REPO_ROOT, "Data", "Classes")

LUA_HEADER = 'local MUI = unpack(MagguuUI)\nlocal D = MUI:GetModule("Data")\n'

# ─── Addon Mapping ───────────────────────────────────
# "var"       – D.xxx variable name (lowercase!)
# "file"      – Target filename in Data/AddOns/
# "style"     – "simple" → D.var = "str"   |   "table" → D.var = { key = "str", ... }
# "profiles"  – For "simple": list of profile names to try (first match wins)
#               For "table": dict mapping lua_key → list of API profile names to try
# "has_1080p" – Whether to include a D.var1080p placeholder line
# "extras"    – Additional static key=value pairs for table style

ADDON_MAP = {
    "Plater": {
        "var": "plater",
        "file": "Plater.lua",
        "style": "simple",
        "profiles": ["Default", "MagguuUI"],
        "has_1080p": True,
    },
    "BigWigs": {
        "var": "bigwigs",
        "file": "BigWigs.lua",
        "style": "simple",
        "profiles": ["Default", "MagguuUI"],
        "has_1080p": False,
    },
    "Details": {
        "var": "details",
        "file": "Details.lua",
        "style": "simple",
        "profiles": ["Default", "MagguuUI"],
        "has_1080p": False,
    },
    "BetterCooldownManager": {
        "var": "bettercooldownmanager",
        "file": "BetterCooldownManager.lua",
        "style": "simple",
        "profiles": ["Default", "MagguuUI"],
        "has_1080p": True,
    },
    "Blizzard_EditMode": {
        "var": "blizzardeditmode",
        "file": "Blizzard_EditMode.lua",
        "style": "simple",
        "profiles": ["Default", "MagguuUI"],
        "has_1080p": False,
    },
    "ElvUI": {
        "var": "elvui",
        "file": "ElvUI.lua",
        "style": "table",
        "profiles": {
            "profile": ["profile", "Profile", "Default", "MagguuUI"],
            "private": ["private", "Private"],
            "global":  ["global", "Global"],
            "aurafilters": ["aurafilters", "AuraFilters", "Aura Filters"],
        },
        "extras": {
            "uiscale": 0.6,
        },
    },
}

# ─── Class Name Mapping ─────────────────────────────
# Key = class name from API  →  (lua_filename, D.variable)
# Variable is always lowercase: ClassLayouts.lua reads D[strlower(class)]

CLASS_MAP = {
    "Death Knight":  ("DeathKnight",  "deathknight"),
    "DeathKnight":   ("DeathKnight",  "deathknight"),
    "Demon Hunter":  ("DemonHunter",  "demonhunter"),
    "DemonHunter":   ("DemonHunter",  "demonhunter"),
    "Druid":         ("Druid",        "druid"),
    "Evoker":        ("Evoker",       "evoker"),
    "Hunter":        ("Hunter",       "hunter"),
    "Mage":          ("Mage",         "mage"),
    "Monk":          ("Monk",         "monk"),
    "Paladin":       ("Paladin",      "paladin"),
    "Priest":        ("Priest",       "priest"),
    "Rogue":         ("Rogue",        "rogue"),
    "Shaman":        ("Shaman",       "shaman"),
    "Warlock":       ("Warlock",      "warlock"),
    "Warrior":       ("Warrior",      "warrior"),
}


# ─── Helpers ─────────────────────────────────────────

def fetch_json(endpoint: str):
    """Fetch JSON from the Nuxt API. Returns the 'data' field or None."""
    url = f"{API_URL}{endpoint}"
    print(f"  Fetching: {url}")
    try:
        resp = requests.get(url, timeout=30)
        resp.raise_for_status()
        result = resp.json()
        if isinstance(result, dict) and result.get("success") and "data" in result:
            return result["data"]
        return result
    except Exception as e:
        print(f"  ERROR: {e}")
        return None


def escape_lua_string(s: str) -> str:
    """Escape a string for use inside Lua double quotes."""
    if not s:
        return ""
    s = s.replace("\\", "\\\\")
    s = s.replace('"', '\\"')
    s = s.replace("\n", "\\n")
    s = s.replace("\r", "")
    return s


def find_profile_string(profiles_list: list, keys_to_try: list):
    """Find the first matching profile string by name from the API list."""
    if not profiles_list:
        return None

    lookup = {}
    for p in profiles_list:
        name = p.get("profile", "")
        string = p.get("string", "")
        if name and string:
            lookup[name] = string

    for key in keys_to_try:
        if key in lookup:
            return lookup[key]

    lower_lookup = {k.lower(): v for k, v in lookup.items()}
    for key in keys_to_try:
        if key.lower() in lower_lookup:
            return lower_lookup[key.lower()]

    for p in profiles_list:
        s = p.get("string", "").strip()
        if s:
            return s

    return None


def write_if_changed(filepath: str, content: str) -> bool:
    """Write file only if content differs. Returns True if file was updated."""
    if os.path.exists(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            if f.read() == content:
                return False
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
    with open(filepath, "w", encoding="utf-8", newline="\n") as f:
        f.write(content)
    return True


# ─── Addon Lua Generators ───────────────────────────

def generate_simple_lua(var_name: str, profile_string: str, has_1080p: bool = False) -> str:
    """Generate a simple D.var = "string" Lua file."""
    lines = [LUA_HEADER, ""]
    escaped = escape_lua_string(profile_string)
    lines.append(f'D.{var_name} = "{escaped}"')
    if has_1080p:
        lines.append(f'D.{var_name}1080p = ""')
    lines.append("")
    return "\n".join(lines)


def generate_table_lua(var_name: str, profile_map: dict, profiles_list: list, extras: dict = None) -> str:
    """Generate a table-style Lua file (used for ElvUI)."""
    lines = [LUA_HEADER, ""]
    lines.append(f"D.{var_name} = {{")

    lookup = {}
    for p in profiles_list:
        name = p.get("profile", "")
        string = p.get("string", "")
        if name:
            lookup[name] = string

    for lua_key, api_keys in profile_map.items():
        value = None
        for key in api_keys:
            if key in lookup and lookup[key]:
                value = lookup[key]
                break
        if not value:
            lower_lookup = {k.lower(): v for k, v in lookup.items()}
            for key in api_keys:
                if key.lower() in lower_lookup and lower_lookup[key.lower()]:
                    value = lower_lookup[key.lower()]
                    break

        if value:
            escaped = escape_lua_string(value)
            lines.append(f'    {lua_key} = "{escaped}",')
        else:
            lines.append(f'    {lua_key} = "",')
            print(f"    WARNING: No data found for {var_name}.{lua_key}")

    if extras:
        lines.append("")
        for key, val in extras.items():
            if isinstance(val, (int, float)):
                lines.append(f"    {key} = {val},")
            elif isinstance(val, str):
                lines.append(f'    {key} = "{escape_lua_string(val)}",')
            elif isinstance(val, bool):
                lines.append(f"    {key} = {'true' if val else 'false'},")

    lines.append("}")
    lines.append("")
    return "\n".join(lines)


# ─── WowUp ──────────────────────────────────────────

def extract_addon_names(wowup_string: str) -> list:
    """Extract addon names from a WowUp base64-encoded JSON string."""
    if not wowup_string:
        return []
    try:
        data = json.loads(base64.b64decode(wowup_string))
        addons = data.get("addons", [])
        if isinstance(data, list):
            addons = data
        names = []
        for addon in addons:
            name = addon.get("name") or addon.get("addonName") or addon.get("Name") or ""
            name = name.strip()
            if name and name.lower() != "magguuui":
                names.append(name)
        return sorted(names, key=str.lower)
    except Exception as e:
        print(f"    WARNING: Could not extract addon names: {e}")
        return []


def generate_addon_list_lua(var_name: str, addon_names: list) -> str:
    """Generate: D.var = { "Name1", "Name2", ... }"""
    if not addon_names:
        return f"D.{var_name} = {{}}"
    lines = [f"D.{var_name} = {{"]
    for name in addon_names:
        escaped = escape_lua_string(name)
        lines.append(f'    "{escaped}",')
    lines.append("}")
    return "\n".join(lines)


def generate_wowup_lua(wowup_data: dict):
    """Generate WowUp.lua with Required/Optional strings and addon name lists."""
    required_string = None
    optional_string = None

    for key in ["Required", "required", "WowUp required", "WowUP required",
                 "WowUp", "Default", "MagguuUI"]:
        entry = wowup_data.get(key)
        if entry:
            s = entry.get("string", "") if isinstance(entry, dict) else str(entry)
            if s.strip():
                required_string = s.strip()
                break

    for key in ["Optional", "optional", "WowUp optional", "WowUP optional"]:
        entry = wowup_data.get(key)
        if entry:
            s = entry.get("string", "") if isinstance(entry, dict) else str(entry)
            if s.strip():
                optional_string = s.strip()
                break

    if not required_string:
        print("  WARNING: No WowUp Required string found")
        return None

    required_names = extract_addon_names(required_string)
    optional_names = extract_addon_names(optional_string) if optional_string else []

    print(f"    Required addons: {len(required_names)}")
    if optional_string:
        print(f"    Optional addons: {len(optional_names)}")

    lines = [
        LUA_HEADER,
        "",
        "-- ============================================================",
        "-- WowUp Import Strings",
        "-- Auto-generated by sync-profiles.py",
        "-- ============================================================",
        "",
        "-- Required addons import string",
        f'D.WowUpRequired = "{escape_lua_string(required_string)}"',
        "",
        "-- Optional addons import string",
        f'D.WowUpOptional = "{escape_lua_string(optional_string or "")}"',
        "",
        "-- Legacy fallback",
        "D.WowUpString = D.WowUpRequired",
        "",
        "-- ============================================================",
        "-- Addon Name Lists (auto-extracted from import strings)",
        "-- ============================================================",
        "",
        generate_addon_list_lua("WowUpRequiredList", required_names),
        "",
        generate_addon_list_lua("WowUpOptionalList", optional_names) if optional_names else "D.WowUpOptionalList = {}",
        "",
    ]
    return "\n".join(lines)


# ─── Class Layouts ───────────────────────────────────

def generate_class_lua(class_name: str, specs: list) -> str:
    """
    Generate a Data/Classes/<Class>.lua file.

    Output format (matches existing addon structure):
        D.warrior = {
            "1|LdC9L...", -- Arms
            "1|LdC7S...", -- Fury
            "1|NdC7L...", -- Protection
        }
    """
    _, var_name = CLASS_MAP.get(class_name, (class_name, class_name.lower().replace(" ", "")))

    lines = [LUA_HEADER]
    lines.append("")
    lines.append(f"D.{var_name} = {{")

    for spec in specs:
        import_string = spec.get("importString", "") or ""
        spec_name = spec.get("spec", "") or spec.get("description", "") or ""

        escaped = escape_lua_string(import_string)
        comment = f" -- {spec_name}" if spec_name else ""
        lines.append(f'    "{escaped}",{comment}')

    lines.append("}")
    lines.append("")

    return "\n".join(lines)


def generate_classes_load_xml(class_files: list) -> str:
    """Generate Data/Classes/!load.xml listing all class Lua files."""
    lines = ['<Ui xmlns="http://www.blizzard.com/wow/ui/">']
    for filename in sorted(class_files):
        lines.append(f'    <Script file="{filename}"/>')
    lines.append('</Ui>')
    lines.append('')
    return "\n".join(lines)


# ─── Main ────────────────────────────────────────────

def main():
    print("=" * 50)
    print("MagguuUI Profile Sync (Nuxt v2 API)")
    print(f"API: {API_URL}")
    print(f"AddOns Dir: {ADDONS_DIR}")
    print(f"Classes Dir: {CLASSES_DIR}")
    print("=" * 50)

    for d in [ADDONS_DIR, CLASSES_DIR]:
        if not os.path.isdir(d):
            print(f"ERROR: Directory not found: {d}")
            sys.exit(1)

    updated = []
    errors = []

    # ── 1. Fetch Addon Profiles ──────────────────
    print("\n[1/3] Fetching addon profiles...")
    profiles_data = fetch_json("/api/v1/profiles")

    if profiles_data and isinstance(profiles_data, dict):
        for api_name, config in ADDON_MAP.items():
            addon_profiles = profiles_data.get(api_name)

            if not addon_profiles:
                for k, v in profiles_data.items():
                    if k.lower() == api_name.lower():
                        addon_profiles = v
                        break

            if not addon_profiles and api_name == "Details":
                addon_profiles = profiles_data.get("Details!")

            if not addon_profiles:
                print(f"  SKIP: {api_name} not found in API")
                continue

            filepath = os.path.join(ADDONS_DIR, config["file"])

            if config["style"] == "simple":
                profile_string = find_profile_string(addon_profiles, config["profiles"])
                if not profile_string:
                    print(f"  SKIP: {api_name} — no profile string found")
                    errors.append(api_name)
                    continue
                content = generate_simple_lua(
                    config["var"],
                    profile_string,
                    config.get("has_1080p", False),
                )

            elif config["style"] == "table":
                content = generate_table_lua(
                    config["var"],
                    config["profiles"],
                    addon_profiles,
                    config.get("extras"),
                )
            else:
                continue

            if write_if_changed(filepath, content):
                print(f"  UPDATED: AddOns/{config['file']}")
                updated.append(f"AddOns/{config['file']}")
            else:
                print(f"  OK (unchanged): AddOns/{config['file']}")

    elif profiles_data is None:
        print("  ERROR: Could not fetch profiles")
        errors.append("profiles-endpoint")
    else:
        print("  WARNING: Unexpected data format")
        errors.append("profiles-format")

    # ── 2. Fetch WowUp Strings ───────────────────
    print("\n[2/3] Fetching WowUp strings...")
    wowup_data = fetch_json("/api/v1/wowup")

    if wowup_data and isinstance(wowup_data, dict):
        content = generate_wowup_lua(wowup_data)
        if content:
            filepath = os.path.join(ADDONS_DIR, "WowUp.lua")
            if write_if_changed(filepath, content):
                print(f"  UPDATED: AddOns/WowUp.lua")
                updated.append("AddOns/WowUp.lua")
            else:
                print(f"  OK (unchanged): AddOns/WowUp.lua")
        else:
            errors.append("WowUp")
    elif wowup_data is None:
        print("  ERROR: Could not fetch WowUp data")
        errors.append("wowup-endpoint")

    # ── 3. Fetch Class Layouts ───────────────────
    print("\n[3/3] Fetching class layouts...")
    layouts_data = fetch_json("/api/v1/layouts/grouped")

    if layouts_data and isinstance(layouts_data, dict):
        class_files = []
        for class_name, specs in layouts_data.items():
            if not specs:
                continue

            filename, _ = CLASS_MAP.get(class_name, (class_name.replace(" ", ""), None))
            filepath = os.path.join(CLASSES_DIR, f"{filename}.lua")
            class_files.append(f"{filename}.lua")

            content = generate_class_lua(class_name, specs)

            if write_if_changed(filepath, content):
                spec_names = [s.get("spec", "?") for s in specs if s.get("spec")]
                print(f"  UPDATED: Classes/{filename}.lua ({len(specs)} specs: {', '.join(spec_names)})")
                updated.append(f"Classes/{filename}.lua")
            else:
                print(f"  OK (unchanged): Classes/{filename}.lua")

        # Update !load.xml
        if class_files:
            load_xml = generate_classes_load_xml(class_files)
            load_xml_path = os.path.join(CLASSES_DIR, "!load.xml")
            if write_if_changed(load_xml_path, load_xml):
                print(f"  UPDATED: Classes/!load.xml ({len(class_files)} classes)")
                updated.append("Classes/!load.xml")
            else:
                print(f"  OK (unchanged): Classes/!load.xml")

        print(f"  Total: {len(class_files)} classes synced")
    elif layouts_data is None:
        print("  ERROR: Could not fetch class layouts")
        errors.append("layouts-endpoint")
    else:
        print("  No class layout data found")

    # ── Summary ──────────────────────────────────
    print(f"\n{'=' * 50}")
    print(f"Updated: {len(updated)} file(s)")
    if updated:
        for f in updated:
            print(f"  ✓ Data/{f}")
    if errors:
        print(f"Errors/Warnings: {len(errors)}")
        for e in errors:
            print(f"  ✗ {e}")
    else:
        print("No errors.")
    print()

    if errors and not updated:
        sys.exit(1)


if __name__ == "__main__":
    main()
