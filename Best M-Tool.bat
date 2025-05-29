@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo INSTALL Python FOR THIS TO WORK WHEN YOU HAVE PUT A # AT THE START OF THIS LINE
pause


:: Load settings
if exist settings.txt (
    for /f "tokens=1,* delims==" %%A in (settings.txt) do (
        set "%%A=%%B"
    )
) else (
    echo No settings found. Using default values...
    timeout /t 1 >nul
    set "color=0A"
    set "title=Great M-Tool - By YOMAMA"
)

:: Apply settings
color %color%
title %title%

:banner
cls
echo.
echo _//       _//    _/_/_/_/_//                    _//
echo _/ _//   _///        _//                        _//
echo _// _// _ _//        _//      _//       _//     _//
echo _//  _//  _//        _//   _//  _//  _//  _//   _//
echo _//   _/  _//        _//  _//    _//_//    _//  _//
echo _//       _//        _//   _//  _//  _//  _//   _//
echo _//       _//         _//    _//       _//      _//
echo.
echo ╔═════════════════════════╗
echo ╠ Type h For Command List ╣
echo ╠═════════════════════════╝
set /p choice=╚══════»
if /I "%choice%"=="h" goto help
if /I "%choice%"=="message" goto message
if /I "%choice%"=="settings" goto settings
if /I "%choice%"=="messagebomb" goto messagebomb
if /I "%choice%"=="encrypt" goto encrypt
if /I "%choice%"=="ipscriptgen" goto ipscriptgen
if /I "%choice%"=="fakehack" goto fakehack
if /I "%choice%"=="ddos" goto ddos
if /I "%choice%"=="noti" goto noti
if /I "%choice%"=="geo" goto geolocate
if /I "%choice%"=="ghost" goto ghost
if /I "%choice%"=="pass" goto passgen
if /I "%choice%"=="rat" goto rat
goto banner

:settings
cls
echo ╔═════════════════════════╗
echo ╠═        Settings       ═╣
echo ╠═════════════════════════╣
echo ╠═  Change Color txt/bg  ═╣
echo ╠═        /color\        ═╣
echo ╠═════════════════════════╣
echo ╠═      Change Title     ═╣
echo ╠═        /title\        ═╣
echo ╠═════════════════════════╣
echo ╠═     Save Settings     ═╣
echo ╠═        /save\         ═╣
echo ╠═════════════════════════╣
echo ╠═     Go Back With b    ═╣
echo ╠═════════════════════════╝
set /p choice=╚══════»

if /I "%choice%"=="color" goto changeColor
if /I "%choice%"=="title" goto changeTitle
if /I "%choice%"=="save" goto saveSettings
if /I "%choice%"=="b" goto banner
goto settings

:changeColor
cls
echo Enter new color code (e.g., 0A, 1F, etc):
set /p color=
goto settings

:changeTitle
cls
echo Enter new window title:
set /p title=
goto settings

:saveSettings
(
    echo color=%color%
    echo title=%title%
) > settings.txt

:: Re-apply settings immediately
color %color%
title %title%
echo Settings saved and applied!
timeout /t 2 >nul
goto settings

:help
cls
echo ╔═════════════════════════╗
echo ╠═          HELP         ═╣
echo ╠═════════════════════════╬════════════════════════╗
echo ╠═        Settings       ═╬═  Create Shell Noti   ═╣
echo ╠═       /settings\      ═╬═         /noti\       ═╣
echo ╠═════════════════════════╬════════════════════════╣
echo ╠═    Text Ms Discord    ═╬═         Ddos         ═╣
echo ╠═       /message\       ═╬═        /ddos\        ═╣
echo ╠═════════════════════════╬════════════════════════╣
echo ╠═     Ms Bomb On Dis    ═╬═      GeoLocator      ═╣
echo ╠═     /messagebomb\     ═╬═        /geo\         ═╣
echo ╠═════════════════════════╬════════════════════════╣
echo ╠═    Encrypt Bat File   ═╬═        Ghost         ═╣
echo ╠═       /encrypt\       ═╬═       /ghost\        ═╣
echo ╠═════════════════════════╬════════════════════════╣
echo ╠═   Ip Graber Script    ═╬═       Pass Gen       ═╣
echo ╠═     /ipscriptgen\     ═╬═        /Pass\        ═╣
echo ╠═════════════════════════╬════════════════════════╣
echo ╠═      Wow Hacker       ═╬═          RAT         ═╣
echo ╠═      /fakehack\       ═╬═         /rat\        ═╣
echo ╠═════════════════════════╬════════════════════════╝
echo ╠═     Go Back With b    ═╣
echo ╠═════════════════════════╝
set /p choice=╚══════»
if /I "%choice%"=="b" goto banner
goto help

