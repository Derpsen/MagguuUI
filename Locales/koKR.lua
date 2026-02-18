local L = LibStub("AceLocale-3.0"):NewLocale("MagguuUI", "koKR")
if not L then return end

-- Minimap Tooltip
L["LEFT_CLICK"] = "설치 마법사 열기/닫기"
L["RIGHT_CLICK"] = "설정 열기/닫기"
L["MIDDLE_CLICK"] = "변경 내역 열기/닫기"

-- Minimap Toggle
L["MINIMAP_ENABLED"] = "미니맵 버튼 |cff00ff88활성화됨|r."
L["MINIMAP_DISABLED"] = "미니맵 버튼 |cffff4444비활성화됨|r."

-- Chat Commands
L["COMBAT_ERROR"] = "전투 중에는 설치 마법사를 실행할 수 없습니다."
L["AVAILABLE_COMMANDS"] = "사용 가능한 명령어:"
L["CMD_INSTALL"] = "설치 마법사 열기/닫기"
L["CMD_SETTINGS"] = "설정 패널 열기/닫기"
L["CMD_MINIMAP"] = "미니맵 버튼 표시/숨기기"
L["CMD_VERSION"] = "애드온 버전 표시"
L["CMD_STATUS"] = "설치된 프로필 표시"
L["CMD_CHANGELOG"] = "변경 내역 표시"
L["ADDON_STATUS"] = "애드온 상태:"
L["STATUS_INSTALLED"] = "설치됨"
L["STATUS_ENABLED_NOT_INSTALLED"] = "활성화됨, 설치되지 않음"
L["STATUS_NOT_ENABLED"] = "활성화되지 않음"
L["NO_PROFILES_TO_LOAD"] = "불러올 프로필이 없습니다."
L["NO_SUPPORTED_ADDONS"] = "지원되는 애드온이 활성화되어 있지 않습니다."

-- Profile Queue
L["INSTALLING"] = "설치 중"
L["LOADING"] = "불러오는 중"
L["ALL_PROFILES_INSTALLED"] = "모든 프로필 %d개가 설치되었습니다."
L["ALL_PROFILES_LOADED"] = "모든 프로필 %d개가 불러와졌습니다."

-- Popups
L["RELOAD_TEXT"] = "모든 프로필을 성공적으로 불러왔습니다.\n설정을 적용하려면 새로고침을 클릭하세요."
L["RELOAD_BUTTON"] = "새로고침"
L["NEW_CHAR_TEXT"] = "다른 캐릭터에 프로필이 설치되어 있습니다.\n이 캐릭터에 모든 프로필을 불러오시겠습니까?"
L["NEW_CHAR_LOAD_ALL"] = "모든 프로필 불러오기"
L["NEW_CHAR_SKIP"] = "건너뛰기"
L["NEW_CHAR_APPLIED"] = "프로필이 하나씩 적용됩니다."
L["OVERWRITE_TEXT"] = "|cffC0C8D4%s|r에 대한 |cff4A8FD9MagguuUI|r 프로필이 이미 존재합니다.\n\n덮어쓰시겠습니까?"
L["OVERWRITE_BUTTON"] = "덮어쓰기"
L["CANCEL"] = "취소"

-- Installer Pages
L["INSTALLATION"] = "설치"
L["WELCOME_TO"] = "환영합니다"
L["INSTALL_ALL_DESC"] = "|cff4A8FD9모두 설치|r를 클릭하여 모든 프로필을 한 번에 설정하거나, |cffC0C8D4계속|r을 클릭하여 개별 설치하세요"
L["LOAD_PROFILES_INSTALLER_DESC"] = "|cff4A8FD9프로필 불러오기|r를 클릭하여 프로필을 적용하거나, |cffC0C8D4계속|r을 클릭하여 개별 재설치하세요"
L["OPTIMIZED_4K"] = "4K에 최적화되어 있습니다."
L["OTHER_RESOLUTIONS"] = "다른 해상도에서는 수동 조정이 필요할 수 있습니다."
L["MISSING_ADDONS"] = "누락된 애드온이 있나요? |cff4A8FD9WowUp|r 가져오기 문자열을 복사하세요:"
L["INSTALL_ALL"] = "모두 설치"
L["LOAD_PROFILES"] = "프로필 불러오기"
L["REQUIRED"] = "필수"
L["OPTIONAL"] = "선택"
L["INSTALL"] = "설치"

