@echo off
rem Usage: disable_batch.bat batch1.txt
rem batch1.txt = one package name per line.
rem Runs one pm command per adb call and logs every package that really ended up disabled.
if "%~1"=="" (
  echo Usage: disable_batch.bat ^<file with one package per line^>
  exit /b 1
)
if not exist tvbackup mkdir tvbackup
for /f "usebackq tokens=* delims=" %%P in ("%~1") do (
  echo Disabling %%P
  adb shell pm disable-user --user 0 %%P
  adb shell pm list packages -d | findstr /x /c:"package:%%P" >nul && echo %%P>>tvbackup\disabled_by_us.txt
)
echo.
echo Done. Currently disabled packages:
adb shell pm list packages -d