:message  
cls
echo ╔══════════════════════════╗
echo ║      DM Channels Tool    ║
echo ╠══════════════════════════╣
echo ║  Make sure channel_id.txt║
echo ║   has one ID per line.   ║
echo ╚══════════════════════════╝
echo.

title Send DMs

:: Create token.txt if it doesn't exist
if not exist token.txt (
    echo Creating token.txt...
    echo.>token.txt
    echo Please paste your Discord bot token into token.txt and save it.
    pause
    start notepad token.txt
    cls
    goto message
)

:: Create channel_id.txt if it doesn't exist
if not exist channel_id.txt (
    echo Creating channel_id.txt...
    echo.>channel_id.txt
    echo Please add one channel ID per line in channel_id.txt and save it.
    pause
    start notepad channel_id.txt
    cls
    goto message
)

:: Read token from file
set /p token=<token.txt

:: Prompt for message
:enter_message
set /p message=Enter the message to send: 
if not defined message (
    echo You must enter a message. Try again.
    goto enter_message
)

:: Loop through each channel ID
for /f "delims=" %%C in (channel_id.txt) do (
    echo Sending message to Channel ID: %%C
    curl -X POST ^
        -H "Authorization: %token%" ^
        -H "Content-Type: application/json" ^
        -d "{\"content\":\"%message%\"}" ^
        https://discord.com/api/v9/channels/%%C/messages
    if errorlevel 1 (
        echo Failed to send message to %%C — this tool may be outdated or the token/channel ID may be invalid.
    )
    echo.
    timeout /t 2 >nul
)

:: Prompt for what to do next
echo All messages sent.
set /p again=Do you want to go back to the Start Menu or send a new message? (start/new): 
if /I "%again%"=="start" goto banner
if /I "%again%"=="new" goto message

echo Invalid option. Returning to the Start Menu...
goto banner


:messagebomb
cls
echo ╔══════════════════════════╗
echo ║     Message Bomb Tool    ║
echo ╠══════════════════════════╣
echo ║  Make sure channel_id.txt║
echo ║   has one ID per line.   ║
echo ╚══════════════════════════╝
echo.

:: Create token.txt if it doesn't exist
if not exist token.txt (
    echo Creating token.txt...
    echo.>token.txt
    echo Please paste your Discord bot token into token.txt and save it.
    pause
    start notepad token.txt
    cls
    goto messagebomb
)

:: Create channel_id.txt if it doesn't exist
if not exist channel_id.txt (
    echo Creating channel_id.txt...
    echo.>channel_id.txt
    echo Please add one channel ID per line in channel_id.txt and save it.
    pause
    start notepad channel_id.txt
    cls
    goto messagebomb
)

:: Read token from file
set /p token=<token.txt

:: Prompt for message
:enter_bomb_message
set /p message=Enter the message to send: 
if not defined message (
    echo You must enter a message. Try again.
    goto enter_bomb_message
)

:: Ask how many times to send
set /p bomb_count=How many times do you want to send the message? (e.g., 5): 

:: Validate bomb_count is numeric
for /f "delims=0123456789" %%A in ("%bomb_count%") do (
    echo Invalid number. Try again.
    goto messagebomb
)

:: Ask for delay between messages
set /p delay=Enter delay (in seconds) between messages: 
:: Ensure the delay is a valid number
for /f "delims=0123456789" %%B in ("%delay%") do (
    echo Invalid delay value. Please enter a valid number.
    goto messagebomb
)

