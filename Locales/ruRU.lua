local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "ruRU")
if not L then return end

-- Minimap Tooltip
L["LEFT_CLICK"] = "Переключить установщик"
L["RIGHT_CLICK"] = "Переключить настройки"
L["MIDDLE_CLICK"] = "Переключить список изменений"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "Кнопка миникарты |cff00ff88включена|r."
L["MINIMAP_DISABLED"] = "Кнопка миникарты |cffff4444выключена|r."

-- Chat Commands
L["COMBAT_ERROR"] = "Невозможно запустить установщик во время боя."
L["AVAILABLE_COMMANDS"] = "Доступные команды:"
L["CMD_INSTALL"] = "Переключить установщик"
L["CMD_SETTINGS"] = "Переключить панель настроек"
L["CMD_MINIMAP"] = "Переключить кнопку миникарты"
L["CMD_VERSION"] = "Показать версию аддона"
L["CMD_STATUS"] = "Показать установленные профили"
L["CMD_CHANGELOG"] = "Показать список изменений"
L["ADDON_STATUS"] = "Статус аддонов:"
L["STATUS_INSTALLED"] = "Установлено"
L["STATUS_ENABLED_NOT_INSTALLED"] = "Включено, не установлено"
L["STATUS_NOT_ENABLED"] = "Не включено"
L["NO_PROFILES_TO_LOAD"] = "Нет профилей для загрузки."
L["NO_SUPPORTED_ADDONS"] = "Нет включённых поддерживаемых аддонов."

-- Profile Queue
L["INSTALLING"] = "Установка"
L["LOADING"] = "Загрузка"
L["ALL_PROFILES_INSTALLED"] = "Все %d профилей установлены."
L["ALL_PROFILES_LOADED"] = "Все %d профилей загружены."

-- Popups
L["RELOAD_TEXT"] = "Все профили успешно загружены.\nНажмите Перезагрузить, чтобы применить настройки."
L["RELOAD_BUTTON"] = "Перезагрузить"
L["NEW_CHAR_TEXT"] = "Профили были установлены на другом персонаже.\nХотите загрузить все профили на этого персонажа?"
L["NEW_CHAR_LOAD_ALL"] = "Загрузить все профили"
L["NEW_CHAR_SKIP"] = "Пропустить"
L["NEW_CHAR_APPLIED"] = "Профили будут применены по одному."
L["OVERWRITE_TEXT"] = "Профиль с именем |cff4A8FD9MagguuUI|r уже существует для |cffC0C8D4%s|r.\n\nХотите перезаписать его?"
L["OVERWRITE_BUTTON"] = "Перезаписать"
L["CANCEL"] = "Отмена"

-- Installer Pages
L["INSTALLATION"] = "Установка"
L["WELCOME_TO"] = "Добро пожаловать в"
L["INSTALL_ALL_DESC"] = "Нажмите |cff4A8FD9Установить все|r для настройки всех профилей сразу, или |cffC0C8D4Далее|r для поочерёдной установки"
L["LOAD_PROFILES_INSTALLER_DESC"] = "Нажмите |cff4A8FD9Загрузить профили|r для применения профилей, или |cffC0C8D4Далее|r для переустановки"
L["OPTIMIZED_4K"] = "Оптимизировано для 4K."
L["OTHER_RESOLUTIONS"] = "Другие разрешения могут потребовать ручной настройки."
L["MISSING_ADDONS"] = "Не хватает аддонов? Скопируйте строку импорта |cff4A8FD9WowUp|r:"
L["INSTALL_ALL"] = "Установить все"
L["LOAD_PROFILES"] = "Загрузить профили"
L["REQUIRED"] = "Обязательные"
L["OPTIONAL"] = "Дополнительные"
L["INSTALL"] = "Установить"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "Включите ElvUI, чтобы разблокировать этот шаг"
L["ELVUI_DESC1"] = "Полная замена интерфейса: панели действий, рамки юнитов и многое другое"
L["ELVUI_DESC2"] = "Предварительно настроенный макет с современным дизайном"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "Включите BetterCooldownManager, чтобы разблокировать этот шаг"
L["BCM_DESC1"] = "Улучшенное отслеживание перезарядки с гибкими панелями"
L["BCM_DESC2"] = "Предварительно настроенные панели для заклинаний, предметов и аксессуаров"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "Включите BigWigs, чтобы разблокировать этот шаг"
L["BIGWIGS_DESC1"] = "Лёгкий босс-мод с оповещениями, таймерами и звуками"
L["BIGWIGS_DESC2"] = "Предварительно настроенные позиции панелей и звуковые параметры"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "Встроенный редактор расположения интерфейса Blizzard для элементов HUD"
L["EDITMODE_DESC2"] = "Устанавливает предварительно настроенный макет MagguuUI"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "Включите Details, чтобы разблокировать этот шаг"
L["DETAILS_DESC1"] = "Счётчик боя в реальном времени: урон, исцеление и многое другое"
L["DETAILS_DESC2"] = "Предварительно настроенное расположение окон с современным дизайном"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "Включите Plater, чтобы разблокировать этот шаг"
L["PLATER_DESC1"] = "Настраиваемые таблички с полосами здоровья и произнесения"
L["PLATER_DESC2"] = "Предварительно настроено с цветами угрозы и современным дизайном"
L["REQUIRES_RELOAD"] = "Требуется перезагрузка интерфейса после установки"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "Макеты для класса"
L["CLASS_LAYOUTS_DESC2"] = "Автоматически выбирает макет для активной специализации"
L["CLASS_LAYOUTS_DESC3"] = "Старые макеты будут заменены автоматически"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "Установка завершена"
L["COMPLETED_DESC1"] = "Вы завершили процесс установки"
L["COMPLETED_DESC2"] = "Нажмите |cffC0C8D4Перезагрузить|r, чтобы сохранить настройки"

