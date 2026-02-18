local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "esES")
if not L then return end

-- Minimap Tooltip
L["LEFT_CLICK"] = "Abrir/cerrar el instalador"
L["RIGHT_CLICK"] = "Abrir/cerrar los ajustes"
L["MIDDLE_CLICK"] = "Abrir/cerrar el registro de cambios"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "Boton del minimapa |cff00ff88activado|r."
L["MINIMAP_DISABLED"] = "Boton del minimapa |cffff4444desactivado|r."

-- Chat Commands
L["COMBAT_ERROR"] = "No se puede ejecutar el instalador durante el combate."
L["AVAILABLE_COMMANDS"] = "Comandos disponibles:"
L["CMD_INSTALL"] = "Abrir/cerrar el instalador"
L["CMD_SETTINGS"] = "Abrir/cerrar el panel de ajustes"
L["CMD_MINIMAP"] = "Mostrar/ocultar el boton del minimapa"
L["CMD_VERSION"] = "Mostrar la version del addon"
L["CMD_STATUS"] = "Mostrar los perfiles instalados"
L["CMD_CHANGELOG"] = "Mostrar el registro de cambios"
L["ADDON_STATUS"] = "Estado de los addons:"
L["STATUS_INSTALLED"] = "Instalado"
L["STATUS_ENABLED_NOT_INSTALLED"] = "Activado, no instalado"
L["STATUS_NOT_ENABLED"] = "No activado"
L["NO_PROFILES_TO_LOAD"] = "No hay perfiles para cargar."
L["NO_SUPPORTED_ADDONS"] = "No hay addons compatibles activados."

-- Profile Queue
L["INSTALLING"] = "Instalando"
L["LOADING"] = "Cargando"
L["ALL_PROFILES_INSTALLED"] = "Los %d perfiles han sido instalados."
L["ALL_PROFILES_LOADED"] = "Los %d perfiles han sido cargados."

-- Popups
L["RELOAD_TEXT"] = "Todos los perfiles se han cargado correctamente.\nHaz clic en Recargar para aplicar tus ajustes."
L["RELOAD_BUTTON"] = "Recargar"
L["NEW_CHAR_TEXT"] = "Se han instalado perfiles en otro personaje.\nQuieres cargar todos los perfiles en este personaje?"
L["NEW_CHAR_LOAD_ALL"] = "Cargar todos los perfiles"
L["NEW_CHAR_SKIP"] = "Omitir"
L["NEW_CHAR_APPLIED"] = "Los perfiles se aplicaran uno por uno."
L["OVERWRITE_TEXT"] = "Ya existe un perfil llamado |cff4A8FD9MagguuUI|r para |cffC0C8D4%s|r.\n\nQuieres sobrescribirlo?"
L["OVERWRITE_BUTTON"] = "Sobrescribir"
L["CANCEL"] = "Cancelar"

-- Installer Pages
L["INSTALLATION"] = "Instalacion"
L["WELCOME_TO"] = "Bienvenido a"
L["INSTALL_ALL_DESC"] = "Haz clic en |cff4A8FD9Instalar todo|r para configurar todos los perfiles de una vez, o haz clic en |cffC0C8D4Continuar|r para instalar individualmente"
L["LOAD_PROFILES_INSTALLER_DESC"] = "Haz clic en |cff4A8FD9Cargar perfiles|r para aplicar tus perfiles, o haz clic en |cffC0C8D4Continuar|r para reinstalar individualmente"
L["OPTIMIZED_4K"] = "Optimizado para 4K."
L["OTHER_RESOLUTIONS"] = "Otras resoluciones pueden necesitar ajustes manuales."
L["MISSING_ADDONS"] = "Faltan addons? Copia una cadena de importacion de |cff4A8FD9WowUp|r:"
L["INSTALL_ALL"] = "Instalar todo"
L["LOAD_PROFILES"] = "Cargar perfiles"
L["REQUIRED"] = "Requerido"
L["OPTIONAL"] = "Opcional"
L["INSTALL"] = "Instalar"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "Activa ElvUI para desbloquear este paso"
L["ELVUI_DESC1"] = "Reemplazo completo de la interfaz para barras de accion, marcos de unidades y mas"
L["ELVUI_DESC2"] = "Disposicion preconfigurada con un estilo moderno y limpio"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "Activa BetterCooldownManager para desbloquear este paso"
L["BCM_DESC1"] = "Seguimiento mejorado de tiempos de reutilizacion con barras flexibles"
L["BCM_DESC2"] = "Barras preconfiguradas para hechizos, objetos y abalorios"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "Activa BigWigs para desbloquear este paso"
L["BIGWIGS_DESC1"] = "Mod de jefes ligero con alertas, temporizadores y sonidos"
L["BIGWIGS_DESC2"] = "Posiciones de barras y ajustes de sonido preconfigurados"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "Editor de disposicion integrado de Blizzard para elementos del HUD"
L["EDITMODE_DESC2"] = "Instala una disposicion MagguuUI preconfigurada"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "Activa Details para desbloquear este paso"
L["DETAILS_DESC1"] = "Medidor de combate en tiempo real para dano, sanacion y mas"
L["DETAILS_DESC2"] = "Disposicion de ventana preconfigurada con un estilo limpio"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "Activa Plater para desbloquear este paso"
L["PLATER_DESC1"] = "Placas de nombre personalizables con barras de vida y lanzamiento"
L["PLATER_DESC2"] = "Preconfigurado con coloracion de amenaza y estilo limpio"
L["REQUIRES_RELOAD"] = "Requiere recargar la interfaz despues de la instalacion"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "Disposiciones especificas de clase para"
L["CLASS_LAYOUTS_DESC2"] = "Selecciona automaticamente la disposicion que coincide con tu especializacion activa"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "Instalacion completada"
L["COMPLETED_DESC1"] = "Has completado el proceso de instalacion"
L["COMPLETED_DESC2"] = "Haz clic en |cffC0C8D4Recargar|r para guardar tus ajustes"