:: Bomb loop
for /f "delims=" %%C in (channel_id.txt) do (
    echo Bombing Channel ID: %%C
    for /L %%i in (1,1,%bomb_count%) do (
        echo Sending message #%%i to Channel ID: %%C
        curl -X POST ^
            -H "Authorization: %token%" ^
            -H "Content-Type: application/json" ^
            -d "{\"content\":\"%message%\"}" ^
            https://discord.com/api/v9/channels/%%C/messages
        if errorlevel 1 (
            echo Failed to send message #%%i to %%C.
        )
        timeout /t %delay% >nul
    )
    echo.
)

:: Prompt for what to do next
echo Bombing complete.
set /p again=Do you want to go back to the Start Menu or send a new message? (start/new): 
if /I "%again%"=="start" goto banner
if /I "%again%"=="new" goto messagebomb

echo Invalid option. Returning to the Start Menu...
goto banner

:encrypt
cls
echo ╔═════════════════════════╗
echo ╠═    Add This in hex    ═╣
echo ╠═════════════════════════╣
echo ╠ FF FE 26 63 6c 73 0D OA ╣
echo ╠═════════════════════════╣
echo ╠═     Go Back With b    ═╣
echo ╠═════════════════════════╝
set /p choice=╚══════»
if /I "%choice%"=="b" goto banner
pause

:ipscriptgen
cls
echo Downloading remote script from GitHub...

:: Set correct RAW GitHub URL to the TXT file
set "url=https://raw.githubusercontent.com/NFCsamurai/Discordnamegraber/main/discordnamegraber.txt"

