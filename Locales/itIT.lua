local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "itIT")
if not L then return end

-- Minimap Tooltip
L["LEFT_CLICK"] = "Attiva/Disattiva installatore"
L["RIGHT_CLICK"] = "Attiva/Disattiva impostazioni"
L["MIDDLE_CLICK"] = "Attiva/Disattiva changelog"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "Pulsante minimappa |cff00ff88attivato|r."
L["MINIMAP_DISABLED"] = "Pulsante minimappa |cffff4444disattivato|r."

-- Chat Commands
L["COMBAT_ERROR"] = "Impossibile avviare l'installatore durante il combattimento."
L["AVAILABLE_COMMANDS"] = "Comandi disponibili:"
L["CMD_INSTALL"] = "Attiva/Disattiva l'installatore"
L["CMD_SETTINGS"] = "Attiva/Disattiva pannello impostazioni"
L["CMD_MINIMAP"] = "Attiva/Disattiva pulsante minimappa"
L["CMD_VERSION"] = "Mostra versione addon"
L["CMD_STATUS"] = "Mostra profili installati"
L["CMD_CHANGELOG"] = "Mostra changelog"
L["ADDON_STATUS"] = "Stato degli Addon:"
L["STATUS_INSTALLED"] = "Installato"
L["STATUS_ENABLED_NOT_INSTALLED"] = "Attivato, non installato"
L["STATUS_NOT_ENABLED"] = "Non attivato"
L["NO_PROFILES_TO_LOAD"] = "Nessun profilo da caricare."
L["NO_SUPPORTED_ADDONS"] = "Nessun addon supportato e attivato."

-- Profile Queue
L["INSTALLING"] = "Installazione"
L["LOADING"] = "Caricamento"
L["ALL_PROFILES_INSTALLED"] = "Tutti i %d profili installati."
L["ALL_PROFILES_LOADED"] = "Tutti i %d profili caricati."

-- Popups
L["RELOAD_TEXT"] = "Tutti i profili caricati con successo.\nClicca Ricarica per applicare le impostazioni."
L["RELOAD_BUTTON"] = "Ricarica"
L["NEW_CHAR_TEXT"] = "I profili sono stati installati su un altro personaggio.\nVuoi caricare tutti i profili su questo personaggio?"
L["NEW_CHAR_LOAD_ALL"] = "Carica Tutti i Profili"
L["NEW_CHAR_SKIP"] = "Salta"
L["NEW_CHAR_APPLIED"] = "I profili verranno applicati uno alla volta."
L["OVERWRITE_TEXT"] = "Un profilo chiamato |cff4A8FD9MagguuUI|r esiste gia per |cffC0C8D4%s|r.\n\nVuoi sovrascriverlo?"
L["OVERWRITE_BUTTON"] = "Sovrascrivi"
L["CANCEL"] = "Annulla"

-- Installer Pages
L["INSTALLATION"] = "Installazione"
L["WELCOME_TO"] = "Benvenuto in"
L["INSTALL_ALL_DESC"] = "Clicca |cff4A8FD9Installa Tutto|r per configurare tutti i profili in una volta, oppure clicca |cffC0C8D4Continua|r per installare singolarmente"
L["LOAD_PROFILES_INSTALLER_DESC"] = "Clicca |cff4A8FD9Carica Profili|r per applicare i tuoi profili, oppure clicca |cffC0C8D4Continua|r per reinstallare singolarmente"
L["OPTIMIZED_4K"] = "Ottimizzato per 4K."
L["OTHER_RESOLUTIONS"] = "Altre risoluzioni potrebbero richiedere regolazioni manuali."
L["MISSING_ADDONS"] = "Addon mancanti? Copia una stringa di importazione |cff4A8FD9WowUp|r:"
L["INSTALL_ALL"] = "Installa Tutto"
L["LOAD_PROFILES"] = "Carica Profili"
L["REQUIRED"] = "Obbligatorio"
L["OPTIONAL"] = "Opzionale"
L["INSTALL"] = "Installa"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "Attiva ElvUI per sbloccare questo passaggio"
L["ELVUI_DESC1"] = "Sostituzione completa dell'interfaccia: barre azioni, riquadri unita e altro"
L["ELVUI_DESC2"] = "Layout preconfigurato con stile pulito e moderno"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "Attiva BetterCooldownManager per sbloccare questo passaggio"
L["BCM_DESC1"] = "Tracciamento avanzato dei cooldown con layout delle barre flessibili"
L["BCM_DESC2"] = "Barre preconfigurate per incantesimi, oggetti e accessori"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "Attiva BigWigs per sbloccare questo passaggio"
L["BIGWIGS_DESC1"] = "Mod boss leggero con avvisi, timer e suoni"
L["BIGWIGS_DESC2"] = "Posizioni delle barre e impostazioni audio preconfigurate"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "Editor di layout dell'interfaccia integrato di Blizzard per gli elementi HUD"
L["EDITMODE_DESC2"] = "Installa un layout MagguuUI preconfigurato"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "Attiva Details per sbloccare questo passaggio"
L["DETAILS_DESC1"] = "Misuratore di combattimento in tempo reale per danni, cure e altro"
L["DETAILS_DESC2"] = "Layout finestra preconfigurato con stile pulito"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "Attiva Plater per sbloccare questo passaggio"
L["PLATER_DESC1"] = "Targhe personalizzabili con barre di salute e lancio"
L["PLATER_DESC2"] = "Preconfigurato con colori di minaccia e stile pulito"
L["REQUIRES_RELOAD"] = "Richiede un ricaricamento dell'interfaccia dopo l'installazione"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "Layout specifici per la classe"
L["CLASS_LAYOUTS_DESC2"] = "Seleziona automaticamente il layout corrispondente alla specializzazione attiva"
L["CLASS_LAYOUTS_DESC3"] = "Reinstallazione? Elimina prima i vecchi layout manualmente in EditMode"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "Installazione Completata"
L["COMPLETED_DESC1"] = "Hai completato il processo di installazione"
L["COMPLETED_DESC2"] = "Clicca |cffC0C8D4Ricarica|r per salvare le impostazioni"

