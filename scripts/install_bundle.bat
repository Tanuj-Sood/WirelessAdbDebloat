@echo off
rem Usage: install_bundle.bat folder_with_extracted_apks
rem For split/bundle apps (.apkm): installs every .apk in the folder as ONE update.
rem Uses pm install-create/write/commit over the shell, because plain "adb install" hangs on this TV.
if "%~1"=="" (
  echo Usage: install_bundle.bat folder_with_apks
  exit /b 1
)
if not exist "%~1\base.apk" (
  echo No base.apk found in %~1
  exit /b 1
)
set SID=
for /f "tokens=2 delims=[]" %%S in ('adb shell pm install-create -r') do set SID=%%S
if not defined SID (
  echo Could not create an install session on the TV.
  exit /b 1
)
echo Install session: %SID%
for %%F in ("%~1\*.apk") do (
  echo Adding %%~nxF
  adb push "%%F" /data/local/tmp/%%~nxF
  adb shell pm install-write %SID% %%~nxF /data/local/tmp/%%~nxF
)
adb shell pm install-commit %SID%
for %%F in ("%~1\*.apk") do (
  adb shell rm /data/local/tmp/%%~nxF
)