-- Installer: ElvUI (Page 2)
L["ELVUI_ENABLE"] = "이 단계를 잠금 해제하려면 ElvUI를 활성화하세요"
L["ELVUI_DESC1"] = "액션바, 유닛 프레임 등을 위한 완전한 UI 교체"
L["ELVUI_DESC2"] = "깔끔하고 현대적인 스타일로 사전 구성된 레이아웃"

-- Installer: BCM (Page 3)
L["BCM_ENABLE"] = "이 단계를 잠금 해제하려면 BetterCooldownManager를 활성화하세요"
L["BCM_DESC1"] = "유연한 바 레이아웃으로 향상된 쿨다운 추적"
L["BCM_DESC2"] = "주문, 아이템, 장신구에 대한 사전 구성된 바"

-- Installer: BigWigs (Page 4)
L["BIGWIGS_ENABLE"] = "이 단계를 잠금 해제하려면 BigWigs를 활성화하세요"
L["BIGWIGS_DESC1"] = "알림, 타이머, 소리를 갖춘 가벼운 보스 모드"
L["BIGWIGS_DESC2"] = "사전 구성된 바 위치 및 소리 설정"

-- Installer: EditMode (Page 5)
L["EDITMODE_DESC1"] = "HUD 요소를 위한 블리자드 내장 UI 레이아웃 편집기"
L["EDITMODE_DESC2"] = "사전 구성된 MagguuUI 레이아웃을 설치합니다"

-- Installer: Details (Page 6)
L["DETAILS_ENABLE"] = "이 단계를 잠금 해제하려면 Details를 활성화하세요"
L["DETAILS_DESC1"] = "데미지, 힐링 등의 실시간 전투 미터"
L["DETAILS_DESC2"] = "깔끔한 스타일로 사전 구성된 창 레이아웃"

-- Installer: Plater (Page 7)
L["PLATER_ENABLE"] = "이 단계를 잠금 해제하려면 Plater를 활성화하세요"
L["PLATER_DESC1"] = "체력 및 시전 바가 있는 사용자 정의 가능한 이름표"
L["PLATER_DESC2"] = "위협 색상 및 깔끔한 스타일로 사전 구성됨"
L["REQUIRES_RELOAD"] = "설치 후 UI 새로고침이 필요합니다"

-- Installer: Character Layouts (Page 8)
L["CLASS_LAYOUTS_FOR"] = "직업별 레이아웃"
L["CLASS_LAYOUTS_DESC2"] = "활성 전문화에 맞는 레이아웃을 자동으로 선택합니다"

-- Installer: Complete (Page 9)
L["INSTALLATION_COMPLETE"] = "설치 완료"
L["COMPLETED_DESC1"] = "설치 과정이 완료되었습니다"
L["COMPLETED_DESC2"] = "|cffC0C8D4새로고침|r을 클릭하여 설정을 저장하세요"

-- Installer: Step Titles
L["STEP_WELCOME"] = "환영"
L["STEP_COMPLETE"] = "완료"
L["STEP_LAYOUTS"] = "레이아웃"

-- Profile Status (Installer + Settings)
L["PROFILE_ACTIVE"] = "프로필: 활성"
L["PROFILE_INSTALLED"] = "프로필: 설치됨"
L["PROFILE_NOT_INSTALLED"] = "프로필: 설치되지 않음"

-- WowUp Popup
L["COPY_HINT"] = "아래 텍스트를 클릭하여 모두 선택한 후, |cffC0C8D4Ctrl+C|r를 눌러 복사하세요"
L["COPIED"] = "복사됨!"
L["CLOSE"] = "닫기"
L["NO_WOWUP_STRING"] = "WowUp 문자열이 설정되지 않았습니다"
L["NO_REQUIRED_STRING"] = "필수 애드온 문자열이 설정되지 않았습니다"
L["NO_OPTIONAL_STRING"] = "선택 애드온 문자열이 설정되지 않았습니다"

-- URL Popup
L["PRESS_CTRL_C"] = "|cffC0C8D4Ctrl+C|r를 눌러 복사하세요"

