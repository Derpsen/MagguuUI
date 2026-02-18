local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "deDE")
if not L then return end

-- Minimap Tooltip
L["LEFT_CLICK"] = "Installer umschalten"
L["RIGHT_CLICK"] = "Einstellungen umschalten"
L["MIDDLE_CLICK"] = "Changelog umschalten"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "Minimap-Button |cff00ff88aktiviert|r."
L["MINIMAP_DISABLED"] = "Minimap-Button |cffff4444deaktiviert|r."

-- Chat Commands
L["COMBAT_ERROR"] = "Installer kann nicht im Kampf gestartet werden."
L["AVAILABLE_COMMANDS"] = "Verfuegbare Befehle:"
L["CMD_INSTALL"] = "Installer umschalten"
L["CMD_SETTINGS"] = "Einstellungen umschalten"
L["CMD_MINIMAP"] = "Minimap-Button umschalten"
L["CMD_VERSION"] = "Addon-Version anzeigen"
L["CMD_STATUS"] = "Installierte Profile anzeigen"
L["CMD_CHANGELOG"] = "Changelog anzeigen"
L["ADDON_STATUS"] = "Addon-Status:"
L["STATUS_INSTALLED"] = "Installiert"
L["STATUS_ENABLED_NOT_INSTALLED"] = "Aktiviert, nicht installiert"
L["STATUS_NOT_ENABLED"] = "Nicht aktiviert"
L["NO_PROFILES_TO_LOAD"] = "Keine Profile zum Laden vorhanden."
L["NO_SUPPORTED_ADDONS"] = "Keine unterstuetzten Addons aktiviert."

-- Profile Queue
L["INSTALLING"] = "Installiere"
L["LOADING"] = "Lade"
L["ALL_PROFILES_INSTALLED"] = "Alle %d Profile installiert."
L["ALL_PROFILES_LOADED"] = "Alle %d Profile geladen."

-- Popups
L["RELOAD_TEXT"] = "Alle Profile erfolgreich geladen.\nKlicke auf Neuladen, um deine Einstellungen zu uebernehmen."
L["RELOAD_BUTTON"] = "Neuladen"
L["NEW_CHAR_TEXT"] = "Profile wurden auf einem anderen Charakter installiert.\nMoechtest du alle Profile auf diesen Charakter laden?"
L["NEW_CHAR_LOAD_ALL"] = "Alle Profile laden"
L["NEW_CHAR_SKIP"] = "Ueberspringen"
L["NEW_CHAR_APPLIED"] = "Profile werden nacheinander angewendet."
L["OVERWRITE_TEXT"] = "Ein Profil namens |cff4A8FD9MagguuUI|r existiert bereits fuer |cffC0C8D4%s|r.\n\nMoechtest du es ueberschreiben?"
L["OVERWRITE_BUTTON"] = "Ueberschreiben"
L["CANCEL"] = "Abbrechen"

