;!include MUI.nsh
!include MUI2.nsh
 
!define srcdir "src"

!define SrcSysPath "${srcdir}\system"
!define SrcPyPath "${srcdir}\Python2.6.2c1"
!define SrcScCorePath "${srcdir}\sc-core"
!define Src7ZipPath "${srcdir}\7zip"
!define SrcSvnPath "${srcdir}\svn"
!define SrcSuitPath "${srcdir}\suit"

!define company "OSTIS"
!define prodname "Intelegent Question Answering System"
!define shortprodname "IQAS"
!define version "0.0"

!define licensefile "license.txt"
!define helpfile "README.html"

!define logofile "logo.bmp"

!define regroot HKCU
!define regkey "Software\${company}\${shortprodname}" 

!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${regroot}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY ${regkey}
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
 
;--------------------------------
;General

  ;Name and file
  Name "${prodname}"
  OutFile "${company}_${shortprodname}_${version}_setup.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\${company}\${prodname}"
  
  ;Get installation folder from registry if available
  InstallDirRegKey ${regroot} ${regkey} ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Variables

  Var StartMenuFolder

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP "${srcdir}\${logofile}"
	
;--------------------------------
;Pages
 
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "${srcdir}\${licensefile}"
	!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_INSTFILES
	
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH
	
  !insertmacro MUI_PAGE_FINISH
 
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

;Main System Section
Section "IQA System (required)" SecSystem

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
	File "${srcdir}\${helpfile}"
	
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
		;Create shortcuts
		CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Help.lnk" "$INSTDIR\${helpfile}"
  !insertmacro MUI_STARTMENU_WRITE_END
  
  ;Store installation folder
  WriteRegStr ${regroot} ${regkey} "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;Python Section
Section "Python 2.6.2c1" SecPy

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...

SectionEnd

;SC-Core Section
Section "sc-core" SecSc

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...

SectionEnd

;SSRLab Section
Section "SSRLab" SecSSRLab

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...

SectionEnd

;7zip Section
Section "7zip" Sec7Zip

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...

SectionEnd

;SVN Section
Section "SVN utils" SecSVN

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecSystem ${LANG_ENGLISH} "Intelegent Question Answering System."
	LangString DESC_SecSystem ${LANG_RUSSIAN} "Интеллектуальная вопросно-ответная система."
	
  LangString DESC_SecPy ${LANG_ENGLISH} "Python 2.6.2c1 with all required libraries."
	LangString DESC_SecPy ${LANG_RUSSIAN} "Python 2.6.2c1 со всеми необходимыми библиотеками."
	
  LangString DESC_SecSc ${LANG_ENGLISH} "SC-Core - graphs dynamic memory."
	LangString DESC_SecSc ${LANG_RUSSIAN} "SC-Core - реализация графодинамической памяти."

  LangString DESC_SecSSRLab ${LANG_ENGLISH} "SAPI developed by SSR Laboratory UUIP NASB."
	LangString DESC_SecSSRLab ${LANG_RUSSIAN} "Синтезатор голоса лаборатории Синтеза и Распознования Речи Объединенного института проблем информатики Национальной академии наук Беларуси."
	
  LangString DESC_Sec7Zip ${LANG_ENGLISH} "7Zip - pack and unpack utillity for creating and restoring from backup."
	LangString DESC_Sec7Zip ${LANG_RUSSIAN} "7Zip - утилита архивации и распаковки. Для возможности создания и востановления резервной копии системы."
	
  LangString DESC_SecSVN ${LANG_ENGLISH} "SVN - utills for updating system by Internet."
	LangString DESC_SecSVN ${LANG_RUSSIAN} "SVN - утилита для работы с удаленным репозиторием исходных кодов. Для возможности обновления системы через Internet."


  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecSystem} $(DESC_SecSystem)
		!insertmacro MUI_DESCRIPTION_TEXT ${SecPy} $(DESC_SecPy)
		!insertmacro MUI_DESCRIPTION_TEXT ${SecSc} $(DESC_SecSc)
		!insertmacro MUI_DESCRIPTION_TEXT ${SecSSRLab} $(DESC_SecSSRLab)
		!insertmacro MUI_DESCRIPTION_TEXT ${Sec7Zip} $(DESC_Sec7Zip)
		!insertmacro MUI_DESCRIPTION_TEXT ${SecSVN} $(DESC_SecSVN)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe"
	Delete "$INSTDIR\${helpfile}"

  RMDir "$INSTDIR"
	
	!insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
		Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
		Delete "$SMPROGRAMS\$StartMenuFolder\Help.lnk"
		RMDir "$SMPROGRAMS\$StartMenuFolder"

  DeleteRegKey ${regroot} ${regkey}

SectionEnd