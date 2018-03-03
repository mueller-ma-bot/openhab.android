git config --local user.name "TravisCI"
git config --local user.email "support@openhab.org"
git add fastlane/*
git commit -m "Update fastlane metadata"
#git push origin :refs/heads/master

./gradlew assemble

openssl aes-256-cbc -K $encrypted_903a93ed2309_key -iv $encrypted_903a93ed2309_iv -in keystore.enc -out keystore -d
cp $TRAVIS_BUILD_DIR/keystore $HOME
mkdir $HOME/apks_to_deploy
cp mobile/build/outputs/apk/full/release/mobile-full-release-unsigned.apk $HOME/apks_to_deploy
cp mobile/build/outputs/apk/foss/release/mobile-foss-release-unsigned.apk $HOME/apks_to_deploy
cd $HOME/apks_to_deploy
# Sign apks
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $HOME/keystore -storepass $storepass mobile-full-release-unsigned.apk sign
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $HOME/keystore -storepass $storepass mobile-foss-release-unsigned.apk sign
# Verify signing
jarsigner -verify mobile-full-release-unsigned.apk
jarsigner -verify mobile-foss-release-unsigned.apk
# Zipalign apks
${ANDROID_HOME}/build-tools/25.0.2/zipalign -v 4 mobile-full-release-unsigned.apk openhab-android.apk
${ANDROID_HOME}/build-tools/25.0.2/zipalign -v 4 mobile-foss-release-unsigned.apk openhab-android-foss.apk
