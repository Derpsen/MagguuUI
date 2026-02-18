local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "zhCN")
if not L then return end

-- Minimap Tooltip
L["LEFT_CLICK"] = "打开/关闭安装向导"
L["RIGHT_CLICK"] = "打开/关闭设置"
L["MIDDLE_CLICK"] = "打开/关闭更新日志"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "小地图按钮已|cff00ff88启用|r。"
L["MINIMAP_DISABLED"] = "小地图按钮已|cffff4444禁用|r。"

-- Chat Commands
L["COMBAT_ERROR"] = "战斗中无法运行安装向导。"
L["AVAILABLE_COMMANDS"] = "可用命令："
L["CMD_INSTALL"] = "打开/关闭安装向导"
L["CMD_SETTINGS"] = "打开/关闭设置面板"
L["CMD_MINIMAP"] = "显示/隐藏小地图按钮"
L["CMD_VERSION"] = "显示插件版本"
L["CMD_STATUS"] = "显示已安装的配置文件"
L["CMD_CHANGELOG"] = "显示更新日志"
L["ADDON_STATUS"] = "插件状态："
L["STATUS_INSTALLED"] = "已安装"
L["STATUS_ENABLED_NOT_INSTALLED"] = "已启用，未安装"
L["STATUS_NOT_ENABLED"] = "未启用"
L["NO_PROFILES_TO_LOAD"] = "没有可加载的配置文件。"
L["NO_SUPPORTED_ADDONS"] = "没有已启用的受支持插件。"

-- Profile Queue
L["INSTALLING"] = "正在安装"
L["LOADING"] = "正在加载"
L["ALL_PROFILES_INSTALLED"] = "全部 %d 个配置文件已安装。"
L["ALL_PROFILES_LOADED"] = "全部 %d 个配置文件已加载。"

-- Popups
L["RELOAD_TEXT"] = "所有配置文件已成功加载。\n点击重新加载以应用您的设置。"
L["RELOAD_BUTTON"] = "重新加载"
L["NEW_CHAR_TEXT"] = "配置文件已在其他角色上安装。\n您是否要将所有配置文件加载到此角色？"
L["NEW_CHAR_LOAD_ALL"] = "加载所有配置文件"
L["NEW_CHAR_SKIP"] = "跳过"
L["NEW_CHAR_APPLIED"] = "配置文件将逐个应用。"
L["OVERWRITE_TEXT"] = "|cffC0C8D4%s|r 的 |cff4A8FD9MagguuUI|r 配置文件已存在。\n\n是否要覆盖？"
L["OVERWRITE_BUTTON"] = "覆盖"
L["CANCEL"] = "取消"

-- Installer Pages
L["INSTALLATION"] = "安装"
L["WELCOME_TO"] = "欢迎使用"
L["INSTALL_ALL_DESC"] = "点击 |cff4A8FD9全部安装|r 一次性设置所有配置文件，或点击 |cffC0C8D4继续|r 逐个安装"
L["LOAD_PROFILES_INSTALLER_DESC"] = "点击 |cff4A8FD9加载配置文件|r 应用您的配置文件，或点击 |cffC0C8D4继续|r 逐个重新安装"
L["OPTIMIZED_4K"] = "针对4K优化。"
L["OTHER_RESOLUTIONS"] = "其他分辨率可能需要手动调整。"
L["MISSING_ADDONS"] = "缺少插件？复制 |cff4A8FD9WowUp|r 导入字符串："
L["INSTALL_ALL"] = "全部安装"
L["LOAD_PROFILES"] = "加载配置文件"
L["REQUIRED"] = "必需"
L["OPTIONAL"] = "可选"
L["INSTALL"] = "安装"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "启用 ElvUI 以解锁此步骤"
L["ELVUI_DESC1"] = "动作条、单位框架等的完整UI替换"
L["ELVUI_DESC2"] = "预配置的简洁现代风格布局"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "启用 BetterCooldownManager 以解锁此步骤"
L["BCM_DESC1"] = "灵活条形布局的增强冷却追踪"
L["BCM_DESC2"] = "预配置的法术、物品和饰品追踪条"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "启用 BigWigs 以解锁此步骤"
L["BIGWIGS_DESC1"] = "带有警报、计时器和声音的轻量级首领模块"
L["BIGWIGS_DESC2"] = "预配置的计时条位置和声音设置"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "暴雪内置的HUD元素UI布局编辑器"
L["EDITMODE_DESC2"] = "安装预配置的 MagguuUI 布局"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "启用 Details 以解锁此步骤"
L["DETAILS_DESC1"] = "伤害、治疗等的实时战斗统计"
L["DETAILS_DESC2"] = "预配置的简洁风格窗口布局"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "启用 Plater 以解锁此步骤"
L["PLATER_DESC1"] = "带有生命值和施法条的可自定义姓名板"
L["PLATER_DESC2"] = "预配置的仇恨着色和简洁风格"
L["REQUIRES_RELOAD"] = "安装后需要重新加载UI"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "职业专属布局"
L["CLASS_LAYOUTS_DESC2"] = "自动选择匹配当前专精的布局"
L["CLASS_LAYOUTS_DESC3"] = "重新安装？请先在编辑模式中手动删除旧布局"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "安装完成"
L["COMPLETED_DESC1"] = "您已完成安装过程"
L["COMPLETED_DESC2"] = "点击 |cffC0C8D4重新加载|r 以保存您的设置"

