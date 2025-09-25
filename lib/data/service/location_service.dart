import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:location/location.dart';

class LocationService {
  static Future<bool> isEnable() async {
    return await Location().serviceEnabled();
  }

  static Future<bool> requestLocation() async {
    return await Location().requestService();
  }

  ///ios: Don't need to enable location for scanning ble.
  static Future<bool> isEnableForScanningBLe() async {
    if (Platform.isIOS) return true;

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    final sdkVersion = androidInfo.version.sdkInt;

    //Above android 11 ==> no need to request Location Enable for scanning BLE
    if (sdkVersion > 30) {
      return true;
    }

    return await isEnable();
  }
}