-- Installer: Step Titles
L["STEP_WELCOME"] = "Bienvenida"
L["STEP_COMPLETE"] = "Completado"
L["STEP_LAYOUTS"] = "Disposiciones"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "Perfil: Activo"
L["PROFILE_INSTALLED"] = "Perfil: Instalado"
L["PROFILE_NOT_INSTALLED"] = "Perfil: No instalado"

-- WowUp Popup
L["COPY_HINT"] = "Haz clic en el texto de abajo para seleccionar todo, luego pulsa |cffC0C8D4Ctrl+C|r para copiar"
L["COPIED"] = "Copiado!"
L["CLOSE"] = "Cerrar"
L["NO_WOWUP_STRING"] = "No hay cadena de WowUp configurada"
L["NO_REQUIRED_STRING"] = "No hay cadena de addons requeridos configurada"
L["NO_OPTIONAL_STRING"] = "No hay cadena de addons opcionales configurada"

-- URL Popup
L["PRESS_CTRL_C"] = "Pulsa |cffC0C8D4Ctrl+C|r para copiar"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "Mostrar boton del minimapa"
L["SHOW_MINIMAP_BUTTON_DESC"] = "Mostrar u ocultar el boton del minimapa"
L["SHOW_CHANGELOG_ON_UPDATE"] = "Mostrar registro de cambios al actualizar"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "Mostrar el popup del registro de cambios cuando se detecte una nueva version"

-- Settings: Installer
L["INSTALLER_DESC"] = "Instala o carga los perfiles de MagguuUI para todos los addons compatibles."
L["RESOLUTION_NOTICE"] = "Optimizado para 4K (3840x2160)."
L["RESOLUTION_NOTICE_SUB"] = "Otras resoluciones pueden necesitar ajustes manuales."
L["OPEN_INSTALLER"] = "Abrir instalador"
L["OPEN_INSTALLER_DESC"] = "Abre el asistente de instalacion paso a paso de MagguuUI"
L["INSTALL_ALL_PROFILES"] = "Instalar todos los perfiles"
L["INSTALL_ALL_PROFILES_DESC"] = "Instalar todos los perfiles de MagguuUI de una vez (ElvUI, BCM, EditMode, Details, Plater)"
L["LOAD_PROFILES_BUTTON"] = "Cargar perfiles"
L["LOAD_PROFILES_DESC"] = "Cargar perfiles previamente guardados en este personaje"
L["PROFILE_STATUS"] = "Estado de los perfiles"

-- Settings: Profile Status
L["ACTIVE"] = "Activo"
L["NOT_INSTALLED"] = "No instalado"
L["NOT_ENABLED"] = "No activado"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "Importacion de addons"
L["WOWUP_DESC"] = "MagguuUI utiliza varios addons. Puedes instalarlos usando la funcion de importacion de |cff4A8FD9WowUp|r."
L["WOWUP_REQUIRED_DESC"] = "Addons principales necesarios para MagguuUI"
L["WOWUP_OPTIONAL_DESC"] = "Addons adicionales para la mejor experiencia"
L["WOWUP_HOW_TO"] = "Como usar"
L["COPY_REQUIRED_ADDONS"] = "Copiar addons requeridos"
L["COPY_REQUIRED_DESC"] = "Abre un popup con la cadena de importacion de WowUp para los addons requeridos"
L["COPY_OPTIONAL_ADDONS"] = "Copiar addons opcionales"
L["COPY_OPTIONAL_DESC"] = "Abre un popup con la cadena de importacion de WowUp para los addons opcionales"
L["REQUIRED_ADDONS"] = "Addons requeridos"
L["OPTIONAL_ADDONS"] = "Addons opcionales"
L["NO_ADDON_DATA"] = "No hay datos de addons disponibles."
L["NO_ADDON_DATA_RELOAD"] = "No hay datos de addons disponibles. Ejecuta /reload despues de actualizar."

-- Settings: Information
L["AUTHOR"] = "Autor"
L["LINKS_SUPPORT"] = "Enlaces y soporte"
L["WEBSITE"] = "Sitio web"
L["OPEN_WEBSITE"] = "Abrir sitio web"
L["OPEN_WEBSITE_DESC"] = "Copia la URL del sitio web en tu portapapeles"
L["LICENSE"] = "Licencia"
L["VERSION_INFO"] = "Informacion de version"
L["ADDON_STATUS_HEADER"] = "Estado de los addons"
L["SHOW_CHANGELOG"] = "Mostrar registro de cambios"
L["SHOW_CHANGELOG_DESC"] = "Mostrar los cambios de las ultimas actualizaciones"

-- Changelog
L["WHATS_NEW"] = "Novedades de esta actualizacion"
L["GOT_IT"] = "Entendido!"
L["GOT_IT_DESC"] = "Marcar como leido -- el popup del registro de cambios no se mostrara para esta version en el proximo inicio de sesion."
L["RELEASED"] = "Publicado"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "Perfiles"
L["SETTINGS"] = "Ajustes"
L["SETUP_ADDON"] = "Configurar %s"
L["SUCCESS"] = "Exito"
L["YOUR_CLASS"] = "tu clase"
