import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @noDevice.
  ///
  /// In en, this message translates to:
  /// **'No device'**
  String get noDevice;

  /// No description provided for @connectYourDeviceToStart.
  ///
  /// In en, this message translates to:
  /// **'Connect your devices to start monitoring your health'**
  String get connectYourDeviceToStart;

  /// No description provided for @addDevice.
  ///
  /// In en, this message translates to:
  /// **'Add device'**
  String get addDevice;

  /// No description provided for @flexoWouldLikeToAccessBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Flexo would like to access Bluetooth.'**
  String get flexoWouldLikeToAccessBluetooth;

  /// No description provided for @toConnectToDeviceWeNeed.
  ///
  /// In en, this message translates to:
  /// **'To connect to device, we need permission to access Bluetooth.'**
  String get toConnectToDeviceWeNeed;

  /// No description provided for @flexoWouldLikeToAccessLocation.
  ///
  /// In en, this message translates to:
  /// **'Flexo would like to access Location.'**
  String get flexoWouldLikeToAccessLocation;

  /// No description provided for @toConnectToDeviceWeNeedLocation.
  ///
  /// In en, this message translates to:
  /// **'To connect to device, we need permission to access Location.'**
  String get toConnectToDeviceWeNeedLocation;

  /// No description provided for @goToSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to settings'**
  String get goToSettings;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @scanningYourDevice.
  ///
  /// In en, this message translates to:
  /// **'Scanning your device'**
  String get scanningYourDevice;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnect;

  /// No description provided for @connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get connecting;

  /// No description provided for @scanningYourDevices.
  ///
  /// In en, this message translates to:
  /// **'Scanning your devices ...'**
  String get scanningYourDevices;

  /// No description provided for @yourDeviceIsBeingConnected.
  ///
  /// In en, this message translates to:
  /// **'Your device is being connected'**
  String get yourDeviceIsBeingConnected;

  /// No description provided for @failedToConnect.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect'**
  String get failedToConnect;

  /// No description provided for @makeSureDeviceIsTurnedOn.
  ///
  /// In en, this message translates to:
  /// **'Make sure device is turned on and in range'**
  String get makeSureDeviceIsTurnedOn;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @successfullyConnected.
  ///
  /// In en, this message translates to:
  /// **'Successfully connected'**
  String get successfullyConnected;

  /// No description provided for @yourDeviceHasBeenConnected.
  ///
  /// In en, this message translates to:
  /// **'Your device has been connected'**
  String get yourDeviceHasBeenConnected;

  /// No description provided for @unknownDevice.
  ///
  /// In en, this message translates to:
  /// **'Unknown device'**
  String get unknownDevice;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @stopScan.
  ///
  /// In en, this message translates to:
  /// **'Stop scan'**
  String get stopScan;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @hwVersion.
  ///
  /// In en, this message translates to:
  /// **'HW version'**
  String get hwVersion;

  /// No description provided for @fwVersion.
  ///
  /// In en, this message translates to:
  /// **'FW version'**
  String get fwVersion;

  /// No description provided for @deviceDetail.
  ///
  /// In en, this message translates to:
  /// **'Device detail'**
  String get deviceDetail;

  /// No description provided for @deviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device info'**
  String get deviceInfo;

  /// No description provided for @getDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Get Device Info'**
  String get getDeviceInfo;

  /// No description provided for @setStartStopStudy.
  ///
  /// In en, this message translates to:
  /// **'Set Start Stop Study'**
  String get setStartStopStudy;

  /// No description provided for @setTimeStamp.
  ///
  /// In en, this message translates to:
  /// **'Set Timestamp'**
  String get setTimeStamp;

  /// No description provided for @getTimeStamp.
  ///
  /// In en, this message translates to:
  /// **'Get Timestamp'**
  String get getTimeStamp;

  /// No description provided for @getErrorCode.
  ///
  /// In en, this message translates to:
  /// **'Get Error Code'**
  String get getErrorCode;

  /// No description provided for @getBatteryInfo.
  ///
  /// In en, this message translates to:
  /// **'Get Battery Info'**
  String get getBatteryInfo;

  /// No description provided for @deviceName.
  ///
  /// In en, this message translates to:
  /// **'Device name'**
  String get deviceName;

  /// No description provided for @deviceAddress.
  ///
  /// In en, this message translates to:
  /// **'Device address'**
  String get deviceAddress;

  /// No description provided for @errorCode.
  ///
  /// In en, this message translates to:
  /// **'Error code'**
  String get errorCode;

  /// No description provided for @imuSensor.
  ///
  /// In en, this message translates to:
  /// **'IMU sensor'**
  String get imuSensor;

  /// No description provided for @magSensor.
  ///
  /// In en, this message translates to:
  /// **'Mag sensor'**
  String get magSensor;

  /// No description provided for @batteryMonitor.
  ///
  /// In en, this message translates to:
  /// **'Battery monitor'**
  String get batteryMonitor;

  /// No description provided for @pressureSensor.
  ///
  /// In en, this message translates to:
  /// **'Pressure sensor'**
  String get pressureSensor;

  /// No description provided for @wrongSide.
  ///
  /// In en, this message translates to:
  /// **'Wrong side'**
  String get wrongSide;

  /// No description provided for @timestamp.
  ///
  /// In en, this message translates to:
  /// **'Timestamp'**
  String get timestamp;

  /// No description provided for @batteryInfo.
  ///
  /// In en, this message translates to:
  /// **'Battery Info'**
  String get batteryInfo;

  /// No description provided for @isCharging.
  ///
  /// In en, this message translates to:
  /// **'Is charging'**
  String get isCharging;

  /// No description provided for @batteryLevel.
  ///
  /// In en, this message translates to:
  /// **'Battery level'**
  String get batteryLevel;

  /// No description provided for @voltage.
  ///
  /// In en, this message translates to:
  /// **'Voltage'**
  String get voltage;

  /// No description provided for @liveAccelData.
  ///
  /// In en, this message translates to:
  /// **'Live Accel data'**
  String get liveAccelData;

  /// No description provided for @liveGyrosData.
  ///
  /// In en, this message translates to:
  /// **'Live Gyros data'**
  String get liveGyrosData;

  /// No description provided for @liveRawPitchYawData.
  ///
  /// In en, this message translates to:
  /// **'Live Raw, Pitch, Yaw data'**
  String get liveRawPitchYawData;

  /// No description provided for @liveMagneticData.
  ///
  /// In en, this message translates to:
  /// **'Live Magnetic data'**
  String get liveMagneticData;

  /// No description provided for @livePressureData.
  ///
  /// In en, this message translates to:
  /// **'Live Pressure data'**
  String get livePressureData;

  /// No description provided for @viewStoredData.
  ///
  /// In en, this message translates to:
  /// **'View stored data'**
  String get viewStoredData;

  /// No description provided for @viewStoredAccel.
  ///
  /// In en, this message translates to:
  /// **'View stored Accel'**
  String get viewStoredAccel;

  /// No description provided for @viewStoredGyros.
  ///
  /// In en, this message translates to:
  /// **'View stored Gyros'**
  String get viewStoredGyros;

  /// No description provided for @viewStoredRollPitchYaw.
  ///
  /// In en, this message translates to:
  /// **'View stored Roll Pitch Yaw'**
  String get viewStoredRollPitchYaw;

  /// No description provided for @viewStoredMagnetic.
  ///
  /// In en, this message translates to:
  /// **'View stored Magnetic'**
  String get viewStoredMagnetic;

  /// No description provided for @viewStoredPressure.
  ///
  /// In en, this message translates to:
  /// **'View stored Pressure'**
  String get viewStoredPressure;

  /// No description provided for @pair.
  ///
  /// In en, this message translates to:
  /// **'Pair'**
  String get pair;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
