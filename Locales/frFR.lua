local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "frFR")
if not L then return end

-- Minimap Tooltip
L["LEFT_CLICK"] = "Ouvrir/fermer l'installateur"
L["RIGHT_CLICK"] = "Ouvrir/fermer les parametres"
L["MIDDLE_CLICK"] = "Ouvrir/fermer le changelog"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "Bouton de la minicarte |cff00ff88active|r."
L["MINIMAP_DISABLED"] = "Bouton de la minicarte |cffff4444desactive|r."

-- Chat Commands
L["COMBAT_ERROR"] = "Impossible de lancer l'installateur en combat."
L["AVAILABLE_COMMANDS"] = "Commandes disponibles :"
L["CMD_INSTALL"] = "Ouvrir/fermer l'installateur"
L["CMD_SETTINGS"] = "Ouvrir/fermer le panneau des parametres"
L["CMD_MINIMAP"] = "Afficher/masquer le bouton de la minicarte"
L["CMD_VERSION"] = "Afficher la version de l'addon"
L["CMD_STATUS"] = "Afficher les profils installes"
L["CMD_CHANGELOG"] = "Afficher le changelog"
L["ADDON_STATUS"] = "Statut des addons :"
L["STATUS_INSTALLED"] = "Installe"
L["STATUS_ENABLED_NOT_INSTALLED"] = "Active, non installe"
L["STATUS_NOT_ENABLED"] = "Non active"
L["NO_PROFILES_TO_LOAD"] = "Aucun profil a charger."
L["NO_SUPPORTED_ADDONS"] = "Aucun addon supporte n'est active."

-- Profile Queue
L["INSTALLING"] = "Installation de"
L["LOADING"] = "Chargement de"
L["ALL_PROFILES_INSTALLED"] = "Les %d profils ont ete installes."
L["ALL_PROFILES_LOADED"] = "Les %d profils ont ete charges."

-- Popups
L["RELOAD_TEXT"] = "Tous les profils ont ete charges avec succes.\nCliquez sur Recharger pour appliquer vos parametres."
L["RELOAD_BUTTON"] = "Recharger"
L["NEW_CHAR_TEXT"] = "Des profils ont ete installes sur un autre personnage.\nVoulez-vous charger tous les profils sur ce personnage ?"
L["NEW_CHAR_LOAD_ALL"] = "Charger tous les profils"
L["NEW_CHAR_SKIP"] = "Passer"
L["NEW_CHAR_APPLIED"] = "Les profils seront appliques un par un."
L["OVERWRITE_TEXT"] = "Un profil nomme |cff4A8FD9MagguuUI|r existe deja pour |cffC0C8D4%s|r.\n\nVoulez-vous l'ecraser ?"
L["OVERWRITE_BUTTON"] = "Ecraser"
L["CANCEL"] = "Annuler"

-- Installer Pages
L["INSTALLATION"] = "Installation"
L["WELCOME_TO"] = "Bienvenue dans"
L["INSTALL_ALL_DESC"] = "Cliquez sur |cff4A8FD9Tout installer|r pour configurer tous les profils d'un coup, ou cliquez sur |cffC0C8D4Continuer|r pour installer individuellement"
L["LOAD_PROFILES_INSTALLER_DESC"] = "Cliquez sur |cff4A8FD9Charger les profils|r pour appliquer vos profils, ou cliquez sur |cffC0C8D4Continuer|r pour reinstaller individuellement"
L["OPTIMIZED_4K"] = "Optimise pour le 4K."
L["OTHER_RESOLUTIONS"] = "D'autres resolutions peuvent necessiter des ajustements manuels."
L["MISSING_ADDONS"] = "Addons manquants ? Copiez une chaine d'import |cff4A8FD9WowUp|r :"
L["INSTALL_ALL"] = "Tout installer"
L["LOAD_PROFILES"] = "Charger les profils"
L["REQUIRED"] = "Requis"
L["OPTIONAL"] = "Optionnel"
L["INSTALL"] = "Installer"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "Activez ElvUI pour debloquer cette etape"
L["ELVUI_DESC1"] = "Remplacement complet de l'interface pour les barres d'action, les cadres d'unite et plus encore"
L["ELVUI_DESC2"] = "Disposition preconfiguree avec un style moderne et epure"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "Activez BetterCooldownManager pour debloquer cette etape"
L["BCM_DESC1"] = "Suivi ameliore des temps de recharge avec des barres flexibles"
L["BCM_DESC2"] = "Barres preconfigurees pour les sorts, objets et bijoux"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "Activez BigWigs pour debloquer cette etape"
L["BIGWIGS_DESC1"] = "Mod de boss leger avec alertes, minuteries et sons"
L["BIGWIGS_DESC2"] = "Positions des barres et parametres sonores preconfigures"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "Editeur de disposition integre de Blizzard pour les elements de l'ATH"
L["EDITMODE_DESC2"] = "Installe une disposition MagguuUI preconfiguree"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "Activez Details pour debloquer cette etape"
L["DETAILS_DESC1"] = "Compteur de combat en temps reel pour les degats, les soins et plus encore"
L["DETAILS_DESC2"] = "Disposition de fenetre preconfiguree avec un style epure"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "Activez Plater pour debloquer cette etape"
L["PLATER_DESC1"] = "Barres de nom personnalisables avec barres de vie et d'incantation"
L["PLATER_DESC2"] = "Preconfigure avec coloration de menace et style epure"
L["REQUIRES_RELOAD"] = "Necessite un rechargement de l'interface apres l'installation"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "Dispositions specifiques a la classe pour"
L["CLASS_LAYOUTS_DESC2"] = "Selectionne automatiquement la disposition correspondant a votre specialisation active"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "Installation terminee"
L["COMPLETED_DESC1"] = "Vous avez termine le processus d'installation"
L["COMPLETED_DESC2"] = "Cliquez sur |cffC0C8D4Recharger|r pour sauvegarder vos parametres"

