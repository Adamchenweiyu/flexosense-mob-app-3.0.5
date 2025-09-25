/// Store all images path of the app, include SVG, PNG, JSON
class AppImages {
  //****************************  SVG ****************************//
  static String oneBlackShoe = ImagesPath.getPath('one_black_shoe.svg');

  //****************************  PNG ****************************//
  static String appLogo = ImagesPath.getPath('app_logo.png');
  static String emptyDevice = ImagesPath.getPath('empty_device.png');
  static String feetSensor = ImagesPath.getPath('feet_sensor.png');
  static String icError = ImagesPath.getPath('ic_error.png');
  static String icBattery = ImagesPath.getPath('ic_battery.png');
  static String icBatteryCharging = ImagesPath.getPath('ic_battery_charging.png');
  static String icInformation = ImagesPath.getPath('ic_information.png');
  static String disconnectBluetooth = ImagesPath.getPath('disconnect_bluetooth.png');

  //****************************  JSON ****************************//
  static String appLoading = ImagesPath.getPath('app_loading.json');
  static String bluetoothScanning = ImagesPath.getPath('bluetooth_scanning.json');
  static String appLoadingGreenCircle = ImagesPath.getPath('app_loading_green_circle.json');
  static String appLoadingAmongUs = ImagesPath.getPath('app_loading_among_us.json');
}

extension ImagesPath on AppImages {
  static String getPath(String name) {
    if (name.contains('.svg')) {
      return 'assets/svg/$name';
    }
    if (name.contains('.png')) {
      return 'assets/png/$name';
    }
    if (name.contains('.json')) {
      return 'assets/json/$name';
    }
    return 'assets/svg/$name';
  }
}

// extension StringImagePathExt on String {
//   String withLocale({LocaleEnum? languageEnum}) {
//     LocaleEnum currentLocale;
//     if (languageEnum != null) {
//       currentLocale = languageEnum;
//     } else {
//       currentLocale = GlobalBloc.currentLocaleStatic;
//     }

//     if (currentLocale == LocaleEnum.en) {
//       return this;
//     }

//     if (contains('assets/${currentLocale.getLocale.languageCode}/')) {
//       return this;
//     }
//     return replaceFirst(
//         RegExp(r'/'), '/${currentLocale.getLocale.languageCode}/');
//   }
// }