-- Installer Pages
L["INSTALLATION"] = "Installation"
L["WELCOME_TO"] = "Willkommen bei"
L["INSTALL_ALL_DESC"] = "Klicke |cff4A8FD9Alle installieren|r um alle Profile einzurichten, oder |cffC0C8D4Weiter|r fuer Einzelinstallation"
L["LOAD_PROFILES_INSTALLER_DESC"] = "Klicke |cff4A8FD9Profile laden|r um deine Profile anzuwenden, oder |cffC0C8D4Weiter|r zum Neuinstallieren"
L["OPTIMIZED_4K"] = "Optimiert fuer 4K."
L["OTHER_RESOLUTIONS"] = "Andere Aufloesungen erfordern ggf. manuelle Anpassungen."
L["MISSING_ADDONS"] = "Addons fehlen? Kopiere einen |cff4A8FD9WowUp|r Import-String:"
L["INSTALL_ALL"] = "Alle installieren"
L["LOAD_PROFILES"] = "Profile laden"
L["REQUIRED"] = "Erforderlich"
L["OPTIONAL"] = "Optional"
L["INSTALL"] = "Installieren"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "Aktiviere ElvUI um diesen Schritt freizuschalten"
L["ELVUI_DESC1"] = "Kompletter UI-Ersatz fuer Aktionsleisten, Einheitenrahmen und mehr"
L["ELVUI_DESC2"] = "Vorkonfiguriertes Layout mit modernem Design"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "Aktiviere BetterCooldownManager um diesen Schritt freizuschalten"
L["BCM_DESC1"] = "Erweiterte Abklingzeit-Verfolgung mit flexiblen Leisten"
L["BCM_DESC2"] = "Vorkonfigurierte Leisten fuer Zauber, Gegenstaende und Schmuckstuecke"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "Aktiviere BigWigs um diesen Schritt freizuschalten"
L["BIGWIGS_DESC1"] = "Leichtgewichtiges Boss-Mod mit Warnungen, Timern und Sounds"
L["BIGWIGS_DESC2"] = "Vorkonfigurierte Leistenpositionen und Soundeinstellungen"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "Blizzards integrierter UI-Layout-Editor fuer HUD-Elemente"
L["EDITMODE_DESC2"] = "Installiert ein vorkonfiguriertes MagguuUI-Layout"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "Aktiviere Details um diesen Schritt freizuschalten"
L["DETAILS_DESC1"] = "Echtzeit-Kampfmesser fuer Schaden, Heilung und mehr"
L["DETAILS_DESC2"] = "Vorkonfiguriertes Fensterlayout mit modernem Stil"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "Aktiviere Plater um diesen Schritt freizuschalten"
L["PLATER_DESC1"] = "Anpassbare Namensplaketten mit Lebens- und Zauberleisten"
L["PLATER_DESC2"] = "Vorkonfiguriert mit Bedrohungsfarben und modernem Stil"
L["REQUIRES_RELOAD"] = "Erfordert ein UI-Neuladen nach der Installation"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "Klassenspezifische Layouts fuer"
L["CLASS_LAYOUTS_DESC2"] = "Waehlt automatisch das Layout passend zur aktiven Spezialisierung"
L["CLASS_LAYOUTS_DESC3"] = "Erneut installieren? Alte Layouts vorher manuell im EditMode loeschen"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "Installation abgeschlossen"
L["COMPLETED_DESC1"] = "Du hast den Installationsprozess abgeschlossen"
L["COMPLETED_DESC2"] = "Klicke |cffC0C8D4Neuladen|r um deine Einstellungen zu speichern"

-- Installer: Step Titles
L["STEP_WELCOME"] = "Willkommen"
L["STEP_COMPLETE"] = "Fertig"
L["STEP_LAYOUTS"] = "Layouts"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "Profil: Aktiv"
L["PROFILE_INSTALLED"] = "Profil: Installiert"
L["PROFILE_NOT_INSTALLED"] = "Profil: Nicht installiert"

-- WowUp Popup
L["COPY_HINT"] = "Klicke den Text unten um alles zu markieren, dann druecke |cffC0C8D4Strg+C|r zum Kopieren"
L["COPIED"] = "Kopiert!"
L["CLOSE"] = "Schliessen"
L["NO_WOWUP_STRING"] = "Kein WowUp-String konfiguriert"
L["NO_REQUIRED_STRING"] = "Kein String fuer erforderliche Addons konfiguriert"
L["NO_OPTIONAL_STRING"] = "Kein String fuer optionale Addons konfiguriert"

-- URL Popup
L["PRESS_CTRL_C"] = "Druecke |cffC0C8D4Strg+C|r zum Kopieren"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "Minimap-Button anzeigen"
L["SHOW_MINIMAP_BUTTON_DESC"] = "Minimap-Button ein- oder ausblenden"
L["SHOW_CHANGELOG_ON_UPDATE"] = "Changelog bei Update anzeigen"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "Changelog-Popup anzeigen, wenn eine neue Version erkannt wird"

