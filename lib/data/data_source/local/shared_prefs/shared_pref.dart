import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final _lastSyncedImuTime = '_lastSyncedImuTime';
  final _lastSyncedMagneticTime = '_lastSyncedMagneticTime';
  final _lastSyncedPressureTime = '_lastSyncedPressureTime';

  Future<void> setLastSyncedImuTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastSyncedImuTime, time.toIso8601String());
  }

  Future<DateTime?> getSyncedImuTime() async {
    final prefs = await SharedPreferences.getInstance();
    final time = prefs.getString(_lastSyncedImuTime);
    return time != null ? DateTime.parse(time) : null;
  }

  Future<void> setLastSyncedMagneticTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastSyncedMagneticTime, time.toIso8601String());
  }

  Future<DateTime?> getLastSyncedMagneticTime() async {
    final prefs = await SharedPreferences.getInstance();
    final time = prefs.getString(_lastSyncedMagneticTime);
    return time != null ? DateTime.parse(time) : null;
  }

  Future<void> setLastSyncedPressureTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastSyncedPressureTime, time.toIso8601String());
  }

  Future<DateTime?> getLastSyncedPressureTime() async {
    final prefs = await SharedPreferences.getInstance();
    final time = prefs.getString(_lastSyncedPressureTime);
    return time != null ? DateTime.parse(time) : null;
  }
}
