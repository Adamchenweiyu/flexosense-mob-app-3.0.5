import 'dart:async';
import 'dart:io';

import 'package:flex_sense/application/util/csv_utils.dart';
import 'package:flex_sense/data/data_source/local/shared_prefs/shared_pref.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/repository/imu_repo/imu_repo.dart';
import 'package:flex_sense/data/repository/magnetic_repo/magnetic_repo.dart';
import 'package:flex_sense/data/repository/pressure_repo/pressure_repo.dart';
import 'package:flex_sense/domain/use_case/upload/upload_data.dart';
import 'package:media_store_plus/media_store_plus.dart';

class UpdateDataHandler {
  Timer? _timer;
  static const Duration _syncDuration = Duration(seconds: 30);

  void startSyncingData() {
    _timer?.cancel();
    _timer = Timer.periodic(_syncDuration, (Timer timer) {
      syncImuData();
      syncMagneticData();
      syncPressureData();
    });
    print('started syncing ');
  }

  Future<void> syncImuData() async {
    try {
      final lastDataTime = await serviceLocator.get<SharedPref>().getSyncedImuTime();

      // First time sync data
      if (lastDataTime == null) {
        await serviceLocator.get<SharedPref>().setLastSyncedImuTime(DateTime.now());
        return;
      }

      // Check if now is after last time 30s
      if (DateTime.now().difference(lastDataTime) >= _syncDuration) {
        final data = await serviceLocator.get<ImuRepo>().get(fromTime: lastDataTime).get();
        if (data.isEmpty) return;

        final imuCsvFile = await CsvUtils.convertImuToCsv(data);
        await serviceLocator.get<UploadData>().call(imuCsvFile);
        print('Uploaded imu data');

        final saved = await saveCsvFileToDownloads(imuCsvFile);
        print('Saved local copy → ${saved?.uri}');

        final lastSyncedDataTime = data.last.time;

        final rowsRemoved = await serviceLocator.get<ImuRepo>().deleteUpTo(lastSyncedDataTime);
        print('Purged $rowsRemoved uploaded IMU rows');
        await serviceLocator.get<SharedPref>().setLastSyncedImuTime(lastSyncedDataTime);
      }
    } catch (e) {
      print('imu: $e');
    }
  }

  Future<void> syncMagneticData() async {
    try {
      final lastDataTime = await serviceLocator.get<SharedPref>().getLastSyncedMagneticTime();

      // First time sync data
      if (lastDataTime == null) {
        await serviceLocator.get<SharedPref>().setLastSyncedMagneticTime(DateTime.now());
        return;
      }

      // Check if now is after last time 30s
      if (DateTime.now().difference(lastDataTime) >= _syncDuration) {
        final data = await serviceLocator.get<MagneticRepo>().get(fromTime: lastDataTime).get();
        if (data.isEmpty) return;

        final magneticCsvFile = await CsvUtils.convertMagneticToCsv(data);
        await serviceLocator.get<UploadData>().call(magneticCsvFile);
        print('Uploaded magnetic data');

        final saved = await saveCsvFileToDownloads(magneticCsvFile);
        print('Saved local copy → ${saved?.uri}');

        final lastSyncedDataTime = data.last.time;

        final rowsRemoved = await serviceLocator.get<MagneticRepo>().deleteUpTo(lastSyncedDataTime);
        print('Purged $rowsRemoved uploaded Magnetic rows');
        await serviceLocator.get<SharedPref>().setLastSyncedMagneticTime(lastSyncedDataTime);
      }
    } catch (e) {
      print('magnetic: $e');
    }
  }

  Future<void> syncPressureData() async {
    try {
      final lastDataTime = await serviceLocator.get<SharedPref>().getLastSyncedPressureTime();

      // First time sync data
      if (lastDataTime == null) {
        await serviceLocator.get<SharedPref>().setLastSyncedPressureTime(DateTime.now());
        return;
      }

      // Check if now is after last time 30s
      if (DateTime.now().difference(lastDataTime) >= _syncDuration) {
        final data = await serviceLocator.get<PressureRepo>().get(fromTime: lastDataTime).get();
        if (data.isEmpty) return;

        final pressureCsvFile = await CsvUtils.convertPressureToCsv(data);
        await serviceLocator.get<UploadData>().call(pressureCsvFile);
        print('Uploaded pressure data');

        final saved = await saveCsvFileToDownloads(pressureCsvFile);
        print('Saved local copy → ${saved?.uri}');

        final lastSyncedDataTime = data.last.time;

        final rowsRemoved = await serviceLocator.get<PressureRepo>().deleteUpTo(lastSyncedDataTime);
        print('Purged $rowsRemoved uploaded Pressure rows');
        await serviceLocator.get<SharedPref>().setLastSyncedPressureTime(lastSyncedDataTime);
      }
    } catch (e) {
      print('pressure: $e');
    }
  }

  /// Copies [csvFile] into /storage/emulated/0/Download/[…].
  /// Returns the plugin’s `SaveInfo` (content-URI + absolute path).
  Future<SaveInfo?> saveCsvFileToDownloads(
    File csvFile, {
    String subFolder = "FlexoSense", // e.g. 'FlexSense' → /Download/FlexSense
  }) async {
    final media = MediaStore();

    return media.saveFile(
      tempFilePath: csvFile.path, // plugin copies & then deletes temp file
      dirType: DirType.download, // public/shared storage
      dirName: DirName.download, // root “Download” collection
      relativePath: subFolder, // null = root of Download
    );
  }
}
