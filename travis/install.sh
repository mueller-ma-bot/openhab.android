echo yes | sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"
echo yes | sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"
./gradlew --version
sdkmanager --list || true
