@echo off
rem Pushes config.json (dock order, hidden apps) to the launcher and restarts it so it rereads the file.
rem Edit config.json first if you want a different dock, then run this again any time.
if not exist config.json (
  echo config.json not found next to this script.
  exit /b 1
)
adb shell mkdir -p /sdcard/Android/data/com.gathin.tvhome/files
adb push config.json /sdcard/Android/data/com.gathin.tvhome/files/config.json
adb shell am force-stop com.gathin.tvhome
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
echo.
echo Done. Check the TV, or take a screenshot:
echo   adb shell screencap -p /sdcard/s6.png ^&^& adb pull /sdcard/s6.png
