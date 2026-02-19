local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "ptBR")
if not L then return end

-- Minimap Tooltip
L["LEFT_CLICK"] = "Alternar instalador"
L["RIGHT_CLICK"] = "Alternar configuracoes"
L["MIDDLE_CLICK"] = "Alternar changelog"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "Botao do minimapa |cff00ff88ativado|r."
L["MINIMAP_DISABLED"] = "Botao do minimapa |cffff4444desativado|r."

-- Chat Commands
L["COMBAT_ERROR"] = "Nao e possivel executar o instalador durante combate."
L["AVAILABLE_COMMANDS"] = "Comandos disponiveis:"
L["CMD_INSTALL"] = "Alternar o instalador"
L["CMD_SETTINGS"] = "Alternar painel de configuracoes"
L["CMD_MINIMAP"] = "Alternar botao do minimapa"
L["CMD_VERSION"] = "Mostrar versao do addon"
L["CMD_STATUS"] = "Mostrar perfis instalados"
L["CMD_CHANGELOG"] = "Mostrar changelog"
L["ADDON_STATUS"] = "Status dos Addons:"
L["STATUS_INSTALLED"] = "Instalado"
L["STATUS_ENABLED_NOT_INSTALLED"] = "Ativado, nao instalado"
L["STATUS_NOT_ENABLED"] = "Nao ativado"
L["NO_PROFILES_TO_LOAD"] = "Nenhum perfil para carregar."
L["NO_SUPPORTED_ADDONS"] = "Nenhum addon suportado esta ativado."

-- Profile Queue
L["INSTALLING"] = "Instalando"
L["LOADING"] = "Carregando"
L["ALL_PROFILES_INSTALLED"] = "Todos os %d perfis instalados."
L["ALL_PROFILES_LOADED"] = "Todos os %d perfis carregados."

-- Popups
L["RELOAD_TEXT"] = "Todos os perfis carregados com sucesso.\nClique em Recarregar para aplicar suas configuracoes."
L["RELOAD_BUTTON"] = "Recarregar"
L["NEW_CHAR_TEXT"] = "Perfis foram instalados em outro personagem.\nDeseja carregar todos os perfis neste personagem?"
L["NEW_CHAR_LOAD_ALL"] = "Carregar Todos os Perfis"
L["NEW_CHAR_SKIP"] = "Pular"
L["NEW_CHAR_APPLIED"] = "Os perfis serao aplicados um de cada vez."
L["OVERWRITE_TEXT"] = "Um perfil chamado |cff4A8FD9MagguuUI|r ja existe para |cffC0C8D4%s|r.\n\nDeseja sobrescreve-lo?"
L["OVERWRITE_BUTTON"] = "Sobrescrever"
L["CANCEL"] = "Cancelar"

-- Installer Pages
L["INSTALLATION"] = "Instalacao"
L["WELCOME_TO"] = "Bem-vindo ao"
L["INSTALL_ALL_DESC"] = "Clique em |cff4A8FD9Instalar Tudo|r para configurar todos os perfis de uma vez, ou clique em |cffC0C8D4Continuar|r para instalar individualmente"
L["LOAD_PROFILES_INSTALLER_DESC"] = "Clique em |cff4A8FD9Carregar Perfis|r para aplicar seus perfis, ou clique em |cffC0C8D4Continuar|r para reinstalar individualmente"
L["OPTIMIZED_4K"] = "Otimizado para 4K."
L["OTHER_RESOLUTIONS"] = "Outras resolucoes podem precisar de ajustes manuais."
L["MISSING_ADDONS"] = "Faltando addons? Copie uma string de importacao do |cff4A8FD9WowUp|r:"
L["INSTALL_ALL"] = "Instalar Tudo"
L["LOAD_PROFILES"] = "Carregar Perfis"
L["REQUIRED"] = "Obrigatorio"
L["OPTIONAL"] = "Opcional"
L["INSTALL"] = "Instalar"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "Ative o ElvUI para desbloquear esta etapa"
L["ELVUI_DESC1"] = "Substituicao completa da interface: barras de acao, quadros de unidade e mais"
L["ELVUI_DESC2"] = "Layout pre-configurado com estilo limpo e moderno"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "Ative o BetterCooldownManager para desbloquear esta etapa"
L["BCM_DESC1"] = "Rastreamento aprimorado de cooldowns com layouts de barras flexiveis"
L["BCM_DESC2"] = "Barras pre-configuradas para feiticos, itens e berloques"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "Ative o BigWigs para desbloquear esta etapa"
L["BIGWIGS_DESC1"] = "Mod de chefe leve com alertas, temporizadores e sons"
L["BIGWIGS_DESC2"] = "Posicoes de barras e configuracoes de som pre-configuradas"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "Editor de layout de interface integrado da Blizzard para elementos do HUD"
L["EDITMODE_DESC2"] = "Instala um layout MagguuUI pre-configurado"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "Ative o Details para desbloquear esta etapa"
L["DETAILS_DESC1"] = "Medidor de combate em tempo real para dano, cura e mais"
L["DETAILS_DESC2"] = "Layout de janela pre-configurado com estilo limpo"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "Ative o Plater para desbloquear esta etapa"
L["PLATER_DESC1"] = "Placas de identificacao personalizaveis com barras de vida e conjuracao"
L["PLATER_DESC2"] = "Pre-configurado com cores de ameaca e estilo limpo"
L["REQUIRES_RELOAD"] = "Requer uma recarga da interface apos a instalacao"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "Layouts especificos de classe para"
L["CLASS_LAYOUTS_DESC2"] = "Seleciona automaticamente o layout correspondente a sua especializacao ativa"
L["CLASS_LAYOUTS_DESC3"] = "Os layouts antigos serao substituidos automaticamente"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "Instalacao Concluida"
L["COMPLETED_DESC1"] = "Voce concluiu o processo de instalacao"
L["COMPLETED_DESC2"] = "Clique em |cffC0C8D4Recarregar|r para salvar suas configuracoes"

