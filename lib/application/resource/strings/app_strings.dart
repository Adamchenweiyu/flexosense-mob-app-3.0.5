import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//Run this command to generate new locale strings
//flutter gen-l10n
class AppStrings {
  static AppLocalizations getLocalization() {
    // fixme, to many null check operators
    return AppLocalizations.of(AppNavigation.navigatorKey.currentContext!)!;
  }

  static String replaceValue = '@value';
  static String get home => getLocalization().home;
  static String get noDevice => getLocalization().noDevice;
  static String get connectYourDeviceToStart => getLocalization().connectYourDeviceToStart;
  static String get addDevice => getLocalization().addDevice;
  static String get flexoWouldLikeToAccessBluetooth =>
      getLocalization().flexoWouldLikeToAccessBluetooth;
  static String get toConnectToDeviceWeNeed => getLocalization().toConnectToDeviceWeNeed;
  static String get goToSettings => getLocalization().goToSettings;
  static String get flexoWouldLikeToAccessLocation =>
      getLocalization().flexoWouldLikeToAccessLocation;
  static String get toConnectToDeviceWeNeedLocation =>
      getLocalization().toConnectToDeviceWeNeedLocation;
  static String get cancel => getLocalization().cancel;
  static String get scanningYourDevice => getLocalization().scanningYourDevice;
  static String get connect => getLocalization().connect;
  static String get disconnect => getLocalization().disconnect;
  static String get connecting => getLocalization().connecting;
  static String get yourDeviceIsBeingConnected => getLocalization().yourDeviceIsBeingConnected;
  static String get scanningYourDevices => getLocalization().scanningYourDevices;
  static String get failedToConnect => getLocalization().failedToConnect;
  static String get makeSureDeviceIsTurnedOn => getLocalization().makeSureDeviceIsTurnedOn;
  static String get ok => getLocalization().ok;
  static String get successfullyConnected => getLocalization().successfullyConnected;
  static String get yourDeviceHasBeenConnected => getLocalization().yourDeviceHasBeenConnected;
  static String get unknownDevice => getLocalization().unknownDevice;
  static String get scan => getLocalization().scan;
  static String get stopScan => getLocalization().stopScan;
  static String get back => getLocalization().back;
  static String get hwVersion => getLocalization().hwVersion;
  static String get fwVersion => getLocalization().fwVersion;
  static String get deviceDetail => getLocalization().deviceDetail;
  static String get deviceInfo => getLocalization().deviceInfo;
  static String get getDeviceInfo => getLocalization().getDeviceInfo;
  static String get setStartStopStudy => getLocalization().setStartStopStudy;
  static String get setTimeStamp => getLocalization().setTimeStamp;
  static String get getTimeStamp => getLocalization().getTimeStamp;
  static String get getErrorCode => getLocalization().getErrorCode;
  static String get getBatteryInfo => getLocalization().getBatteryInfo;
  static String get deviceName => getLocalization().deviceName;
  static String get deviceAddress => getLocalization().deviceAddress;
  static String get errorCode => getLocalization().errorCode;
  static String get imuSensor => getLocalization().imuSensor;
  static String get magSensor => getLocalization().magSensor;
  static String get batteryMonitor => getLocalization().batteryMonitor;
  static String get pressureSensor => getLocalization().pressureSensor;
  static String get wrongSide => getLocalization().wrongSide;
  static String get timestamp => getLocalization().timestamp;
  static String get batteryInfo => getLocalization().batteryInfo;
  static String get isCharging => getLocalization().isCharging;
  static String get batteryLevel => getLocalization().batteryLevel;
  static String get voltage => getLocalization().voltage;
  static String get liveAccelData => getLocalization().liveAccelData;
  static String get liveGyrosData => getLocalization().liveGyrosData;
  static String get liveRawPitchYawData => getLocalization().liveRawPitchYawData;
  static String get liveMagneticData => getLocalization().liveMagneticData;
  static String get livePressureData => getLocalization().livePressureData;
  static String get viewStoredData => getLocalization().viewStoredData;
  static String get viewStoredAccel => getLocalization().viewStoredAccel;
  static String get viewStoredGyros => getLocalization().viewStoredGyros;
  static String get viewStoredRollPitchYaw => getLocalization().viewStoredRollPitchYaw;
  static String get viewStoredMagnetic => getLocalization().viewStoredMagnetic;
  static String get viewStoredPressure => getLocalization().viewStoredPressure;
  static String get pair => getLocalization().pair;
}
