import 'package:package_info_plus/package_info_plus.dart';

class AppVersionUtils {
  static String? _appVersion;
  static String? _buildNumber;

  static Future<void> initialize() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
  }

  static String getAppVersion() {
    if (_appVersion == null) {
      return 'Unknown';
    }
    return '$_appVersion+$_buildNumber';
  }

  static String getVersionOnly() {
    return _appVersion ?? 'Unknown';
  }

  static String getBuildNumber() {
    return _buildNumber ?? 'Unknown';
  }
} 