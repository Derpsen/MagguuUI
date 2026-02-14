# MagguuUI — Code Review

## Projektübersicht

WoW Retail (12.0+) UI-Addon-Compilation, basiert auf dem Ace3-Framework. Bietet One-Click-Profilinstallation für ElvUI, Plater, BigWigs, Details!, BetterCooldownManager und Blizzard EditMode.

**Gesamtstruktur:** Sauber, gut organisiert, konsistentes Farbschema. Die Trennung in Data/Setup/Installer/Options ist logisch.

---

## BUGS (Echte Fehler)

### 1. `SE.RemoveFromDatabase()` — Komplett kaputt (Setup.lua:103-113)

```lua
function SE.RemoveFromDatabase(addon)
    MUI.db.global.profiles[addon] = nil

    if MUI.db.global.profiles and #MUI.db.global.profiles == 0 then
        for k in pairs(MUI.db.char) do
            k = nil  -- ← BUG: Tut gar nichts!
        end

        MUI.db.global.profiles = nil
    end
end
```

**Zwei Probleme:**

- **`#MUI.db.global.profiles`** — Der `#`-Operator zählt nur den Array-Teil einer Tabelle. Da `profiles` ein Hash ist (`profiles["ElvUI"] = true`), gibt `#profiles` **immer 0** zurück. Das heißt: Sobald ein einziges Profil entfernt wird, werden ALLE Profil-Daten gelöscht — auch wenn andere Addons noch installiert sind.

- **`k = nil`** — Setzt nur die lokale Loop-Variable auf nil, entfernt aber nichts aus der Tabelle. Das ist ein No-Op.

**Fix:**
```lua
function SE.RemoveFromDatabase(addon)
    if not MUI.db.global.profiles then return end

    MUI.db.global.profiles[addon] = nil

    -- Prüfe ob die Tabelle wirklich leer ist
    if not next(MUI.db.global.profiles) then
        wipe(MUI.db.char)
        MUI.db.global.profiles = nil
    end
end
```

---

### 2. `SE.IsProfileExisting()` — Erzeugt jedes Mal eine neue AceDB-Instanz (Setup.lua:91-101)

```lua
function SE.IsProfileExisting(table)
    local db = LibStub("AceDB-3.0"):New(table)
    local profiles = db:GetProfiles()
    ...
end
```

`AceDB-3.0:New()` ist dafür gedacht, einmalig beim Addon-Laden aufgerufen zu werden. Bei jedem Aufruf wird ein neues DB-Objekt erstellt und in AceDB's internes Registry eingetragen. Das kann zu Memory-Leaks und unvorhersehbarem Verhalten führen, besonders wenn die Funktion wiederholt aufgerufen wird (z.B. beim Öffnen des Installers).

**Fix:** Profiles direkt in der SavedVariables-Tabelle prüfen:
```lua
function SE.IsProfileExisting(svTable)
    if not svTable or not svTable.profiles then return false end

    return svTable.profiles["MagguuUI"] ~= nil
end
```

---

### 3. Changelog-Versionsvergleich — String-Vergleich statt semantisch (Changelog.lua:83)

```lua
if not fromVersion or entry.version > fromVersion or ...
```

String-Vergleich: `"12.0.10" > "12.0.9"` ergibt **false** (weil `"1" < "9"`). Funktioniert momentan mit einstelligen Patch-Nummern, bricht aber ab Version 12.0.10.

**Fix:**
```lua
local function CompareVersions(v1, v2)
    local a1, b1, c1 = v1:match("(%d+)%.(%d+)%.(%d+)")
    local a2, b2, c2 = v2:match("(%d+)%.(%d+)%.(%d+)")
    a1, b1, c1 = tonumber(a1), tonumber(b1), tonumber(c1)
    a2, b2, c2 = tonumber(a2), tonumber(b2), tonumber(c2)

    if a1 ~= a2 then return a1 > a2 end
    if b1 ~= b2 then return b1 > b2 end
    return c1 > c2
end
```

---

### 4. Plater RawHook überschreibt Original-Funktion (Setup/AddOns/Plater.lua:12, 35-37)

```lua
SE:RawHook(Plater, "OnProfileCreated", function()
    -- Original wird NIE aufgerufen!
    C_Timer.After(.5, function() ... end)
end)

SE:RawHook(Plater, "RefreshConfigProfileChanged", function()
    Plater:RefreshConfig()  -- Ruft RefreshConfig statt dem Original
end)
```

`RawHook` ersetzt die Originalfunktion. Wenn Plater dort eigene Logik hat, geht die verloren. Entweder `RawHook` + `self.hooks[Plater].OnProfileCreated(...)` aufrufen, oder `SecureHook`/`HookScript` nutzen wenn das Original AUCH laufen soll.

**Fix (wenn Original auch laufen soll):**
```lua
SE:RawHook(Plater, "OnProfileCreated", function(...)
    SE.hooks[Plater]["OnProfileCreated"](...)  -- Original zuerst
    C_Timer.After(.5, function()
        Plater.ImportScriptsFromLibrary()
        Plater.ApplyPatches()
        Plater.CompileAllScripts("script")
        Plater.CompileAllScripts("hook")
        Plater:RefreshConfig()
        Plater.UpdatePlateClickSpace()
    end)
end)
```

---

## POTENZIELLE PROBLEME

### 5. `AreAddOnsEnabled()` — Toter Code (Options.lua:153-166, 175-176)

```lua
hidden = function()
    if MUI:IsAddOnEnabled("ElvUI") or (not MUI.Retail and not AreAddOnsEnabled()) or InCombatLockdown() then
        return true
    end
end,
```