-- Installer: Step Titles
L["STEP_WELCOME"] = "Bem-vindo"
L["STEP_COMPLETE"] = "Concluido"
L["STEP_LAYOUTS"] = "Layouts de Classe"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "Perfil: Ativo"
L["PROFILE_INSTALLED"] = "Perfil: Instalado"
L["PROFILE_NOT_INSTALLED"] = "Perfil: Nao instalado"

-- WowUp Popup
L["COPY_HINT"] = "Clique no texto abaixo para selecionar tudo, depois pressione |cffC0C8D4Ctrl+C|r para copiar"
L["COPIED"] = "Copiado!"
L["CLOSE"] = "Fechar"
L["NO_WOWUP_STRING"] = "Nenhuma string do WowUp configurada"
L["NO_REQUIRED_STRING"] = "Nenhuma string de addons obrigatorios configurada"
L["NO_OPTIONAL_STRING"] = "Nenhuma string de addons opcionais configurada"

-- URL Popup
L["PRESS_CTRL_C"] = "Pressione |cffC0C8D4Ctrl+C|r para copiar"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "Mostrar Botao do Minimapa"
L["SHOW_MINIMAP_BUTTON_DESC"] = "Ativar ou desativar o botao do minimapa"
L["SHOW_CHANGELOG_ON_UPDATE"] = "Mostrar Changelog ao Atualizar"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "Mostrar o popup de changelog quando uma nova versao for detectada"

-- Settings: Installer
L["INSTALLER_DESC"] = "Instalar ou carregar perfis do MagguuUI para todos os addons suportados."
L["RESOLUTION_NOTICE"] = "Otimizado para 4K (3840x2160)."
L["RESOLUTION_NOTICE_SUB"] = "Outras resolucoes podem precisar de ajustes manuais."
L["OPEN_INSTALLER"] = "Abrir Instalador"
L["OPEN_INSTALLER_DESC"] = "Abre o assistente de instalacao passo a passo do MagguuUI"
L["INSTALL_ALL_PROFILES"] = "Instalar Todos os Perfis"
L["INSTALL_ALL_PROFILES_DESC"] = "Instalar todos os perfis do MagguuUI de uma vez (ElvUI, BCM, EditMode, Details, Plater)"
L["LOAD_PROFILES_BUTTON"] = "Carregar Perfis"
L["LOAD_PROFILES_DESC"] = "Carregar perfis salvos anteriormente neste personagem"
L["PROFILE_STATUS"] = "Status do Perfil"

-- Settings: Profile Status
L["ACTIVE"] = "Ativo"
L["NOT_INSTALLED"] = "Nao instalado"
L["NOT_ENABLED"] = "Nao ativado"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "Importacao de Addons"
L["WOWUP_DESC"] = "MagguuUI usa varios addons. Voce pode instala-los usando o recurso de importacao do |cff4A8FD9WowUp|r."
L["WOWUP_REQUIRED_DESC"] = "Addons essenciais para o MagguuUI"
L["WOWUP_OPTIONAL_DESC"] = "Addons extras para a melhor experiencia"
L["WOWUP_HOW_TO"] = "Como usar"
L["COPY_REQUIRED_ADDONS"] = "Copiar Addons Obrigatorios"
L["COPY_REQUIRED_DESC"] = "Abre um popup com a string de importacao do WowUp para addons obrigatorios"
L["COPY_OPTIONAL_ADDONS"] = "Copiar Addons Opcionais"
L["COPY_OPTIONAL_DESC"] = "Abre um popup com a string de importacao do WowUp para addons opcionais"
L["REQUIRED_ADDONS"] = "Addons Obrigatorios"
L["OPTIONAL_ADDONS"] = "Addons Opcionais"
L["NO_ADDON_DATA"] = "Nenhum dado de addon disponivel."
L["NO_ADDON_DATA_RELOAD"] = "Nenhum dado de addon disponivel. Execute /reload apos atualizar."

-- Settings: Information
L["AUTHOR"] = "Autor"
L["LINKS_SUPPORT"] = "Links e Suporte"
L["WEBSITE"] = "Website"
L["OPEN_WEBSITE"] = "Abrir Website"
L["OPEN_WEBSITE_DESC"] = "Copia a URL do website para a area de transferencia"
L["LICENSE"] = "Licenca"
L["VERSION_INFO"] = "Info da Versao"
L["ADDON_STATUS_HEADER"] = "Status dos Addons"
L["SHOW_CHANGELOG"] = "Mostrar Changelog"
L["SHOW_CHANGELOG_DESC"] = "Mostrar o que mudou nas atualizacoes recentes"

-- Changelog
L["WHATS_NEW"] = "O que ha de novo nesta atualizacao"
L["GOT_IT"] = "Entendi!"
L["GOT_IT_DESC"] = "Marcar como lido -- o popup de changelog nao sera exibido para esta versao no proximo login."
L["RELEASED"] = "Lancado"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "Perfis"
L["SETTINGS"] = "Configuracoes"
L["SETUP_ADDON"] = "Configurar %s"
L["SUCCESS"] = "Sucesso"
L["YOUR_CLASS"] = "sua classe"
