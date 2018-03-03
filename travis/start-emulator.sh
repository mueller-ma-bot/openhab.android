android list device
echo no | android create avd --force -n test -t android-22 --abi armeabi-v7a -d "5.4in FWVGA"
emulator -avd test -no-audio -no-window &
android-wait-for-emulator
adb shell input keyevent 82 &
android list target