Da `MUI.Retail = true` (init.lua:17) immer gesetzt ist, wird `not MUI.Retail` **immer false**. Das `AreAddOnsEnabled()` wird also nie aufgerufen. Außerdem fehlt ein explizites `return false` am Ende von `AreAddOnsEnabled()` (gibt `nil` zurück — funktioniert, ist aber unsauber).

### 6. Core.lua:122 — `local Details = Details` zum falschen Zeitpunkt

```lua
function MUI:Initialize()
    local Details = Details  -- ← Captured bei Initialize()
```

Wenn `Details` als OptionalDep geladen wird, sollte es verfügbar sein. Aber falls `Initialize()` vor der vollständigen Initialisierung von Details aufgerufen wird, könnte `Details` noch nicht komplett sein. Die `is_first_run` / `AddDefaultCustomDisplays()`-Aufrufe könnten dann fehlschlagen. Ein `pcall` oder zusätzlicher Check wäre sicherer.

---

## CODE-DUPLIKATION

### 7. Dreifach duplizierte sequenzielle Lade-Logik

Drei nahezu identische Funktionen:
- `LoadProfilesSequential()` (Core.lua:31-92) — Für neue Charaktere
- `MUI:LoadProfiles()` (Functions.lua:148-209) — Vom Installer aus
- `InstallAllProfiles()` (Installer.lua:22-78) — Fresh Install

Alle drei haben denselben Queue-Aufbau, BigWigs-Sonderbehandlung, und C_Timer-Kette. Der Unterschied ist nur ob `SE:Setup(addon)` oder `SE:Setup(addon, true)` aufgerufen wird.

**Empfehlung:** Eine gemeinsame Funktion extrahieren:
```lua
function MUI:ProcessProfileQueue(install)
    local SE = MUI:GetModule("Setup")
    -- ... gemeinsame Queue-Logik ...
    -- install=true → SE:Setup(addon, true)
    -- install=false → SE:Setup(addon)
end
```

### 8. Dreifach duplizierte Farbkonstanten

`BLUE`, `POPUP_BG`, `POPUP_BORDER`, `EDITBOX_BG` sind in Installer.lua, Options.lua UND Changelog.lua definiert.

**Empfehlung:** In Core.lua oder init.lua zentral definieren:
```lua
MUI.Colors = {
    BLUE = {0.27, 0.54, 0.83},
    SILVER = {0.76, 0.80, 0.85},
    POPUP_BG = {0.05, 0.05, 0.05},
    ...
}
```

### 9. Dreifach duplizierter Popup-Erstellungscode

`GetOrCreateWowUpPopup`, `GetOrCreateURLPopup`, `GetOrCreateChangelogPopup` teilen sich 80% ihres Codes (Backdrop, Akzentlinie, Drag, ESC-Handling, Close-Button).

**Empfehlung:** Popup-Factory-Funktion:
```lua
function MUI:CreatePopup(name, width, height)
    -- Shared Backdrop, Drag, ESC, Close-Button
    -- Gibt Basis-Frame zurück
end
```

---

## OPTIMIERUNGEN

### 10. Math-Funktionen nicht lokalisiert (Functions.lua:280-299)

```lua
local deg = math.deg(math.atan2(...))
local rad = math.rad(angle)
local x = math.cos(rad) * radius
```

In WoW-Addons ist es Best Practice, häufig genutzte Funktionen zu lokalisieren:
```lua
local rad, deg, cos, sin, atan2 = math.rad, math.deg, math.cos, math.sin, math.atan2
```

Besonders relevant für `OnUpdate`-Handler, die jeden Frame laufen.

### 11. Minimap-Button OnUpdate ist ineffizient (Functions.lua:272-283)

Der `OnUpdate`-Handler läuft **jeden Frame** (60+ mal/Sekunde), prüft aber nur `isDragging`. Besser: Handler nur während des Draggings setzen.

```lua
btn:SetScript("OnDragStart", function(self)
    self:SetScript("OnUpdate", function(self)
        local mx, my = Minimap:GetCenter()
        local cx, cy = GetCursorPosition()
        local scale = Minimap:GetEffectiveScale()
        cx, cy = cx / scale, cy / scale
        local newAngle = deg(atan2(cy - my, cx - mx))
        MUI.db.global.minimapAngle = newAngle
        MUI:UpdateMinimapPosition(self, newAngle)
    end)
end)

btn:SetScript("OnDragStop", function(self)
    self:SetScript("OnUpdate", nil)
end)
```

### 12. `format()` für statische Strings (Functions.lua:135-141)

```lua
print(format("  |cff4A8FD9/mui|r |cffC0C8D4install|r    |cff999999- Toggle the installer|r"))
```

`format()` ohne Platzhalter ist überflüssig. Einfach `print("...")` reicht.

---

## KLEINIGKEITEN

- **SharedMedia.lua** ist komplett leer (1 Zeile). Entweder entfernen oder nutzen.
- **`MUI.db.global.version = MUI.version`** wird in mehreren Setup-Funktionen gesetzt, aber nie abgefragt (außer dem Reset-Check in init.lua:47). Das Feld `lastSeenVersion` in Changelog.lua erfüllt den gleichen Zweck.
- **Options.lua:275:** `GetAddOnMetadata("MagguuUI", "Version")` als Fallback, aber die WoW-API heißt `C_AddOns.GetAddOnMetadata` — ohne `C_AddOns`-Prefix könnte es in neueren WoW-Versionen brechen.
