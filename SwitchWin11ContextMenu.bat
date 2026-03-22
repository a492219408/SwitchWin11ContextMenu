@echo off
setlocal EnableExtensions

title Switch Windows 11 Context Menu

:menu
cls
echo ========================================
echo   Windows 11 Context Menu Switcher
echo ========================================
echo.
echo   1. Restore classic context menu
echo   2. Restore modern context menu
echo   3. Exit
echo.
choice /C 123 /N /M "Select an option [1-3]: "
set "menu_choice=%errorlevel%"

echo.
if "%menu_choice%"=="3" goto :end
if "%menu_choice%"=="2" goto :modern
if "%menu_choice%"=="1" goto :classic

echo Invalid selection.
pause
goto :menu

:classic
echo Switching to the classic Windows context menu...
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
if errorlevel 1 goto :reg_failed

echo.
echo Success: the classic Windows 10-style context menu has been enabled.
goto :restart_prompt

:modern
echo Switching to the modern Windows 11 context menu...
reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
if errorlevel 1 (
    reg.exe query "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" >nul 2>&1
    if not errorlevel 1 goto :reg_failed
)

echo.
echo Success: the modern Windows 11 context menu has been enabled.
goto :restart_prompt

:restart_prompt
echo.
set "restart_choice="
set /p "restart_choice=Restart Windows Explorer now? [Y/n]: "
if /I "%restart_choice%"=="N" goto :skip_restart
if not "%restart_choice%"=="" if /I not "%restart_choice%"=="Y" (
    echo Invalid selection. Press Enter for Yes or type N for No.
    goto :restart_prompt
)

echo.
echo Restarting Windows Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start "" explorer.exe
if errorlevel 1 (
    echo Warning: Explorer may not have restarted correctly. Please restart it manually.
) else (
    echo Explorer restarted.
)
goto :done

:skip_restart
echo.
echo Explorer was not restarted. Sign out or restart Explorer later to apply the change.
goto :done

:reg_failed
echo.
echo Error: failed to update the registry.
echo Please make sure you are running on Windows 11 and try again.
goto :done

:done
echo.
pause
goto :menu

:end
endlocal
exit /b 0
