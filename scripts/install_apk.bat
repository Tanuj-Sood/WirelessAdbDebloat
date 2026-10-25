@echo off
rem Usage: install_apk.bat prime.apk
rem Pushes the APK to the TV and installs it over the shell (plain "adb install" hangs on this TV).
rem -r keeps the app's data and login, so this works as an update.
if "%~1"=="" (
  echo Usage: install_apk.bat file.apk
  exit /b 1
)
if not exist "%~1" (
  echo File not found: %~1
  exit /b 1
)
adb push "%~1" /data/local/tmp/app.apk
adb shell pm install -r /data/local/tmp/app.apk
adb shell rm /data/local/tmp/app.apk
