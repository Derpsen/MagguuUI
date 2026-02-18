local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "zhTW")
if not L then return end

-- Minimap Tooltip
L["LEFT_CLICK"] = "開啟/關閉安裝精靈"
L["RIGHT_CLICK"] = "開啟/關閉設定"
L["MIDDLE_CLICK"] = "開啟/關閉更新日誌"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "小地圖按鈕已|cff00ff88啟用|r。"
L["MINIMAP_DISABLED"] = "小地圖按鈕已|cffff4444停用|r。"

-- Chat Commands
L["COMBAT_ERROR"] = "戰鬥中無法執行安裝精靈。"
L["AVAILABLE_COMMANDS"] = "可用指令："
L["CMD_INSTALL"] = "開啟/關閉安裝精靈"
L["CMD_SETTINGS"] = "開啟/關閉設定面板"
L["CMD_MINIMAP"] = "顯示/隱藏小地圖按鈕"
L["CMD_VERSION"] = "顯示插件版本"
L["CMD_STATUS"] = "顯示已安裝的設定檔"
L["CMD_CHANGELOG"] = "顯示更新日誌"
L["ADDON_STATUS"] = "插件狀態："
L["STATUS_INSTALLED"] = "已安裝"
L["STATUS_ENABLED_NOT_INSTALLED"] = "已啟用，未安裝"
L["STATUS_NOT_ENABLED"] = "未啟用"
L["NO_PROFILES_TO_LOAD"] = "沒有可載入的設定檔。"
L["NO_SUPPORTED_ADDONS"] = "沒有已啟用的支援插件。"

-- Profile Queue
L["INSTALLING"] = "正在安裝"
L["LOADING"] = "正在載入"
L["ALL_PROFILES_INSTALLED"] = "全部 %d 個設定檔已安裝。"
L["ALL_PROFILES_LOADED"] = "全部 %d 個設定檔已載入。"

-- Popups
L["RELOAD_TEXT"] = "所有設定檔已成功載入。\n點擊重新載入以套用您的設定。"
L["RELOAD_BUTTON"] = "重新載入"
L["NEW_CHAR_TEXT"] = "設定檔已在其他角色上安裝。\n您是否要將所有設定檔載入到此角色？"
L["NEW_CHAR_LOAD_ALL"] = "載入所有設定檔"
L["NEW_CHAR_SKIP"] = "略過"
L["NEW_CHAR_APPLIED"] = "設定檔將逐一套用。"
L["OVERWRITE_TEXT"] = "|cffC0C8D4%s|r 的 |cff4A8FD9MagguuUI|r 設定檔已存在。\n\n是否要覆蓋？"
L["OVERWRITE_BUTTON"] = "覆蓋"
L["CANCEL"] = "取消"

-- Installer Pages
L["INSTALLATION"] = "安裝"
L["WELCOME_TO"] = "歡迎使用"
L["INSTALL_ALL_DESC"] = "點擊 |cff4A8FD9全部安裝|r 一次設定所有設定檔，或點擊 |cffC0C8D4繼續|r 逐個安裝"
L["LOAD_PROFILES_INSTALLER_DESC"] = "點擊 |cff4A8FD9載入設定檔|r 套用您的設定檔，或點擊 |cffC0C8D4繼續|r 逐個重新安裝"
L["OPTIMIZED_4K"] = "針對4K最佳化。"
L["OTHER_RESOLUTIONS"] = "其他解析度可能需要手動調整。"
L["MISSING_ADDONS"] = "缺少插件？複製 |cff4A8FD9WowUp|r 匯入字串："
L["INSTALL_ALL"] = "全部安裝"
L["LOAD_PROFILES"] = "載入設定檔"
L["REQUIRED"] = "必要"
L["OPTIONAL"] = "選用"
L["INSTALL"] = "安裝"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "啟用 ElvUI 以解鎖此步驟"
L["ELVUI_DESC1"] = "動作列、單位框架等的完整UI替換"
L["ELVUI_DESC2"] = "預設的簡潔現代風格佈局"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "啟用 BetterCooldownManager 以解鎖此步驟"
L["BCM_DESC1"] = "靈活條形佈局的增強冷卻追蹤"
L["BCM_DESC2"] = "預設的法術、物品和飾品追蹤條"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "啟用 BigWigs 以解鎖此步驟"
L["BIGWIGS_DESC1"] = "具有警報、計時器和音效的輕量級首領模組"
L["BIGWIGS_DESC2"] = "預設的計時條位置和音效設定"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "暴雪內建的HUD元素UI佈局編輯器"
L["EDITMODE_DESC2"] = "安裝預設的 MagguuUI 佈局"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "啟用 Details 以解鎖此步驟"
L["DETAILS_DESC1"] = "傷害、治療等的即時戰鬥統計"
L["DETAILS_DESC2"] = "預設的簡潔風格視窗佈局"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "啟用 Plater 以解鎖此步驟"
L["PLATER_DESC1"] = "具有生命值和施法條的可自訂名牌"
L["PLATER_DESC2"] = "預設的仇恨著色和簡潔風格"
L["REQUIRES_RELOAD"] = "安裝後需要重新載入UI"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "職業專屬佈局"
L["CLASS_LAYOUTS_DESC2"] = "自動選擇符合目前專精的佈局"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "安裝完成"
L["COMPLETED_DESC1"] = "您已完成安裝過程"
L["COMPLETED_DESC2"] = "點擊 |cffC0C8D4重新載入|r 以儲存您的設定"

