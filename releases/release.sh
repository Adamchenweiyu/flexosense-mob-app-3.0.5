ANDROID_VERSION=v3.0.6

BUILD_PATH=../build/app/outputs/apk/release
BUILD_FIRMWARE_PATH=$BUILD_PATH/app-release.apk

FINAL_FIRMWARE_PATH=$ANDROID_VERSION/iot_feet_app_android_$ANDROID_VERSION.apk

flutter pub get

flutter build apk --release

rm -R $ANDROID_VERSION
mkdir $ANDROID_VERSION

cp $BUILD_FIRMWARE_PATH $FINAL_FIRMWARE_PATH

adb install $FINAL_FIRMWARE_PATH