-- Settings: General
L["SHOW_MINIMAP_BUTTON"] = "미니맵 버튼 표시"
L["SHOW_MINIMAP_BUTTON_DESC"] = "미니맵 버튼을 표시하거나 숨깁니다"
L["SHOW_CHANGELOG_ON_UPDATE"] = "업데이트 시 변경 내역 표시"
L["SHOW_CHANGELOG_ON_UPDATE_DESC"] = "새 버전이 감지되면 변경 내역 팝업을 표시합니다"

-- Settings: Installer
L["INSTALLER_DESC"] = "지원되는 모든 애드온에 대해 MagguuUI 프로필을 설치하거나 불러옵니다."
L["RESOLUTION_NOTICE"] = "4K(3840x2160)에 최적화되어 있습니다."
L["RESOLUTION_NOTICE_SUB"] = "다른 해상도에서는 수동 조정이 필요할 수 있습니다."
L["OPEN_INSTALLER"] = "설치 마법사 열기"
L["OPEN_INSTALLER_DESC"] = "MagguuUI 단계별 설치 마법사를 엽니다"
L["INSTALL_ALL_PROFILES"] = "모든 프로필 설치"
L["INSTALL_ALL_PROFILES_DESC"] = "모든 MagguuUI 프로필을 한 번에 설치합니다 (ElvUI, BCM, EditMode, Details, Plater)"
L["LOAD_PROFILES_BUTTON"] = "프로필 불러오기"
L["LOAD_PROFILES_DESC"] = "이 캐릭터에 이전에 저장된 프로필을 불러옵니다"
L["PROFILE_STATUS"] = "프로필 상태"

-- Settings: Profile Status
L["ACTIVE"] = "활성"
L["NOT_INSTALLED"] = "설치되지 않음"
L["NOT_ENABLED"] = "활성화되지 않음"

-- Settings: WowUp
L["WOWUP_ADDON_IMPORT"] = "애드온 가져오기"
L["WOWUP_DESC"] = "MagguuUI는 여러 애드온을 사용합니다. |cff4A8FD9WowUp|r의 가져오기 기능을 사용하여 설치할 수 있습니다."
L["WOWUP_REQUIRED_DESC"] = "MagguuUI에 필요한 핵심 애드온"
L["WOWUP_OPTIONAL_DESC"] = "최상의 경험을 위한 추가 애드온"
L["WOWUP_HOW_TO"] = "사용 방법"
L["COPY_REQUIRED_ADDONS"] = "필수 애드온 복사"
L["COPY_REQUIRED_DESC"] = "필수 애드온의 WowUp 가져오기 문자열이 포함된 팝업을 엽니다"
L["COPY_OPTIONAL_ADDONS"] = "선택 애드온 복사"
L["COPY_OPTIONAL_DESC"] = "선택 애드온의 WowUp 가져오기 문자열이 포함된 팝업을 엽니다"
L["REQUIRED_ADDONS"] = "필수 애드온"
L["OPTIONAL_ADDONS"] = "선택 애드온"
L["NO_ADDON_DATA"] = "애드온 데이터를 사용할 수 없습니다."
L["NO_ADDON_DATA_RELOAD"] = "애드온 데이터를 사용할 수 없습니다. 업데이트 후 /reload를 실행하세요."

-- Settings: Information
L["AUTHOR"] = "제작자"
L["LINKS_SUPPORT"] = "링크 및 지원"
L["WEBSITE"] = "웹사이트"
L["OPEN_WEBSITE"] = "웹사이트 열기"
L["OPEN_WEBSITE_DESC"] = "웹사이트 URL을 클립보드에 복사합니다"
L["LICENSE"] = "라이선스"
L["VERSION_INFO"] = "버전 정보"
L["ADDON_STATUS_HEADER"] = "애드온 상태"
L["SHOW_CHANGELOG"] = "변경 내역 표시"
L["SHOW_CHANGELOG_DESC"] = "최근 업데이트의 변경 사항을 표시합니다"

-- Changelog
L["WHATS_NEW"] = "이번 업데이트의 새로운 내용"
L["GOT_IT"] = "확인!"
L["GOT_IT_DESC"] = "읽음으로 표시 — 다음 로그인 시 이 버전의 변경 내역 팝업이 표시되지 않습니다."
L["RELEASED"] = "출시일"

-- Standalone Settings (Options.lua)
L["PROFILES"] = "프로필"
L["SETTINGS"] = "설정"
L["SETUP_ADDON"] = "%s 설정"
L["SUCCESS"] = "성공"
L["YOUR_CLASS"] = "내 직업"