-- Installer: Step Titles
L["STEP_WELCOME"] = "歡迎"
L["STEP_COMPLETE"] = "完成"
L["STEP_LAYOUTS"] = "佈局"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "設定檔：使用中"
L["PROFILE_INSTALLED"] = "設定檔：已安裝"
L["PROFILE_NOT_INSTALLED"] = "設定檔：未安裝"

-- WowUp Popup
L["COPY_HINT"] = "點擊下方文字全選，然後按 |cffC0C8D4Ctrl+C|r 複製"
L["COPIED"] = "已複製！"
L["CLOSE"] = "關閉"
L["NO_WOWUP_STRING"] = "未設定 WowUp 字串"
L["NO_REQUIRED_STRING"] = "未設定必要插件字串"
L["NO_OPTIONAL_STRING"] = "未設定選用插件字串"

-- URL Popup
L["PRESS_CTRL_C"] = "按 |cffC0C8D4Ctrl+C|r 複製"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "顯示小地圖按鈕"
L["SHOW_MINIMAP_BUTTON_DESC"] = "顯示或隱藏小地圖按鈕"
L["SHOW_CHANGELOG_ON_UPDATE"] = "更新時顯示更新日誌"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "偵測到新版本時顯示更新日誌彈窗"

-- Settings: Installer
L["INSTALLER_DESC"] = "為所有支援的插件安裝或載入 MagguuUI 設定檔。"
L["RESOLUTION_NOTICE"] = "針對4K（3840x2160）最佳化。"
L["RESOLUTION_NOTICE_SUB"] = "其他解析度可能需要手動調整。"
L["OPEN_INSTALLER"] = "開啟安裝精靈"
L["OPEN_INSTALLER_DESC"] = "開啟 MagguuUI 分步安裝精靈"
L["INSTALL_ALL_PROFILES"] = "安裝所有設定檔"
L["INSTALL_ALL_PROFILES_DESC"] = "一次安裝所有 MagguuUI 設定檔（ElvUI、BCM、EditMode、Details、Plater）"
L["LOAD_PROFILES_BUTTON"] = "載入設定檔"
L["LOAD_PROFILES_DESC"] = "在此角色上載入之前儲存的設定檔"
L["PROFILE_STATUS"] = "設定檔狀態"

-- Settings: Profile Status
L["ACTIVE"] = "使用中"
L["NOT_INSTALLED"] = "未安裝"
L["NOT_ENABLED"] = "未啟用"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "插件匯入"
L["WOWUP_DESC"] = "MagguuUI 使用多個插件。您可以使用 |cff4A8FD9WowUp|r 的匯入功能進行安裝。"
L["WOWUP_REQUIRED_DESC"] = "MagguuUI 所需的核心插件"
L["WOWUP_OPTIONAL_DESC"] = "獲得最佳體驗的額外插件"
L["WOWUP_HOW_TO"] = "使用方法"
L["COPY_REQUIRED_ADDONS"] = "複製必要插件"
L["COPY_REQUIRED_DESC"] = "開啟包含必要插件 WowUp 匯入字串的彈窗"
L["COPY_OPTIONAL_ADDONS"] = "複製選用插件"
L["COPY_OPTIONAL_DESC"] = "開啟包含選用插件 WowUp 匯入字串的彈窗"
L["REQUIRED_ADDONS"] = "必要插件"
L["OPTIONAL_ADDONS"] = "選用插件"
L["NO_ADDON_DATA"] = "沒有可用的插件資料。"
L["NO_ADDON_DATA_RELOAD"] = "沒有可用的插件資料。更新後請執行 /reload。"

-- Settings: Information
L["AUTHOR"] = "作者"
L["LINKS_SUPPORT"] = "連結與支援"
L["WEBSITE"] = "網站"
L["OPEN_WEBSITE"] = "開啟網站"
L["OPEN_WEBSITE_DESC"] = "將網站網址複製到剪貼簿"
L["LICENSE"] = "授權條款"
L["VERSION_INFO"] = "版本資訊"
L["ADDON_STATUS_HEADER"] = "插件狀態"
L["SHOW_CHANGELOG"] = "顯示更新日誌"
L["SHOW_CHANGELOG_DESC"] = "顯示最近更新的變更內容"

-- Changelog
L["WHATS_NEW"] = "此次更新的新內容"
L["GOT_IT"] = "了解！"
L["GOT_IT_DESC"] = "標記為已讀——下次登入時此版本的更新日誌彈窗將不再顯示。"
L["RELEASED"] = "發布日期"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "設定檔"
L["SETTINGS"] = "設定"
L["SETUP_ADDON"] = "設定 %s"
L["SUCCESS"] = "成功"
L["YOUR_CLASS"] = "你的職業"