-- Settings: Installer
L["INSTALLER_DESC"] = "MagguuUI-Profile fuer alle unterstuetzten Addons installieren oder laden."
L["RESOLUTION_NOTICE"] = "Optimiert fuer 4K (3840x2160)."
L["RESOLUTION_NOTICE_SUB"] = "Andere Aufloesungen erfordern ggf. manuelle Anpassungen."
L["OPEN_INSTALLER"] = "Installer oeffnen"
L["OPEN_INSTALLER_DESC"] = "Oeffnet den schrittweisen MagguuUI-Installationsassistenten"
L["INSTALL_ALL_PROFILES"] = "Alle Profile installieren"
L["INSTALL_ALL_PROFILES_DESC"] = "Alle MagguuUI-Profile auf einmal installieren (ElvUI, BCM, EditMode, Details, Plater)"
L["LOAD_PROFILES_BUTTON"] = "Profile laden"
L["LOAD_PROFILES_DESC"] = "Gespeicherte Profile auf diesem Charakter laden"
L["PROFILE_STATUS"] = "Profil-Status"

-- Settings: Profile Status
L["ACTIVE"] = "Aktiv"
L["NOT_INSTALLED"] = "Nicht installiert"
L["NOT_ENABLED"] = "Nicht aktiviert"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "Addon-Import"
L["WOWUP_DESC"] = "MagguuUI nutzt mehrere Addons. Du kannst sie mit der |cff4A8FD9WowUp|r Import-Funktion installieren."
L["WOWUP_REQUIRED_DESC"] = "Kern-Addons fuer MagguuUI"
L["WOWUP_OPTIONAL_DESC"] = "Zusaetzliche Addons fuer das beste Erlebnis"
L["WOWUP_HOW_TO"] = "Anleitung"
L["COPY_REQUIRED_ADDONS"] = "Erforderliche Addons kopieren"
L["COPY_REQUIRED_DESC"] = "Oeffnet ein Popup mit dem WowUp Import-String fuer erforderliche Addons"
L["COPY_OPTIONAL_ADDONS"] = "Optionale Addons kopieren"
L["COPY_OPTIONAL_DESC"] = "Oeffnet ein Popup mit dem WowUp Import-String fuer optionale Addons"
L["REQUIRED_ADDONS"] = "Erforderliche Addons"
L["OPTIONAL_ADDONS"] = "Optionale Addons"
L["NO_ADDON_DATA"] = "Keine Addon-Daten verfuegbar."
L["NO_ADDON_DATA_RELOAD"] = "Keine Addon-Daten verfuegbar. Fuehre /reload aus."

-- Settings: Information
L["AUTHOR"] = "Autor"
L["LINKS_SUPPORT"] = "Links & Support"
L["WEBSITE"] = "Webseite"
L["OPEN_WEBSITE"] = "Webseite oeffnen"
L["OPEN_WEBSITE_DESC"] = "Kopiert die Webseiten-URL in die Zwischenablage"
L["LICENSE"] = "Lizenz"
L["VERSION_INFO"] = "Versionsinformationen"
L["ADDON_STATUS_HEADER"] = "Addon-Status"
L["SHOW_CHANGELOG"] = "Changelog anzeigen"
L["SHOW_CHANGELOG_DESC"] = "Zeige Aenderungen der letzten Updates"

-- Changelog
L["WHATS_NEW"] = "Was ist neu in diesem Update"
L["GOT_IT"] = "Verstanden!"
L["GOT_IT_DESC"] = "Als gelesen markieren — das Changelog-Popup wird fuer diese Version nicht mehr angezeigt."
L["RELEASED"] = "Veroeffentlicht"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "Profile"
L["SETTINGS"] = "Einstellungen"
L["SETUP_ADDON"] = "%s einrichten"
L["SUCCESS"] = "Erfolgreich"
L["YOUR_CLASS"] = "deine Klasse"
