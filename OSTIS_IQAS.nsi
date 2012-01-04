;!include MUI.nsh
!include MUI2.nsh
 
!define srcdir "src"

!define SrcSysPath "system"
!define SrcPyPath "Python2.6.2c1"
!define SrcScCorePath "sc-core"
!define Src7ZipPath "7zip"
!define SrcSvnPath "svn"
!define SrcSuitPath "suit"
!define SrcSSRLabPath "SSRLab"

!define SrcSysScript "start.bat"
!define SrcPackScript "pack.bat"
!define SrcUnpackScript "unpack.bat"
!define SrcUpdateScript "update_and_install.bat"

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
	
	File "${srcdir}\${helpfile}"
	File "${srcdir}\${licensefile}"
	File "${srcdir}\${SrcSysScript}"
	
	SetOutPath "$INSTDIR\${SrcSysPath}"
	
	File /r "${srcdir}\${SrcSysPath}\*.*"
	
	;Create shortcuts in menu
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
		;Create shortcuts
		CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Help.lnk" "$INSTDIR\${helpfile}"
  !insertmacro MUI_STARTMENU_WRITE_END
  
  ;Store installation folder
  WriteRegStr ${regroot} ${regkey} "INSTDIR" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;Python Section
Section "Python 2.6.2c1" SecPy

	SetOutPath "$INSTDIR\${SrcPyPath}"
	
	File /r "${srcdir}\${SrcPyPath}\*.*"

SectionEnd

;SC-Core Section
Section "sc-core" SecSc

	SetOutPath "$INSTDIR\${SrcScCorePath}"
	
	File /r "${srcdir}\${SrcScCorePath}\*.*"

SectionEnd

;SSRLab Section
Section "SSRLab" SecSSRLab

	SetOutPath "$INSTDIR\${SrcSSRLabPath}"
	
	File /r "${srcdir}\${SrcSSRLabPath}\*.*"
	
	ExecWait 'regsvr32.exe /s "$INSTDIR\TTS\Langs\Russian\LingModRUS.dll"'
	ExecWait 'regsvr32.exe /s "$INSTDIR\TTS\ASP.dll"'
	
	WriteRegStr ${regroot} "Software\SSRLab\Products" "SSRLabTTSrus" "$INSTDIR\${SrcSSRLabPath}\\TTS\\Langs\\Russian"
	WriteRegStr ${regroot} "Software\SSRLab\Products" "SSRLabTTScore" "$INSTDIR\${SrcSSRLabPath}\\TTS\\"
	WriteRegStr ${regroot} "Software\SSRLab\Products" "SSRLabVoiceBoris" "$INSTDIR\${SrcSSRLabPath}\\TTS\\Voices\\Boris\\"
	
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Languages" "0x419" "Russian"
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Languages" "0x423" "Belarusian"
	
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Languages\Belarusian" "langcode" "00000423"
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Languages\Belarusian" "clsid" "{BDAF71A5-F319-4187-B601-E3F6178CFDCE}"
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Languages\Belarusian" "langpath" "$INSTDIR\${SrcSSRLabPath}\\TTS\\Langs\\Belarusian"
	
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Languages\Russian" "langcode" "00000419"
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Languages\Russian" "clsid" "{BDAF71A5-F319-4187-B601-E3F6178CFDCE}"
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Languages\Russian" "langpath" "$INSTDIR\${SrcSSRLabPath}\\TTS\\Langs\\Russian"
	
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Voices" "0x419" "Boris"
	
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Voices\Boris" "name" "Борис Лобанов (RUS)"
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Voices\Boris" "basepath" "$INSTDIR\${SrcSSRLabPath}\\TTS\\Voices\\Boris\\"
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Voices\Boris" "gender" "00000001"
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Voices\Boris" "langcode" "00000419"
	
	WriteRegStr ${regroot} "Software\SSRLab\TTS\Voices\Boris\Settings" "style" "BORIS_Paint"
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Voices\Boris\Settings" "isenergy" "00000001"
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Voices\Boris\Settings" "volume" "00000064"
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Voices\Boris\Settings" "tempo" "00000064"
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Voices\Boris\Settings" "minF0" "0000004b"
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Voices\Boris\Settings" "istone" "00000001"
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Voices\Boris\Settings" "maxF0" "000000a0"
	WriteRegDWORD ${regroot} "Software\SSRLab\TTS\Voices\Boris\Settings" "isrhythm" "00000001"

SectionEnd

;7zip Section
Section "7zip" Sec7Zip

  SetOutPath "$INSTDIR"
	
	File "${srcdir}\${SrcPackScript}"
	File "${srcdir}\${SrcUnpackScript}"

	SetOutPath "$INSTDIR\${Src7ZipPath}"
	
	File /r "${srcdir}\${Src7ZipPath}\*.*"

SectionEnd

;SVN Section
Section "SVN utils" SecSVN

  SetOutPath "$INSTDIR"
	
	File "${srcdir}\${SrcUpdateScript}"

	SetOutPath "$INSTDIR\${SrcSuitPath}"
	
	File /r "${srcdir}\${SrcSuitPath}\*.*"

	SetOutPath "$INSTDIR\${SrcSvnPath}"
	
	File /r "${srcdir}\${SrcSvnPath}\*.*"

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

  Delete "$INSTDIR\*.*"

  RMDir /r "$INSTDIR"
	
	!insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
		Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
		Delete "$SMPROGRAMS\$StartMenuFolder\Help.lnk"
		RMDir "$SMPROGRAMS\$StartMenuFolder"

  DeleteRegKey ${regroot} ${regkey}

SectionEnd