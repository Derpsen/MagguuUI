#!/usr/bin/env python3
"""
sync-profiles.py — MagguuUI Profile Sync (Nuxt v2 API)

Fetches addon profile data and WowUp strings from the MagguuUI Nuxt website
and updates the Data/*.lua files in the repository.

API endpoints (Nuxt v2):
  GET {API_URL}/api/v1/profiles
    → { "success": true, "data": { "ElvUI": [ { "profile": "...", "string": "..." }, ... ], ... } }

  GET {API_URL}/api/v1/wowup
    → { "success": true, "data": { "Required": { "string": "..." }, "Optional": { "string": "..." } } }

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

DATA_DIR = os.path.join(os.path.dirname(__file__), "..", "..", "Data")
DATA_DIR = os.path.normpath(DATA_DIR)

LUA_HEADER = 'local MUI = unpack(MagguuUI)\nlocal D = MUI:GetModule("Data")\n'

# ─── Addon Mapping ───────────────────────────────────
# Defines how each addon from the API maps to Lua files.
#
# "var"       – D.xxx variable name (lowercase!)
# "file"      – Target filename in Data/
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


# ─── Helpers ─────────────────────────────────────────

def fetch_json(endpoint: str):
    """Fetch JSON from the Nuxt API. Returns the 'data' field or None."""
    url = f"{API_URL}{endpoint}"
    print(f"  Fetching: {url}")
    try:
        resp = requests.get(url, timeout=30)
        resp.raise_for_status()
        result = resp.json()
        # Nuxt API wraps everything in { success, data, meta }
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
    """
    Given a list of profile objects from the Nuxt API, find the first matching
    profile by name. Returns the string value or None.

    profiles_list: [{ "profile": "Default", "string": "..." }, ...]
    keys_to_try: ["Default", "MagguuUI"]
    """
    if not profiles_list:
        return None

    # Build lookup: profile_name → string
    lookup = {}
    for p in profiles_list:
        name = p.get("profile", "")
        string = p.get("string", "")
        if name and string:
            lookup[name] = string

    # Try each key
    for key in keys_to_try:
        if key in lookup:
            return lookup[key]

    # Case-insensitive fallback
    lower_lookup = {k.lower(): v for k, v in lookup.items()}
    for key in keys_to_try:
        if key.lower() in lower_lookup:
            return lower_lookup[key.lower()]

    # Last resort: first non-empty string
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


# ─── Lua Generators ──────────────────────────────────

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
    """
    Generate a table-style Lua file (used for ElvUI).
    D.elvui = { profile = "...", private = "...", global = "...", aurafilters = "..." }
    """
    lines = [LUA_HEADER, ""]
    lines.append(f"D.{var_name} = {{")

    # Build lookup from profiles list
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
        # Case-insensitive fallback
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

    # Try to find Required and Optional strings
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


# ─── Main ────────────────────────────────────────────

def main():
    print("=" * 50)
    print("MagguuUI Profile Sync (Nuxt v2 API)")
    print(f"API: {API_URL}")
    print(f"Data Dir: {DATA_DIR}")
    print("=" * 50)

    if not os.path.isdir(DATA_DIR):
        print(f"ERROR: Data directory not found: {DATA_DIR}")
        sys.exit(1)

    updated = []
    errors = []

    # ── 1. Fetch Addon Profiles ──────────────────
    print("\n[1/2] Fetching addon profiles...")
    profiles_data = fetch_json("/api/v1/profiles")

    if profiles_data and isinstance(profiles_data, dict):
        for api_name, config in ADDON_MAP.items():
            addon_profiles = profiles_data.get(api_name)

            # Try case-insensitive lookup
            if not addon_profiles:
                for k, v in profiles_data.items():
                    if k.lower() == api_name.lower():
                        addon_profiles = v
                        break

            # Handle "Details!" vs "Details"
            if not addon_profiles and api_name == "Details":
                addon_profiles = profiles_data.get("Details!")

            if not addon_profiles:
                print(f"  SKIP: {api_name} not found in API")
                continue

            filepath = os.path.join(DATA_DIR, config["file"])

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
                print(f"  UPDATED: {config['file']}")
                updated.append(config["file"])
            else:
                print(f"  OK (unchanged): {config['file']}")

    elif profiles_data is None:
        print("  ERROR: Could not fetch profiles")
        errors.append("profiles-endpoint")
    else:
        print("  WARNING: Unexpected data format")
        errors.append("profiles-format")

    # ── 2. Fetch WowUp Strings ───────────────────
    print("\n[2/2] Fetching WowUp strings...")
    wowup_data = fetch_json("/api/v1/wowup")

    if wowup_data and isinstance(wowup_data, dict):
        content = generate_wowup_lua(wowup_data)
        if content:
            filepath = os.path.join(DATA_DIR, "WowUp.lua")
            if write_if_changed(filepath, content):
                print(f"  UPDATED: WowUp.lua")
                updated.append("WowUp.lua")
            else:
                print(f"  OK (unchanged): WowUp.lua")
        else:
            errors.append("WowUp")
    elif wowup_data is None:
        print("  ERROR: Could not fetch WowUp data")
        errors.append("wowup-endpoint")

    # ── Summary ──────────────────────────────────
    print(f"\n{'=' * 50}")
    print(f"Updated: {len(updated)} file(s)")
    if updated:
        for f in updated:
            print(f"  ✓ {f}")
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