-- Installer: Step Titles
L["STEP_WELCOME"] = "欢迎"
L["STEP_COMPLETE"] = "完成"
L["STEP_LAYOUTS"] = "布局"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "配置文件：活跃"
L["PROFILE_INSTALLED"] = "配置文件：已安装"
L["PROFILE_NOT_INSTALLED"] = "配置文件：未安装"

-- WowUp Popup
L["COPY_HINT"] = "点击下方文本全选，然后按 |cffC0C8D4Ctrl+C|r 复制"
L["COPIED"] = "已复制！"
L["CLOSE"] = "关闭"
L["NO_WOWUP_STRING"] = "未配置 WowUp 字符串"
L["NO_REQUIRED_STRING"] = "未配置必需插件字符串"
L["NO_OPTIONAL_STRING"] = "未配置可选插件字符串"

-- URL Popup
L["PRESS_CTRL_C"] = "按 |cffC0C8D4Ctrl+C|r 复制"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "显示小地图按钮"
L["SHOW_MINIMAP_BUTTON_DESC"] = "显示或隐藏小地图按钮"
L["SHOW_CHANGELOG_ON_UPDATE"] = "更新时显示更新日志"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "检测到新版本时显示更新日志弹窗"

-- Settings: Installer
L["INSTALLER_DESC"] = "为所有受支持的插件安装或加载 MagguuUI 配置文件。"
L["RESOLUTION_NOTICE"] = "针对4K（3840x2160）优化。"
L["RESOLUTION_NOTICE_SUB"] = "其他分辨率可能需要手动调整。"
L["OPEN_INSTALLER"] = "打开安装向导"
L["OPEN_INSTALLER_DESC"] = "打开 MagguuUI 分步安装向导"
L["INSTALL_ALL_PROFILES"] = "安装所有配置文件"
L["INSTALL_ALL_PROFILES_DESC"] = "一次性安装所有 MagguuUI 配置文件（ElvUI、BCM、EditMode、Details、Plater）"
L["LOAD_PROFILES_BUTTON"] = "加载配置文件"
L["LOAD_PROFILES_DESC"] = "在此角色上加载之前保存的配置文件"
L["PROFILE_STATUS"] = "配置文件状态"

-- Settings: Profile Status
L["ACTIVE"] = "活跃"
L["NOT_INSTALLED"] = "未安装"
L["NOT_ENABLED"] = "未启用"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "插件导入"
L["WOWUP_DESC"] = "MagguuUI 使用多个插件。您可以使用 |cff4A8FD9WowUp|r 的导入功能进行安装。"
L["WOWUP_REQUIRED_DESC"] = "MagguuUI 所需的核心插件"
L["WOWUP_OPTIONAL_DESC"] = "获得最佳体验的额外插件"
L["WOWUP_HOW_TO"] = "使用方法"
L["COPY_REQUIRED_ADDONS"] = "复制必需插件"
L["COPY_REQUIRED_DESC"] = "打开包含必需插件 WowUp 导入字符串的弹窗"
L["COPY_OPTIONAL_ADDONS"] = "复制可选插件"
L["COPY_OPTIONAL_DESC"] = "打开包含可选插件 WowUp 导入字符串的弹窗"
L["REQUIRED_ADDONS"] = "必需插件"
L["OPTIONAL_ADDONS"] = "可选插件"
L["NO_ADDON_DATA"] = "没有可用的插件数据。"
L["NO_ADDON_DATA_RELOAD"] = "没有可用的插件数据。更新后请运行 /reload。"

-- Settings: Information
L["AUTHOR"] = "作者"
L["LINKS_SUPPORT"] = "链接和支持"
L["WEBSITE"] = "网站"
L["OPEN_WEBSITE"] = "打开网站"
L["OPEN_WEBSITE_DESC"] = "将网站URL复制到剪贴板"
L["LICENSE"] = "许可证"
L["VERSION_INFO"] = "版本信息"
L["ADDON_STATUS_HEADER"] = "插件状态"
L["SHOW_CHANGELOG"] = "显示更新日志"
L["SHOW_CHANGELOG_DESC"] = "显示最近更新的变更内容"

-- Changelog
L["WHATS_NEW"] = "此次更新的新内容"
L["GOT_IT"] = "知道了！"
L["GOT_IT_DESC"] = "标记为已读——下次登录时此版本的更新日志弹窗将不再显示。"
L["RELEASED"] = "发布日期"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "配置文件"
L["SETTINGS"] = "设置"
L["SETUP_ADDON"] = "设置 %s"
L["SUCCESS"] = "成功"
L["YOUR_CLASS"] = "你的职业"
