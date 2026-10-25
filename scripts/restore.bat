@echo off
rem Re-enables every package that disable_batch.bat disabled (read from tvbackup\disabled_by_us.txt).
rem To re-enable a single app instead: adb shell pm enable <package>
if not exist tvbackup\disabled_by_us.txt (
  echo Nothing to restore: tvbackup\disabled_by_us.txt not found.
  exit /b 1
)
for /f "usebackq tokens=* delims=" %%P in ("tvbackup\disabled_by_us.txt") do (
  echo Enabling %%P
  adb shell pm enable %%P
)
echo.
echo Done. Reboot the TV with: adb reboot
echo Packages still disabled now:
adb shell pm list packages -d