-- Installer: Step Titles
L["STEP_WELCOME"] = "Bienvenue"
L["STEP_COMPLETE"] = "Termine"
L["STEP_LAYOUTS"] = "Dispositions"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "Profil : Actif"
L["PROFILE_INSTALLED"] = "Profil : Installe"
L["PROFILE_NOT_INSTALLED"] = "Profil : Non installe"

-- WowUp Popup
L["COPY_HINT"] = "Cliquez sur le texte ci-dessous pour tout selectionner, puis appuyez sur |cffC0C8D4Ctrl+C|r pour copier"
L["COPIED"] = "Copie !"
L["CLOSE"] = "Fermer"
L["NO_WOWUP_STRING"] = "Aucune chaine WowUp configuree"
L["NO_REQUIRED_STRING"] = "Aucune chaine d'addons requis configuree"
L["NO_OPTIONAL_STRING"] = "Aucune chaine d'addons optionnels configuree"

-- URL Popup
L["PRESS_CTRL_C"] = "Appuyez sur |cffC0C8D4Ctrl+C|r pour copier"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "Afficher le bouton de la minicarte"
L["SHOW_MINIMAP_BUTTON_DESC"] = "Afficher ou masquer le bouton de la minicarte"
L["SHOW_CHANGELOG_ON_UPDATE"] = "Afficher le changelog lors d'une mise a jour"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "Afficher le popup du changelog lorsqu'une nouvelle version est detectee"

-- Settings: Installer
L["INSTALLER_DESC"] = "Installez ou chargez les profils MagguuUI pour tous les addons supportes."
L["RESOLUTION_NOTICE"] = "Optimise pour le 4K (3840x2160)."
L["RESOLUTION_NOTICE_SUB"] = "D'autres resolutions peuvent necessiter des ajustements manuels."
L["OPEN_INSTALLER"] = "Ouvrir l'installateur"
L["OPEN_INSTALLER_DESC"] = "Ouvre l'assistant d'installation MagguuUI etape par etape"
L["INSTALL_ALL_PROFILES"] = "Installer tous les profils"
L["INSTALL_ALL_PROFILES_DESC"] = "Installer tous les profils MagguuUI d'un coup (ElvUI, BCM, EditMode, Details, Plater)"
L["LOAD_PROFILES_BUTTON"] = "Charger les profils"
L["LOAD_PROFILES_DESC"] = "Charger les profils precedemment sauvegardes sur ce personnage"
L["PROFILE_STATUS"] = "Statut des profils"

-- Settings: Profile Status
L["ACTIVE"] = "Actif"
L["NOT_INSTALLED"] = "Non installe"
L["NOT_ENABLED"] = "Non active"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "Importation d'addons"
L["WOWUP_DESC"] = "MagguuUI utilise plusieurs addons. Vous pouvez les installer via la fonction d'import de |cff4A8FD9WowUp|r."
L["WOWUP_REQUIRED_DESC"] = "Addons essentiels necessaires pour MagguuUI"
L["WOWUP_OPTIONAL_DESC"] = "Addons supplementaires pour la meilleure experience"
L["WOWUP_HOW_TO"] = "Comment utiliser"
L["COPY_REQUIRED_ADDONS"] = "Copier les addons requis"
L["COPY_REQUIRED_DESC"] = "Ouvre un popup avec la chaine d'import WowUp pour les addons requis"
L["COPY_OPTIONAL_ADDONS"] = "Copier les addons optionnels"
L["COPY_OPTIONAL_DESC"] = "Ouvre un popup avec la chaine d'import WowUp pour les addons optionnels"
L["REQUIRED_ADDONS"] = "Addons requis"
L["OPTIONAL_ADDONS"] = "Addons optionnels"
L["NO_ADDON_DATA"] = "Aucune donnee d'addon disponible."
L["NO_ADDON_DATA_RELOAD"] = "Aucune donnee d'addon disponible. Faites /reload apres la mise a jour."

-- Settings: Information
L["AUTHOR"] = "Auteur"
L["LINKS_SUPPORT"] = "Liens et support"
L["WEBSITE"] = "Site web"
L["OPEN_WEBSITE"] = "Ouvrir le site web"
L["OPEN_WEBSITE_DESC"] = "Copie l'URL du site web dans votre presse-papiers"
L["LICENSE"] = "Licence"
L["VERSION_INFO"] = "Informations de version"
L["ADDON_STATUS_HEADER"] = "Statut des addons"
L["SHOW_CHANGELOG"] = "Afficher le changelog"
L["SHOW_CHANGELOG_DESC"] = "Afficher les changements des dernieres mises a jour"

-- Changelog
L["WHATS_NEW"] = "Nouveautes de cette mise a jour"
L["GOT_IT"] = "Compris !"
L["GOT_IT_DESC"] = "Marquer comme lu -- le popup du changelog ne s'affichera plus pour cette version a la prochaine connexion."
L["RELEASED"] = "Publie le"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "Profils"
L["SETTINGS"] = "Parametres"
L["SETUP_ADDON"] = "Configurer %s"
L["SUCCESS"] = "Succes"
L["YOUR_CLASS"] = "votre classe"
