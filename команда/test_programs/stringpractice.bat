@echo off &setlocal
setlocal enabledelayedexpansion

echo Current Directory:  %~dp0
set /p MY_PATH= ###  Enter a save location (no entry saves to desktop)
call :CheckDir My_Path


:CheckDir <fInput>
if not exist !%~1! ( set "type=INVALID" ) else if exist !%~1!\nul ( set "type=FOLDER" ) else ( set "type=FILE" )
echo !%~1! = %type%

endlocal
:EOF
pause
exit