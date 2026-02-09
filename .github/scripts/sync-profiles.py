#!/usr/bin/env python3
"""
sync-profiles.py
Fetches addon profile data from the MagguuUI website API v2.0
and updates the Data/*.lua files in the repository.

API v2.0 Response formats:

  /api/?action=profiles →
  {
    "success": true,
    "hash": "...",
    "addons": {
      "ElvUI": {
        "Default": { "id": "...", "string": "encoded_string", "updated": "..." }
      }
    }
  }

  /api/?action=wowup →
  {
    "success": true,
    "hash": "...",
    "strings": {
      "ElvUI": { "id": "...", "string": "encoded_string", "updated": "..." }
    }
  }

Environment:
  API_URL  – Base URL of the API (e.g. https://ui.magguu.xyz/api)
"""

import json
import os
import sys
import requests

API_URL = os.environ.get("API_URL", "").rstrip("/")
if not API_URL:
    print("ERROR: API_URL secret not set")
    sys.exit(1)

DATA_DIR = os.path.join(os.path.dirname(__file__), "..", "..", "Data")
DATA_DIR = os.path.normpath(DATA_DIR)

LUA_HEADER = 'local MUI = unpack(MagguuUI)\nlocal D = MUI:GetModule("Data")\n'

# ──────────────────────────────────────────────
# Mapping: API addon name → lua variable + file
# ──────────────────────────────────────────────
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


def fetch_json(endpoint):
    """Fetch JSON from the API. Returns parsed dict or None on error."""
    url = f"{API_URL}/{endpoint}" if not endpoint.startswith("http") else endpoint
    print(f"  Fetching: {url}")
    try:
        resp = requests.get(url, timeout=30)
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        print(f"  ERROR fetching {url}: {e}")
        return None


def unwrap_api_response(data, content_key):
    """
    Unwrap the MagguuUI API v2.0 response format.
    
    API returns: { "success": true, "addons": { ... } }
    We need:     { "AddonName": { "ProfileName": "string", ... } }
    
    Each profile entry is either a plain string or an object with a 'string' key.
    """
    if not isinstance(data, dict):
        return {}
    
    # Unwrap from top-level key (e.g. "addons" or "strings")
    inner = data.get(content_key, data)
    
    # If it's the raw API response with success/hash/etc, try common keys
    if "success" in data and content_key in data:
        inner = data[content_key]
    
    if not isinstance(inner, dict):
        return {}
    
    # Flatten: extract "string" from nested objects
    result = {}
    for key, val in inner.items():
        if isinstance(val, str):
            # Already a plain string
            result[key] = val
        elif isinstance(val, dict):
            if "string" in val:
                # API v2.0 format: { "id": "...", "string": "...", "updated": "..." }
                result[key] = val["string"]
            else:
                # Nested dict (addon with multiple profiles)
                profiles = {}
                for pkey, pval in val.items():
                    if isinstance(pval, str):
                        profiles[pkey] = pval
                    elif isinstance(pval, dict) and "string" in pval:
                        profiles[pkey] = pval["string"]
                result[key] = profiles
    
    return result


def escape_lua_string(s):
    """Escape a string for use inside Lua double quotes."""
    if not s:
        return ""
    s = s.replace("\\", "\\\\")
    s = s.replace('"', '\\"')
    s = s.replace("\n", "\\n")
    s = s.replace("\r", "")
    return s


def find_profile_string(addon_data, profile_keys):
    """
    Given an addon's data dict, try each key in profile_keys
    and return the first non-empty string found.
    """
    if isinstance(addon_data, str):
        return addon_data

    if not isinstance(addon_data, dict):
        return None

    for key in profile_keys:
        val = addon_data.get(key)
        if val and isinstance(val, str) and val.strip():
            return val.strip()

    # Fallback: if there's only one profile, use it
    string_values = [v for v in addon_data.values() if isinstance(v, str) and v.strip()]
    if len(string_values) == 1:
        return string_values[0].strip()

    return None


def generate_simple_lua(var_name, profile_string, has_1080p=False):
    """Generate a simple D.var = 'string' Lua file content."""
    lines = [LUA_HEADER, ""]
    escaped = escape_lua_string(profile_string)
    lines.append(f'D.{var_name} = "{escaped}"')
    if has_1080p:
        lines.append(f'D.{var_name}1080p = ""')
    lines.append("")
    return "\n".join(lines)


def generate_table_lua(var_name, profile_map, addon_data, extras=None):
    """
    Generate a table-style Lua file (used for ElvUI).
    D.elvui = { profile = "...", private = "...", ... }
    """
    lines = [LUA_HEADER, ""]
    lines.append(f"D.{var_name} = {{")

    for lua_key, api_keys in profile_map.items():
        value = find_profile_string(addon_data, api_keys)
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


