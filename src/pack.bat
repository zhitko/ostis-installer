ECHO off
For /F "Tokens=2*" %%a In ('Reg Query "HKCU\Software\OSTIS\IQAS"^|Find /I "INSTDIR"') Do Set DPath=%%b
Echo %DPath%
SET SystemPath=system
SET ZipPath=7zip
SET PyPath=Python2.6.2c1
ECHO ##################
ECHO #  Clean^&Zip     #
ECHO ##################
CD "%DPath%\"
DEL /f /q "%SystemPath%.7z"
DEL /f /q "%PyPath%.7z"
ECHO ^<^<^<^< Zip Py System ^>^>^>^>
DEL /f /s /q "%DPath%\%SystemPath%\*.pyc" 
DEL /f /s /q "%DPath%\%SystemPath%\repo\fs_repo"
RMDIR /s /q "%DPath%\%SystemPath%\repo\fs_repo"
"%DPath%\%ZipPath%\7z.exe" "a" "%DPath%\%SystemPath%.7z" "%DPath%\%SystemPath%"
ECHO ^<^<^<^< Zip Python ^>^>^>^>
DEL /f /s /q "%DPath%\%PyPath%\*.pyc" 
"%DPath%\%ZipPath%\7z.exe" "a" "%DPath%\%PyPath%.7z" "%DPath%\%PyPath%"