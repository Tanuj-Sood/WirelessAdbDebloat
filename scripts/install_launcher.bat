@echo off
rem Usage: install_launcher.bat app-release.apk
rem Installs the Clean Your TV launcher (com.gathin.tvhome) and makes it Home.
rem The current launcher (com.kitking.YouTubeLauncherV3) is NOT disabled, so revert_home.bat always has a way back.
if "%~1"=="" (
  echo Usage: install_launcher.bat app-release.apk
  exit /b 1
)
if not exist "%~1" (
  echo File not found: %~1
  exit /b 1
)
adb push "%~1" /data/local/tmp/tvhome.apk
adb shell pm install -r /data/local/tmp/tvhome.apk > "%TEMP%\tvhome_install.txt" 2>&1
type "%TEMP%\tvhome_install.txt"
adb shell rm -f /data/local/tmp/tvhome.apk
findstr /b /c:"Success" "%TEMP%\tvhome_install.txt" >nul
if errorlevel 1 (
  echo.
  echo INSTALL FAILED. Nothing else was changed; Home is still the old launcher. Send me the message above.
  exit /b 1
)
adb shell pm grant com.gathin.tvhome android.permission.ACCESS_FINE_LOCATION
adb shell am start -W -a android.intent.action.MAIN -c android.intent.category.HOME -n com.gathin.tvhome/.MainActivity
adb shell cmd package set-home-activity --user 0 com.gathin.tvhome/.MainActivity
echo.
echo Installed. Now take a screenshot and press Home on the remote to see which launcher opens.