def generate_wowup_lua(wowup_data):
    """Generate the WowUp.lua file from WoWUp API data."""
    wowup_string = None

    if isinstance(wowup_data, str):
        wowup_string = wowup_data
    elif isinstance(wowup_data, dict):
        # Try common keys first
        for key in ["WowUp", "WoWUp", "Default", "MagguuUI", "ElvUI"]:
            if key in wowup_data:
                val = wowup_data[key]
                if isinstance(val, str) and val.strip():
                    wowup_string = val.strip()
                    break
        # Fallback: take first value
        if not wowup_string:
            for val in wowup_data.values():
                if isinstance(val, str) and val.strip():
                    wowup_string = val.strip()
                    break

    if not wowup_string:
        print("  WARNING: No WoWUp string found in API response")
        return None

    lines = [
        LUA_HEADER,
        "",
        "-- WowUp Import String",
        "-- Export your addon list from WowUp and paste it here",
        "-- Users can copy this string and import it into WowUp to install all required addons",
        f'D.WowUpString = "{escape_lua_string(wowup_string)}"',
        "",
    ]
    return "\n".join(lines)


def write_if_changed(filepath, content):
    """Write file only if content actually changed. Returns True if written."""
    if os.path.exists(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            existing = f.read()
        if existing == content:
            return False

    with open(filepath, "w", encoding="utf-8") as f:
        f.write(content)
    return True


def main():
    print(f"MagguuUI Profile Sync (API v2.0)")
    print(f"API: {API_URL}")
    print(f"Data dir: {DATA_DIR}")
    print()

    if not os.path.isdir(DATA_DIR):
        print(f"ERROR: Data directory not found: {DATA_DIR}")
        sys.exit(1)

    updated = []
    errors = []

    # ── 1. Fetch addon profiles ──────────────
    print("[1/2] Fetching addon profiles...")
    raw_profiles = fetch_json("?action=profiles")

    if raw_profiles:
        # Unwrap API v2.0 format: { success, hash, addons: { ... } }
        profiles = unwrap_api_response(raw_profiles, "addons")
        
        if not profiles:
            print("  WARNING: API returned empty profiles after unwrapping")
            print(f"  Raw keys: {list(raw_profiles.keys()) if isinstance(raw_profiles, dict) else 'N/A'}")
        
        for api_name, config in ADDON_MAP.items():
            addon_data = profiles.get(api_name)
            if not addon_data:
                # Try case-insensitive lookup
                for k, v in profiles.items():
                    if k.lower() == api_name.lower():
                        addon_data = v
                        break

            if not addon_data:
                print(f"  SKIP: {api_name} not found in API response")
                continue

            filepath = os.path.join(DATA_DIR, config["file"])

            if config["style"] == "simple":
                profile_string = find_profile_string(addon_data, config["profiles"])
                if not profile_string:
                    print(f"  SKIP: {api_name} - no profile string found")
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
                    addon_data,
                    config.get("extras"),
                )
            else:
                continue

            if write_if_changed(filepath, content):
                print(f"  UPDATED: {config['file']}")
                updated.append(config["file"])
            else:
                print(f"  OK (unchanged): {config['file']}")
    else:
        print("  ERROR: Could not fetch profiles")
        errors.append("profiles-endpoint")

    # ── 2. Fetch WoWUp data ──────────────────
    print("\n[2/2] Fetching WoWUp data...")
    raw_wowup = fetch_json("?action=wowup")

    if raw_wowup:
        # Unwrap API v2.0 format: { success, hash, strings: { ... } }
        wowup = unwrap_api_response(raw_wowup, "strings")
        
        content = generate_wowup_lua(wowup)
        if content:
            filepath = os.path.join(DATA_DIR, "WowUp.lua")
            if write_if_changed(filepath, content):
                print(f"  UPDATED: WowUp.lua")
                updated.append("WowUp.lua")
            else:
                print(f"  OK (unchanged): WowUp.lua")
        else:
            errors.append("WowUp")
    else:
        print("  ERROR: Could not fetch WoWUp data")
        errors.append("wowup-endpoint")

    # ── Summary ──────────────────────────────
    print(f"\n{'='*40}")
    print(f"Updated: {len(updated)} file(s)")
    if updated:
        for f in updated:
            print(f"  ✓ {f}")
    if errors:
        print(f"Errors/Warnings: {len(errors)}")
        for e in errors:
            print(f"  ✗ {e}")
    print()


if __name__ == "__main__":
    main()
