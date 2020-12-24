:: Created by IB_U_Z_Z_A_R_Dl with the help of sintrode which reduced the VBScript part and <Tim> for the output debbugging.
@echo off
cd /d "%~dp0"
title Call of Duty Mobile Launcher
if not exist "AppMarket.exe" (
echo:
echo Error: "AppMarket.exe" not found.
echo You have to move "%~nx0" to your Gameloop installation directory.
echo Exemple: "C:\Program Files (x86)\TxGameAssistant\AppMarket\%~nx0"
echo:
pause
exit
)
pushd "%TMP%"
(
echo if msgbox^("Do you want to start Call of Duty Mobile ?",69668,"Call of Duty Mobile"^)=vbyes then
echo wscript.quit ^(6^)
echo else
echo wscript.quit ^(7^)
echo end if
)>msgbox.vbs
cscript //nologo msgbox.vbs
if errorlevel 7 set el=1
popd
net stop QMEmulatorService >nul 2>&1 && sc config QMEmulatorService start=demand >nul 2>&1 && echo Successfully Stopped and set service "QMEmulatorService" to demand.
pushd ".."
for /r %%a in (*.exe) do taskkill /f /im "%%~nxa" >nul 2>&1 && echo Successfully terminated "%%~nxa" processus.
for /r %%a in (*.log) do if exist "%%a" del /f /q "%%a" >nul 2>&1 && echo Successfully deleted "%%~fa"
popd
pushd "%TMP%"
for /f "delims=" %%a in ('dir /b market_page_*') do if exist %%a rd /s /q %%a >nul 2>&1 && echo Successfully deleted "%%~fa"
for %%a in (DwnlData GameDownloadLog Log2File Tencent TGBDownload TInst TUpdateLog TxGameDownload) do if exist "%%a" rd /s /q "%%a" >nul 2>&1 && echo Successfully deleted "%%~fa"
for %%a in (AndroidEmulator-ConfigFileInfo.xml AowGame.xml AppMarket-ConfigFileInfo.xml ConfigFile.zip msgbox.vbs tenprotect_id_???.tmp) do if exist "%%a" del /f /q "%%a" >nul 2>&1 && echo Successfully deleted "%%~fa"
popd
if defined el (
timeout /t 3
exit
)
start "" "AppMarket.exe" -startpkg com.activision.callofduty.shooter -from desktoplink >nul 2>&1 && echo Successfully started "AppMarket.exe -startpkg com.activision.callofduty.shooter -from desktoplink"
echo Waiting for the game to start before closing unnecessary processes...
:LOOP
tasklist /fi "imagename eq AndroidEmulator.exe" | findstr /c:"AndroidEmulator.exe" >nul 2>&1 || goto LOOP
for %%a in (AppMarket syzs_dl_svr) do taskkill /f /im "%%a.exe" >nul 2>&1 && echo Successfully terminated "%%a.exe" processus.
timeout /t 3
exit