:: Name of the output file (you can make it .bat if it's meant to be run)
set "output=script.txt"

:: Use curl to download
curl -s -o "%output%" "%url%"

:: Check if the file downloaded
if exist "%output%" (
    echo Script downloaded successfully as "%output%".
) else (
    echo Failed to download the script. Please check the URL or internet connection.
)

start script.txt

goto banner


:fakehack
cls
:: Set characters for Matrix rain (you can add more)
set "chars=アイウエオカキクケコサシスセソタチツテトナニヌネノ0123456789"

:: Max line width
set "width=80"

:: Infinite loop
:loop
set "line="
for /L %%i in (1,1,%width%) do (
    set /a "rand=!random! %% 55"
    call set "char=%%chars:~!rand!,1%%"
    set "line=!line!!char!"
)

echo !line!
goto loop

:noti
cls
:: Prompt for title
set /p notif_title=Enter notification title: 

:: Prompt for message
set /p notif_msg=Enter notification message: 

:: Prompt for icon type (None, Info, Warning, Error)
echo Select an icon type: None, Info, Warning, Error
set /p notif_icon=Enter icon type: 

:: Normalize icon input
set "notif_icon=%notif_icon:~0,1%%notif_icon:~1%"
if /i "%notif_icon%"=="none" set notif_icon=None
if /i "%notif_icon%"=="info" set notif_icon=Info
if /i "%notif_icon%"=="warning" set notif_icon=Warning
if /i "%notif_icon%"=="error" set notif_icon=Error

:: Show preview notification
echo Showing preview...
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(3000, '%notif_title%', '%notif_msg%', [System.Windows.Forms.ToolTipIcon]::%notif_icon%); Start-Sleep -Seconds 4; $notify.Dispose()"

:: Ask if user wants to show again
echo.
set /p choice=Send again with same message? (y/n): 
if /i "%choice%"=="y" goto :again
if /i "%choice%"=="n" goto :banner
goto :eof

:again
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(3000, '%notif_title%', '%notif_msg%', [System.Windows.Forms.ToolTipIcon]::%notif_icon%); Start-Sleep -Seconds 4; $notify.Dispose()"
goto :eof

:ddos
color 04
cls
echo.
echo ================================
echo             Ddoss
echo ================================
echo.
set /p target=Enter target IP or domain: 
if "%target%"=="" goto menu

set /p count=Enter number of pings to send: 
if "%count%"=="" goto menu

echo.
echo Starting...
ping %target% -n %count%
echo.
pause
goto banner

:geolocate
cls
:: Step 1: Install Python dependency
echo Installing Python requests module if not already present...
pip install requests >nul 2>&1

:: Step 2: Define temp file path
set "tempfile=%TEMP%\geo.py"

:: Step 3: Download Python script from GitHub
echo Downloading Python geolocation script to temporary folder...

:: Replace this URL with your raw GitHub file URL
set "github_url=https://raw.githubusercontent.com/NFCsamurai/Discordnamegraber/main/geo.py"

:: Use PowerShell to download file
powershell -Command "Invoke-WebRequest -Uri '!github_url!' -OutFile '!tempfile!'"

:: Step 4: Run the downloaded script
echo Running geolocation tool...
python "!tempfile!"

:: Step 5: Clean up
echo Cleaning up temporary file...
del /f /q "!tempfile!"

echo Done.

set /p again=Do you want to go back to the Start Menu or send a new message? (start/new): 
if /I "%again%"=="Back" goto banner
if /I "%again%"=="New" goto geolocate

echo Invalid option. Returning to the Start Menu...
goto banner

:ghost 
cls
setlocal EnableDelayedExpansion

echo Installing required Python modules...
pip install requests >nul 2>&1
pip install phonenumbers >nul 2>&1

:: Define temp file path
set "tempfile=%TEMP%\GhostTR.py"

:: Correct raw GitHub file URL
set "github_url=https://raw.githubusercontent.com/HunxByts/GhostTrack/main/GhostTR.py"

:: Download GhostTR.py using PowerShell
echo Downloading GhostTrack script...
powershell -Command "try { Invoke-WebRequest -Uri '!github_url!' -OutFile '!tempfile!' -ErrorAction Stop } catch { Write-Host 'Download failed.'; exit 1 }"

:: Check if the file was downloaded
if not exist "!tempfile!" (
    echo Failed to download GhostTrack script. Please check your internet connection or the GitHub URL.
    pause
    goto menu
)

:: Run the Python script
echo Running GhostTrack...
python "!tempfile!"

:: Clean up
echo Cleaning up temporary file...
del /f /q "!tempfile!"

:: Return option
echo.
color 0A
set /p again=Do you want to go back to the Start Menu or send a new message? (start/new): 
if /I "!again!"=="start" goto banner
if /I "!again!"=="new" goto ghost
goto banner


:passgen
cls

pip install colorama >nul 2>&1
pip install pyfiglet >nul 2>&1

:: Step 2: Define temp file path
set "tempfile=%TEMP%\pass.py"

:: Step 3: Download Python script from GitHub
echo Downloading Python geolocation script to temporary folder...

:: Replace this URL with your raw GitHub file URL
set "github_url=https://raw.githubusercontent.com/NFCsamurai/Discordnamegraber/main/pass.py"

:: Use PowerShell to download file
powershell -Command "Invoke-WebRequest -Uri '!github_url!' -OutFile '!tempfile!'"

:: Step 4: Run the downloaded script
echo Running geolocation tool...
python "!tempfile!"

:: Step 5: Clean up
echo Cleaning up temporary file...
del /f /q "!tempfile!"

echo Done.

set /p again=Do you want to go back to the Start Menu or send a new message? (start/new): 
if /I "%again%"=="Back" goto banner
if /I "%again%"=="New" goto passgen

echo Invalid option. Returning to the Start Menu...
goto banner

:rat
cls
echo WATCH THE TUT: https://youtu.be/bcSkhhqGYd8?t=837
echo ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo ╠                                                remote desktop on:                                                      ╣
echo ╠════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
echo ╠reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f╣
echo ╠════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
echo ╠             netsh advfirewall firewall set rule group="remote desktop" new enable=Yes                                  ╣
echo ╠════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
echo ╠                                                remote desktop off:                                                     ╣
echo ╠════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
echo ╠reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f╣
echo ╠════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
echo ╠             netsh advfirewall firewall set rule group="remote desktop" new enable=No                                   ╣
echo ╠════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
set /p host="<<host>> "
set /p user="<<user>> "
set /p pass="<<password>> "
cmdkey /add:%host% /user:%user% /pass:%pass%
mstsc /v:%host%
cmdkey /delete:%host%
exit