-- Installer: Step Titles
L["STEP_WELCOME"] = "Benvenuto"
L["STEP_COMPLETE"] = "Completato"
L["STEP_LAYOUTS"] = "Layout"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "Profilo: Attivo"
L["PROFILE_INSTALLED"] = "Profilo: Installato"
L["PROFILE_NOT_INSTALLED"] = "Profilo: Non installato"

-- WowUp Popup
L["COPY_HINT"] = "Clicca il testo qui sotto per selezionare tutto, poi premi |cffC0C8D4Ctrl+C|r per copiare"
L["COPIED"] = "Copiato!"
L["CLOSE"] = "Chiudi"
L["NO_WOWUP_STRING"] = "Nessuna stringa WowUp configurata"
L["NO_REQUIRED_STRING"] = "Nessuna stringa di addon obbligatori configurata"
L["NO_OPTIONAL_STRING"] = "Nessuna stringa di addon opzionali configurata"

-- URL Popup
L["PRESS_CTRL_C"] = "Premi |cffC0C8D4Ctrl+C|r per copiare"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "Mostra Pulsante Minimappa"
L["SHOW_MINIMAP_BUTTON_DESC"] = "Attiva o disattiva il pulsante della minimappa"
L["SHOW_CHANGELOG_ON_UPDATE"] = "Mostra Changelog all'Aggiornamento"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "Mostra il popup del changelog quando viene rilevata una nuova versione"

-- Settings: Installer
L["INSTALLER_DESC"] = "Installa o carica i profili MagguuUI per tutti gli addon supportati."
L["RESOLUTION_NOTICE"] = "Ottimizzato per 4K (3840x2160)."
L["RESOLUTION_NOTICE_SUB"] = "Altre risoluzioni potrebbero richiedere regolazioni manuali."
L["OPEN_INSTALLER"] = "Apri Installatore"
L["OPEN_INSTALLER_DESC"] = "Apre la procedura guidata di installazione passo per passo di MagguuUI"
L["INSTALL_ALL_PROFILES"] = "Installa Tutti i Profili"
L["INSTALL_ALL_PROFILES_DESC"] = "Installa tutti i profili MagguuUI in una volta (ElvUI, BCM, EditMode, Details, Plater)"
L["LOAD_PROFILES_BUTTON"] = "Carica Profili"
L["LOAD_PROFILES_DESC"] = "Carica i profili salvati in precedenza su questo personaggio"
L["PROFILE_STATUS"] = "Stato del Profilo"

-- Settings: Profile Status
L["ACTIVE"] = "Attivo"
L["NOT_INSTALLED"] = "Non installato"
L["NOT_ENABLED"] = "Non attivato"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "Importazione Addon"
L["WOWUP_DESC"] = "MagguuUI utilizza diversi addon. Puoi installarli usando la funzione di importazione di |cff4A8FD9WowUp|r."
L["WOWUP_REQUIRED_DESC"] = "Addon principali necessari per MagguuUI"
L["WOWUP_OPTIONAL_DESC"] = "Addon extra per la migliore esperienza"
L["WOWUP_HOW_TO"] = "Come usare"
L["COPY_REQUIRED_ADDONS"] = "Copia Addon Obbligatori"
L["COPY_REQUIRED_DESC"] = "Apre un popup con la stringa di importazione WowUp per gli addon obbligatori"
L["COPY_OPTIONAL_ADDONS"] = "Copia Addon Opzionali"
L["COPY_OPTIONAL_DESC"] = "Apre un popup con la stringa di importazione WowUp per gli addon opzionali"
L["REQUIRED_ADDONS"] = "Addon Obbligatori"
L["OPTIONAL_ADDONS"] = "Addon Opzionali"
L["NO_ADDON_DATA"] = "Nessun dato addon disponibile."
L["NO_ADDON_DATA_RELOAD"] = "Nessun dato addon disponibile. Esegui /reload dopo l'aggiornamento."

-- Settings: Information
L["AUTHOR"] = "Autore"
L["LINKS_SUPPORT"] = "Link e Supporto"
L["WEBSITE"] = "Sito Web"
L["OPEN_WEBSITE"] = "Apri Sito Web"
L["OPEN_WEBSITE_DESC"] = "Copia l'URL del sito web negli appunti"
L["LICENSE"] = "Licenza"
L["VERSION_INFO"] = "Info Versione"
L["ADDON_STATUS_HEADER"] = "Stato degli Addon"
L["SHOW_CHANGELOG"] = "Mostra Changelog"
L["SHOW_CHANGELOG_DESC"] = "Mostra cosa e cambiato negli aggiornamenti recenti"

-- Changelog
L["WHATS_NEW"] = "Cosa c'e di nuovo in questo aggiornamento"
L["GOT_IT"] = "Capito!"
L["GOT_IT_DESC"] = "Segna come letto -- il popup del changelog non verra mostrato per questa versione al prossimo accesso."
L["RELEASED"] = "Rilasciato"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "Profili"
L["SETTINGS"] = "Impostazioni"
L["SETUP_ADDON"] = "Configura %s"
L["SUCCESS"] = "Successo"
L["YOUR_CLASS"] = "la tua classe"
