@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

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
if /I "%choice%"=="settings" goto settings\
if /I "%choice%"=="messagebomb" goto messagebomb
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
echo ╚═════════════════════════╝
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
echo ╠═════════════════════════╣
echo ╠═    Text Ms Discord    ═╣
echo ╠═       /message\       ═╣
echo ╠═════════════════════════╣
echo ╠═        Settings       ═╣
echo ╠═       /settings\      ═╣
echo ╠═════════════════════════╣
echo ╠═════════════════════════╣
echo ╠═     Ms Bomb On Dis    ═╣
echo ╠═     /messagebomb\     ═╣
echo ╠═════════════════════════╣
echo ╠═     Go Back With b    ═╣
echo ╚═════════════════════════╝
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