-- Installer: Step Titles
L["STEP_WELCOME"] = "Приветствие"
L["STEP_COMPLETE"] = "Готово"
L["STEP_LAYOUTS"] = "Макеты классов"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "Профиль: Активен"
L["PROFILE_INSTALLED"] = "Профиль: Установлен"
L["PROFILE_NOT_INSTALLED"] = "Профиль: Не установлен"

-- WowUp Popup
L["COPY_HINT"] = "Нажмите на текст ниже, чтобы выделить всё, затем нажмите |cffC0C8D4Ctrl+C|r для копирования"
L["COPIED"] = "Скопировано!"
L["CLOSE"] = "Закрыть"
L["NO_WOWUP_STRING"] = "Строка WowUp не настроена"
L["NO_REQUIRED_STRING"] = "Строка обязательных аддонов не настроена"
L["NO_OPTIONAL_STRING"] = "Строка дополнительных аддонов не настроена"

-- URL Popup
L["PRESS_CTRL_C"] = "Нажмите |cffC0C8D4Ctrl+C|r для копирования"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "Показать кнопку миникарты"
L["SHOW_MINIMAP_BUTTON_DESC"] = "Включить или выключить кнопку миникарты"
L["SHOW_CHANGELOG_ON_UPDATE"] = "Показывать список изменений при обновлении"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "Показывать всплывающее окно со списком изменений при обнаружении новой версии"

-- Settings: Installer
L["INSTALLER_DESC"] = "Установка или загрузка профилей MagguuUI для всех поддерживаемых аддонов."
L["RESOLUTION_NOTICE"] = "Оптимизировано для 4K (3840x2160)."
L["RESOLUTION_NOTICE_SUB"] = "Другие разрешения могут потребовать ручной настройки."
L["OPEN_INSTALLER"] = "Открыть установщик"
L["OPEN_INSTALLER_DESC"] = "Открывает пошаговый мастер установки MagguuUI"
L["INSTALL_ALL_PROFILES"] = "Установить все профили"
L["INSTALL_ALL_PROFILES_DESC"] = "Установить все профили MagguuUI одновременно (ElvUI, BCM, EditMode, Details, Plater)"
L["LOAD_PROFILES_BUTTON"] = "Загрузить профили"
L["LOAD_PROFILES_DESC"] = "Загрузить ранее сохранённые профили на этого персонажа"
L["PROFILE_STATUS"] = "Статус профилей"

-- Settings: Profile Status
L["ACTIVE"] = "Активен"
L["NOT_INSTALLED"] = "Не установлено"
L["NOT_ENABLED"] = "Не включено"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "Импорт аддонов"
L["WOWUP_DESC"] = "MagguuUI использует несколько аддонов. Вы можете установить их с помощью функции импорта |cff4A8FD9WowUp|r."
L["WOWUP_REQUIRED_DESC"] = "Основные аддоны для MagguuUI"
L["WOWUP_OPTIONAL_DESC"] = "Дополнительные аддоны для лучшего опыта"
L["WOWUP_HOW_TO"] = "Как использовать"
L["COPY_REQUIRED_ADDONS"] = "Копировать обязательные аддоны"
L["COPY_REQUIRED_DESC"] = "Открывает окно со строкой импорта WowUp для обязательных аддонов"
L["COPY_OPTIONAL_ADDONS"] = "Копировать дополнительные аддоны"
L["COPY_OPTIONAL_DESC"] = "Открывает окно со строкой импорта WowUp для дополнительных аддонов"
L["REQUIRED_ADDONS"] = "Обязательные аддоны"
L["OPTIONAL_ADDONS"] = "Дополнительные аддоны"
L["NO_ADDON_DATA"] = "Данные аддонов недоступны."
L["NO_ADDON_DATA_RELOAD"] = "Данные аддонов недоступны. Выполните /reload после обновления."

-- Settings: Information
L["AUTHOR"] = "Автор"
L["LINKS_SUPPORT"] = "Ссылки и поддержка"
L["WEBSITE"] = "Веб-сайт"
L["OPEN_WEBSITE"] = "Открыть веб-сайт"
L["OPEN_WEBSITE_DESC"] = "Копирует URL веб-сайта в буфер обмена"
L["LICENSE"] = "Лицензия"
L["VERSION_INFO"] = "Информация о версии"
L["ADDON_STATUS_HEADER"] = "Статус аддонов"
L["SHOW_CHANGELOG"] = "Показать список изменений"
L["SHOW_CHANGELOG_DESC"] = "Показать, что изменилось в последних обновлениях"

-- Changelog
L["WHATS_NEW"] = "Что нового в этом обновлении"
L["GOT_IT"] = "Понятно!"
L["GOT_IT_DESC"] = "Отметить как прочитанное — всплывающее окно со списком изменений не будет показано для этой версии при следующем входе."
L["RELEASED"] = "Выпущено"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "Профили"
L["SETTINGS"] = "Настройки"
L["SETUP_ADDON"] = "Настроить %s"
L["SUCCESS"] = "Успешно"
L["YOUR_CLASS"] = "ваш класс"
