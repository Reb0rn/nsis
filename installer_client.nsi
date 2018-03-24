;NSIS Modern User Interface


;--------------------------------
;Include Modern UI

!include "MUI2.nsh"
!include "x64.nsh"
!include "Sections.nsh"
;--------------------------------
;General

  ;Name and file
  Name "service"
  OutFile "installer.exe"

VIProductVersion "1.0.0.0"
VIAddVersionKey "LegalCopyright" "Pavel, 2018"


  ;Default installation folder
InstallDir $R0


  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  
  
   ; HKLM (all users) vs HKCU (current user) defines
   !define env_hklm 'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'
   !define env_hkcu 'HKCU "Environment"'

;--------------------------------
;Pages
 !define MUI_WELCOMEPAGE_TEXT "service"
 !define MUI_WELCOMEPAGE_TITLE "service"
 !define MUI_WELCOMEFINISHPAGE_BITMAP "arrow.bmp"
 !define MUI_COMPONENTSPAGE_CHECKBITMAP "modern.bmp"

 ;!define MUI_COMPONENTSPAGE_SMALLDESC
 ;!define MUI_BGCOLOR "ff7f24"
 !define MUI_ICON "icon.ico"
  
  
 ; !insertmacro MUI_PAGE_LICENSE "text.txt"
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_INSTFILES
  
;Languages

  !insertmacro MUI_LANGUAGE "Russian"

;--------------------------------
;Exec "$PLUGINSDIR\killcrypto.bat"
;Installer Sections


Section /o "service C:" Section1

 
SetOutPath $PLUGINSDIR

File /r crypto.bat
nsExec::Exec '"$SYSDIR\cmd.exe" /c if 1==1 "$PLUGINSDIR\crypto.bat"'
Pop $0


 RMDir /r "$R0\serviceB"
Delete "$SMSTARTUP\service.exe.lnk"
Delete "$SMSTARTUP\ssf_server.lnk"

 ;êîïèðóåì ôàéëû
	 SetOutPath $R0\
	 
	   File /r service
;ñîçäàåì ÿðëûêè	   

   createShortCut "$SMSTARTUP\CryptoService_41.lnk" "$R0\service\service.exe" ""
  createShortCut "$SMSTARTUP\ssf_server2.lnk" "$R0\service\CbWEBCrypt\ssf_server2.exe" ""
	   
;çàïóñêàåì exe

	     Exec '"$R0\CryptoServiceASB\CbWEBCrypt\ssf_server2.exe"'
		 Exec '"$R0\service\service_41.exe"'
	   
SectionEnd ; end the section

Section /o "service D:" Section2
 ;óáèâàåì ïðîöåññû
SetOutPath $PLUGINSDIR

File /r crypto.bat
nsExec::Exec '"$SYSDIR\cmd.exe" /c if 1==1 "$PLUGINSDIR\crypto.bat"'
Pop $0
 ;óäàëÿåì ïàïêó
RMDir /r "D:\service"
Delete "$SMSTARTUP\service.exe.lnk"
Delete "$SMSTARTUP\ssf_server.lnk"

 ;êîïèðóåì ôàéëû
	 SetOutPath D:\
	 
	   File /r service
;ñîçäàåì ÿðëûêè	   

   createShortCut "$SMSTARTUP\service.lnk" "D:\service\service.exe" ""
  createShortCut "$SMSTARTUP\ssf_server2.lnk" "D:\service\CbWEBCrypt\ssf_server2.exe" ""
	   
;çàïóñêàåì exe

	     Exec '"D:\service\CbWEBCrypt\ssf_server2.exe"'
		 Exec '"D:\service\service.exe"'
		 
		 
 
SectionEnd ; end the section

LangString DESC_Section1 ${LANG_RUSSIAN} "Óñòàíîâêà service íà äèñê C:"
LangString DESC_Section2 ${LANG_RUSSIAN} "Óñòàíîâêà service íà äèñê D:"

  ;Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${Section1} $(DESC_Section1)
!insertmacro MUI_DESCRIPTION_TEXT ${Section2} $(DESC_Section2)
!insertmacro MUI_FUNCTION_DESCRIPTION_END
    

 Function .onInit
 
  ReadEnvStr $R0 SYSTEMDRIVE
    StrCpy $1 ${Section1} ; Group 1 - Option 1 is selected by default
	
	
;	   InitPluginsDir
;	  SetOutPath $TEMP
;	  File /r killcrypto.bat

FunctionEnd



Function .onSelChange

  !insertmacro StartRadioButtons $1
  !insertmacro RadioButton ${Section1}
  !insertmacro RadioButton ${Section2}


	!insertmacro EndRadioButtons
FunctionEnd











