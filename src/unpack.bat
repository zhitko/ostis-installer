ECHO off
For /F "Tokens=2*" %%a In ('Reg Query "HKCU\Software\OSTIS\IQAS"^|Find /I "INSTDIR"') Do Set DPath=%%b
Echo %DPath%
SET SystemPath=system
SET ZipPath=7zip
SET PyPath=Python2.6.2c1
CLS
ECHO ##################
ECHO #     UnZip      #
ECHO ##################
CD "%DPath%\"
ERASE /f /s /q "%DPath%\%SystemPath%\*"
RMDIR /s /q "%DPath%\%SystemPath%"
ERASE /f /s /q "%DPath%\%PyPath%\*"
RMDIR /s /q "%DPath%\%PyPath%"
ECHO ^<^<^<^< UnZip Py System ^>^>^>^>
"%DPath%\%ZipPath%\7z.exe" "x" "%DPath%\%SystemPath%.7z" "-y"
ECHO ^<^<^<^< UnZip Python ^>^>^>^>
"%DPath%\%ZipPath%\7z.exe" "x" "%DPath%\%PyPath%.7z" "-y"