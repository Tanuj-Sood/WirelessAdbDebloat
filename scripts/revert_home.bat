@echo off
rem Puts the original launcher back as Home. The new launcher stays installed (remove it with: adb shell pm uninstall com.gathin.tvhome)
adb shell cmd package set-home-activity --user 0 com.kitking.YouTubeLauncherV3/com.kitking.YouTubeLauncherV3.MainActivity
adb shell input keyevent KEYCODE_HOME
echo Done. Press Home on the remote to check.
