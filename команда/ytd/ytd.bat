@echo off
REM ###                                                                                             ###
REM ###                       ~~~~~              ytd.bat             ~~~~~                          ###
REM ###                                                                                             ###
REM ###   ytd.bat is a batch file to simplify the use of the youtube-dl.exe program. It can be set  ###
REM ###   to prompt the user for a desired file destination, or to download to Desktop as default.  ###
REM ###   ytd.bat prompts the user for 11-character youtube video codes, verifies the user's        ###
REM ###   input string is 11 characters in length, and then attempts to execute                     ###
REM ###   the youtube-dl.exe program by calling it with the appropriate flags                       ###
REM ###   and variables.  When the youtube-dl.exe finishes executing, the user                      ###
REM ###   is prompted to either input an additional 11-character code if they                       ###
REM ###   desire to download another file, or they are given the option to                          ###
REM ###   terminate the program. Currently ytd.bat is specifically programmed                       ###
REM ###   to download the highest quality video file, but could be modified to                      ###
REM ###   offer the user other functionalities and capabilities of the                              ###
REM ###   youtube-dl.exe program, such as downloading just an mp3 audio file.                       ###
REM ###                                                                                             ###
REM ###                                                                                             ###
REM ###################################################################################################
REM 
REM  %%%%%%%%%%%%%%%      READ BEFORE USING         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM  %%%%%%%%%%%%%%%%%%         READ BEFORE USING         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM  %%%%%%%%%%%%%%%%%%%%%%%%         READ BEFORE USING         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         READ BEFORE USING      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM
REM  %%%%%%%    SETUP:   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM  %%%%%%%    SETUP:   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM  %%%%%%%    SETUP:   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM
REM  First, you must download the 'youtube-dl.exe' program off the internet.
REM     -- https://yt-dl.org/latest/youtube-dl.exe
REM     -- Move it to an appropriate folder, i.e. C:\Program Files\youtube-dl\
REM     -- Add this directory to your System Environment Variables PATH.
REM
REM  Next, install a suitable version of Python.
REM     -- 'youtube-dl.exe' requires the Python interpreter [2.6, 2.7, or 3.2+]
REM     -- Add the directory of 'Python.exe' to your 
REM            System Environment Variables PATH.
REM 
REM  Next, you may also add the location of 'ytd.bat' to PATH
REM     -- This will allow you to run ytd.bat by simply opening your
REM     -- run menu [win+r], typing 'ytd', and pressing Enter.
REM
REM  Next, set the DEFAULT_SAVE_PATH in the code below.
REM
REM &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
REM &&&&&&&                                                                                     &&&&&&&
REM &&&&&&&                 OPTIONAL: Set the default terminal window position.                 &&&&&&&
REM &&&&&&&                                                                                     &&&&&&&
REM
REM     -- Open cmd.exe and Right-Click the icon in the top left corner
REM
REM [ https://github.com/ponyblaze/gitRepo/blob/master/команда/ytd/cmd_dropdown_menu.gif ]
REM
REM     -- Right-Click 'Properties'
REM
REM [ https://github.com/ponyblaze/gitRepo/blob/master/команда/ytd/properties.gif ]
REM
REM     -- Open the 'Layout' tab from the window that appears
REM
REM [ https://github.com/ponyblaze/gitRepo/blob/master/команда/ytd/layout.gif ]
REM
REM     -- Un-Check the box labeled 'Let system position window'
REM          --- The default position of [0,0] is the top left of your screen.
REM          --- [0,0] is where I prefer it to open.
REM
REM [ https://github.com/ponyblaze/gitRepo/blob/master/команда/ytd/set_position.gif ]
REM
REM &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

REM Delayed expansion required
setlocal enabledelayedexpansion
REM Explicit sizing of the cmd terminal window
mode con:cols=80 lines=40





REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM  ~~~~~~~~~~~~~~~                 DEFAULT_SAVE_PATH                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM  ~~~~~~~~~~~~~~~~~~                    DEFAULT_SAVE_PATH                   ~~~~~~~~~~~~~~~~~~~~~~~~
REM  ~~~~~~~~~~~~~~~~~~~~~~~~                    DEFAULT_SAVE_PATH                   ~~~~~~~~~~~~~~~~~~
REM  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                    DEFAULT_SAVE_PATH                ~~~~~~~~~~~~~~~
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM
REM Change the working directory of the batch program to the default
REM   save location. It is currently pointed towards the current user's
REM   Desktop. The /D flag allows the working directory to move to the
REM   %userprofile%/Desktop/ folder even if it is on a different drive than
REM   the current working directory [which is the folder ytd.bat is stored in]
REM
cd /D %userprofile%
cd Desktop
REM
REM Change this line to { GOTO :URLPROMPT } to skip prompt for save location
REM
GOTO :INIPROMPT
REM 
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM       :INIPROMPT
REM
REM Prompt user to choose a type of input.
REM                     
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:INIPROMPT

cls
call :INITITLEBLOCK
set /p choiceVAR=" > "
echo.
REM if not defined choiceVAR exit
if %choiceVAR%==1 GOTO :DIRPROMPT
if %choiceVAR%==2 GOTO :URLPROMPT
if %choiceVAR%==3 GOTO :PSTPROMPT
GOTO :INIPROMPT




REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM       :DIRPROMPT
REM
REM Prompt user with option to specify directory for file to be saved to.
REM                     
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:DIRPROMPT

cls
call :DIRTITLEBLOCK
set /p My_Path=" > "
echo.
if not defined My_Path GOTO :URLPROMPT
call :CheckDir "%My_Path%"
GOTO :DIRPROMPT





REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM       :CheckDir
REM
REM Error check the requested directory path.
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:CheckDir <fInput>
(
    setlocal enabledelayedexpansion
    if not exist !%~1! (

        cls
        call :ER1TITLEBLOCK
        set /p contin1=" > "
        echo.

        if not defined contin1 GOTO :URLPROMPT
        if contin1==1 GOTO :DIRPROMPT
    )

    if exist !%~1!\nul (
        cd !%~1!
        GOTO :URLPROMPT)
    
    cls
    call :ER2TITLEBLOCK
    set /p contin2=" > "
    echo.

    if not defined contin2 GOTO :URLPROMPT
    if contin2==1 GOTO :DIRPROMPT

    endlocal
    exit /b
)





REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM     :PSTPROMPT
REM
REM Prompt user for 34 digit youtube playlist url code.
REM 
REM    ex:             youtube.com/playlist?list=PLODnBH8kenOp7y_w1CWTtSLxGgAU6BR8M
REM    playlist code:  PLODnBH8kenOp7y_w1CWTtSLxGgAU6BR8M
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:PSTPROMPT

cls
call:PSTTITLEBLOCK

set /p pstcodeVAR=" > "
echo.

call :STRLEN resultVAL pstcodeVAR

if %resultVAL%==34 GOTO :PSTDOWNLOAD

if %resultVAL% NEQ 34 (

    cls
    call :ER4TITLEBLOCK
    GOTO :PSTPROMPT)




REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM     :PSTPOSTPROMPT
REM
REM For additional file downloads, an altered :PSTPROMPT subroutine must be added to preserve
REM     the user input in the terminal. It may be redundant but it works this way so why change it.
REM     
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:PSTPOSTPROMPT

set /p pstcodeVAR=" > "
echo.

if %pstcodeVAR%==1 exit

cls
call :PSTTITLEBLOCK
echo ^> %pstcodeVAR%
echo.

call :STRLEN resultVAL pstcodeVAR

if %resultVAL%==34 GOTO :PSTDOWNLOAD

if %resultVAL% NEQ 34 (

    cls
    call :ER4TITLEBLOCK
    GOTO :PSTPROMPT)




REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM     :URLPROMPT
REM
REM Prompt user for 11 digit youtube url code.
REM 
REM    ex:       youtube.com/watch?v=Vp1zrgcQORE
REM    vidcode:  Vp1zrgcQORE
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:URLPROMPT

cls
call:URLTITLEBLOCK

set /p vidcodeVAR=" > "
echo.

call :STRLEN result vidcodeVAR

if %result%==11 GOTO URLDOWNLOAD

if %result% NEQ 11 (

    cls
    call :ER3TITLEBLOCK
	GOTO URLPROMPT)





REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM     :URLPOSTPROMPT
REM
REM For additional file downloads, an alterated :URLPROMPT subroutine must be
REM     added to preserve the user input in the terminal. It may be redundant
REM     but it works this way so why change it.
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:URLPOSTPROMPT

set /p vidcodeVAR=" > "
echo.

if %vidcodeVAR%==1 exit

cls
call :URLTITLEBLOCK
echo ^> %vidcodeVAR%
echo.

call :STRLEN result vidcodeVAR

if %result%==11 GOTO URLDOWNLOAD

if %result% NEQ 11 (

    cls
    call :ER2TITLEBLOCK
    GOTO URLPROMPT)





REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM      :STRLEN
REM
REM Subroutine to error check length of %vidcode% string
REM    {currently fails to handle string that begins with hyphen:  -  }
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:STRLEN <resultVar> <stringVar>
(
    setlocal enabledelayedexpansion
    set "s=!%~2!#"
    set "len=0"
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
        if "!s:~%%P,1!" NEQ "" ( 
            set /a "len+=%%P"
            set "s=!s:~%%P!"
        )
    )
)
(
    endlocal
    set "%~1=%len%"
    exit /b
)





REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM     :PSTDOWNLOAD
REM
REM Calls the youtube-dl.exe program and passes the appropriate flags and variables.
REM
REM Afterwards, prompts user with choice to download another 
REM                                    playlist, or terminate the program.
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:PSTDOWNLOAD
youtube-dl -i -o "%%(playlist_index)s - %%(title)s.%%(ext)s" %pstcodeVAR% 

REM start "" cmd /c "@echo off&mode con:cols=200 lines=20&echo Your playlist has finished downloading.&PING -n 3 127.0.0.1>nul"

echo.
echo    Enter another playlist code.
echo        ~~~ OR ~~~
echo    Press 1, then ENTER to QUIT
echo  ==============================================================================
echo.

set "pstcodeVAR=0"

GOTO PSTPOSTPROMPT




REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM     :URLDOWNLOAD
REM
REM Calls the youtube-dl.exe program and passes the appropriate flags and variables.
REM
REM Afterwards, prompts user with choice to download another 
REM                                    file, or terminate the program.
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:URLDOWNLOAD
youtube-dl -o "%%(title)s.%%(ext)s" -- %vidcodeVAR% 

REM start "" cmd /c "@echo off&mode con:cols=200 lines=20&echo Your video has finished downloading.&PING -n 3 127.0.0.1>nul"

echo.
echo    Enter another code.
echo        ~~~ OR ~~~
echo    Press 1, then ENTER to QUIT
echo  ==============================================================================
echo.

set "vidcodeVAR=0"

GOTO URLPOSTPROMPT





REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM     :___TITLEBLOCK
REM
REM Hard-coded ASCII graphics, providing relevant
REM              window text for each unique prompt.
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:INITITLEBLOCK (
    setlocal enabledelayedexpansion
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo                           Youtube Downloader UI
    echo                                                                       Aug27_17
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo         Currently Saving To:
    echo.
    echo                  %cd%
    echo.
    echo  ==============================================================================
    echo    WHAT ARE YOU TRYING TO DO?
    echo  ========         Change Save Destination:   PRESS 1, then ENTER       ========
    echo  ========         Download Video:            PRESS 2, then ENTER       ========
    echo  ========         Download Playlist:         PRESS 3, then ENTER       ========
    echo  ==============================================================================
    echo.
    endlocal
    exit /b
)
:DIRTITLEBLOCK (
    setlocal enabledelayedexpansion
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo                           Youtube Downloader UI
    echo                                                                       Aug27_17
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo         Currently Saving To:
    echo.
    echo                  %cd%
    echo.
    echo  ==============================================================================
    echo.
    echo  ========                                                              ========
    echo  ========      Enter a Save Destination, or Press Enter to Continue    ========
    echo  ========                                                              ========
    echo  ==============================================================================
    echo.
    endlocal
    exit /b
)

:URLTITLEBLOCK (
    setlocal enabledelayedexpansion
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo                           Youtube Downloader UI
    echo                                                                       Aug27_17
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo         Currently Saving To:
    echo.
    echo                  %cd%
    echo.
    echo  ==============================================================================
    echo.
    echo  ========                                                              ========
    echo  ========               Enter an Eleven Digit Video Code               ========
    echo  ========                                                              ========
    echo  ==============================================================================
    echo.
    endlocal
    exit /b
)

:ER1TITLEBLOCK (
    setlocal enabledelayedexpansion
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo                           Youtube Downloader UI
    echo                                                                       Aug27_17
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo         Currently Saving To:
    echo.
    echo                  %cd%
    echo.
    echo  ==============================================================================
    echo                             INVALID DIRECTORY
    echo.
    echo  ========        Press 1, then ENTER to try again.                     ========
    echo  ========                                                              ========
    echo  ========        Press ENTER to save to default directory.             ========
    echo  ==============================================================================
    echo.
    endlocal
    exit /b
)

:ER2TITLEBLOCK (
    setlocal enabledelayedexpansion
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo                           Youtube Downloader UI
    echo                                                                       Aug27_17
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo         Currently Saving To:
    echo.
    echo                  %cd%
    echo.
    echo  ==============================================================================
    echo                      INVALID DIRECTORY OR WRITE PERMISSIONS
    echo.
    echo  ========        Press 1, then ENTER to try again.                     ========
    echo  ========                                                              ========
    echo  ========        Press ENTER to save to default directory.             ========
    echo  ==============================================================================
    echo.
    endlocal
    exit /b
)
:ER3TITLEBLOCK (
    setlocal enabledelayedexpansion
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo                           Youtube Downloader UI
    echo                                                                       Aug27_17
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo         Currently Saving To:
    echo.
    echo                  %cd%
    echo.
    echo  ==============================================================================
    echo                               INVALID VIDEO CODE
    echo.
    echo  ========       Press ENTER to try again.                              ========
    echo  ========                                                              ========
    echo  ========       Type any other string, then press ENTER to QUIT        ========
    echo  ==============================================================================
    echo.
    endlocal
    exit /b
)
:ER4TITLEBLOCK (
    setlocal enabledelayedexpansion
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo                           Youtube Downloader UI
    echo                                                                       Aug27_17
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo         Currently Saving To:
    echo.
    echo                  %cd%
    echo.
    echo  ==============================================================================
    echo                            INVALID PLAYLIST CODE
    echo.
    echo  ========       Press ENTER to try again.                              ========
    echo  ========                                                              ========
    echo  ========       Type any other string, then press ENTER to QUIT        ========
    echo  ==============================================================================
    echo.
    endlocal
    exit /b
)
:PSTTITLEBLOCK (
    setlocal enabledelayedexpansion
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo                           Youtube Downloader UI
    echo                                                                       Aug27_17
    echo  ==============================================================================
    echo  ==============================================================================
    echo.
    echo         Currently Saving To:
    echo.
    echo                  %cd%
    echo.
    echo  ==============================================================================
    echo.
    echo.
    echo  ========                                                              ========
    echo  ========          Enter a Thirty-Four Digit Playlist Code             ========
    echo  ========                                                              ========
    echo  ==============================================================================
    echo.
    endlocal
    exit /b
)




REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM     :EOF
REM
REM Watchdog code to catch anything that derails the program counter.
REM
REM Shouldn't happen but don't remove this.   {>0.0}>
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:EOF
endlocal
echo PRESS ENTER TO EXIT
set /p pauseit=">>> "
exit





REM FUTURE EXPANSIONS:
REM 
REM     +++ Add the option to download an audio file:
REM             youtube-dl --extract-audio --audio-format mp3 <video URL>
REM
REM     +++ Add the option to download a playlist.
REM
REM     +++ Add the option to input a file containing an array/list of url codes.
REM
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
REM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~