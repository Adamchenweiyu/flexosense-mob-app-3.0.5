import 'dart:async';
import 'dart:io';

import 'package:flex_sense/application/util/csv_utils.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flex_sense/data/data_source/local/shared_prefs/shared_pref.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/repository/imu_repo/imu_repo.dart';
import 'package:flex_sense/data/repository/magnetic_repo/magnetic_repo.dart';
import 'package:flex_sense/data/repository/pressure_repo/pressure_repo.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/data/service/database_queue_service.dart';
import 'package:flex_sense/domain/use_case/upload/upload_data.dart';
import 'package:media_store_plus/media_store_plus.dart';

class UpdateDataHandler {
  Timer? _timer;
  static const Duration _syncDuration = Duration(seconds: 30);

  void startSyncingData() {
    print('=== startSyncingData called ===');
    _timer?.cancel();
    print('Previous timer cancelled');

    // Test database connection first
    // _testDatabaseConnection();

    _timer = Timer.periodic(_syncDuration, (Timer timer) {
      print('=== Timer triggered - starting sync cycle ===');
      syncImuData();
      syncMagneticData();
      syncPressureData();
      print('=== Sync cycle completed ===');
    });
    print('Timer started with duration: $_syncDuration');
    print('Next sync will be in 30 seconds');
  }

  Future<void> _testDatabaseConnection() async {
    try {
      print('🔧 Testing database connection...');

      // Force delete old database to recreate with correct schema
      await _deleteDatabase();

      // Check if database file exists
      try {
        final dir = await getApplicationSupportDirectory();
        final dbPath = p.join(dir.path, 'flexo_sense.sqlite');
        final dbFile = File(dbPath);

        if (await dbFile.exists()) {
          final size = await dbFile.length();
          print('📁 Database file exists: $dbPath (${size} bytes)');

          // If database is corrupted (very small size), delete it
          if (size < 1000) {
            print('⚠️ Database file seems corrupted (too small), deleting...');
            await dbFile.delete();
            print('🗑️ Database file deleted, will be recreated');
          }
        } else {
          print('❌ Database file does not exist: $dbPath');
        }
      } catch (e) {
        print('❌ Error checking database file: $e');
      }

      // Test with timeout to prevent hanging
      final db = serviceLocator.get<AppDatabase>();

      print('⏱️ Testing IMU table access...');
      final result = await db.select(db.imuEntity).get().timeout(
        Duration(seconds: 5),
        onTimeout: () {
          print('⏰ IMU table query timed out');
          throw TimeoutException(
              'IMU table query timed out', Duration(seconds: 5));
        },
      );
      print(
          '✅ Database connection successful - found ${result.length} IMU records');

      print('⏱️ Testing Magnetic table access...');
      final magneticResult = await db.select(db.magneticEntity).get().timeout(
        Duration(seconds: 5),
        onTimeout: () {
          print('⏰ Magnetic table query timed out');
          throw TimeoutException(
              'Magnetic table query timed out', Duration(seconds: 5));
        },
      );
      print(
          '✅ Magnetic table accessible - found ${magneticResult.length} records');

      print('⏱️ Testing Pressure table access...');
      final pressureResult = await db.select(db.pressureEntity).get().timeout(
        Duration(seconds: 5),
        onTimeout: () {
          print('⏰ Pressure table query timed out');
          throw TimeoutException(
              'Pressure table query timed out', Duration(seconds: 5));
        },
      );
      print(
          '✅ Pressure table accessible - found ${pressureResult.length} records');
    } catch (e) {
      print('❌ Database connection test failed: $e');
      print('Stack trace: ${StackTrace.current}');
    }
  }

  Future<void> syncImuData() async {
    try {
      print('=== Starting IMU sync ===');
      final lastDataTime =
          await serviceLocator.get<SharedPref>().getSyncedImuTime();
      print('Last IMU sync time: $lastDataTime');

      // First time sync data
      if (lastDataTime == null) {
        print('First time sync - setting initial time');
        await serviceLocator
            .get<SharedPref>()
            .setLastSyncedImuTime(DateTime.now());
        return;
      }

      // Check if now is after last time 30s
      if (DateTime.now().difference(lastDataTime) >= _syncDuration) {
        List<ImuEntityData> data;
        try {
          // Now try the repository query
          data = await serviceLocator
              .get<ImuRepo>()
              .get(fromTime: lastDataTime)
              .get()
              .timeout(
            Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException(
                  'IMU database query timed out', Duration(seconds: 10));
            },
          );
        } catch (e) {
          print('Error querying IMU database: $e');
          return;
        }

        if (data.isEmpty) {
          return;
        }

        final imuCsvFile = await CsvUtils.convertImuToCsv(data);

        await serviceLocator.get<UploadData>().call(imuCsvFile);

        await saveCsvFileToDownloads(imuCsvFile);

        final lastSyncedDataTime = data.last.time;

        // Queue deletion of uploaded data
        serviceLocator
            .get<DatabaseQueueService>()
            .queueDeleteImuUpTo(lastSyncedDataTime);

        await serviceLocator
            .get<SharedPref>()
            .setLastSyncedImuTime(lastSyncedDataTime);
        print('Updated last sync time to: $lastSyncedDataTime');
      } else {
        print(
            'Not yet time to sync IMU data. Next sync in: ${_syncDuration - DateTime.now().difference(lastDataTime)}');
      }
    } catch (e) {
      print('IMU sync error: $e');
      print('Stack trace: ${StackTrace.current}');
    }
  }

  Future<void> syncMagneticData() async {
    try {
      print('=== Starting Magnetic sync ===');
      final lastDataTime =
          await serviceLocator.get<SharedPref>().getLastSyncedMagneticTime();
      print('Last Magnetic sync time: $lastDataTime');

      // First time sync data
      if (lastDataTime == null) {
        print('First time sync - setting initial time');
        await serviceLocator
            .get<SharedPref>()
            .setLastSyncedMagneticTime(DateTime.now());
        return;
      }

      // Check if now is after last time 30s
      if (DateTime.now().difference(lastDataTime) >= _syncDuration) {
        List<MagneticEntityData> data;
        try {
          data = await serviceLocator
              .get<MagneticRepo>()
              .get(fromTime: lastDataTime)
              .get()
              .timeout(
            Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException(
                  'Magnetic database query timed out', Duration(seconds: 10));
            },
          );
        } catch (e) {
          print('Error querying Magnetic database: $e');
          return;
        }

        if (data.isEmpty) {
          return;
        }

        final magneticCsvFile = await CsvUtils.convertMagneticToCsv(data);

        await serviceLocator.get<UploadData>().call(magneticCsvFile);

        await saveCsvFileToDownloads(magneticCsvFile);

        final lastSyncedDataTime = data.last.time;

        // Queue deletion of uploaded data
        serviceLocator
            .get<DatabaseQueueService>()
            .queueDeleteMagneticUpTo(lastSyncedDataTime);

        await serviceLocator
            .get<SharedPref>()
            .setLastSyncedMagneticTime(lastSyncedDataTime);
        print('Updated last sync time to: $lastSyncedDataTime');
      } else {
        print(
            'Not yet time to sync Magnetic data. Next sync in: ${_syncDuration - DateTime.now().difference(lastDataTime)}');
      }
    } catch (e) {
      print('Magnetic sync error: $e');
      print('Stack trace: ${StackTrace.current}');
    }
  }

  Future<void> syncPressureData() async {
    try {
      final lastDataTime =
          await serviceLocator.get<SharedPref>().getLastSyncedPressureTime();

      // First time sync data
      if (lastDataTime == null) {
        await serviceLocator
            .get<SharedPref>()
            .setLastSyncedPressureTime(DateTime.now());
        return;
      }

      // Check if now is after last time 30s
      if (DateTime.now().difference(lastDataTime) >= _syncDuration) {
        List<PressureEntityData> data;
        try {
          data = await serviceLocator
              .get<PressureRepo>()
              .get(fromTime: lastDataTime)
              .get()
              .timeout(
            Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException(
                  'Pressure database query timed out', Duration(seconds: 10));
            },
          );
        } catch (e) {
          print('Error querying Pressure database: $e');
          return;
        }

        if (data.isEmpty) {
          return;
        }

        final pressureCsvFile = await CsvUtils.convertPressureToCsv(data);

        await serviceLocator.get<UploadData>().call(pressureCsvFile);

        await saveCsvFileToDownloads(pressureCsvFile);

        final lastSyncedDataTime = data.last.time;

        // Queue deletion of uploaded data
        serviceLocator
            .get<DatabaseQueueService>()
            .queueDeletePressureUpTo(lastSyncedDataTime);

        await serviceLocator
            .get<SharedPref>()
            .setLastSyncedPressureTime(lastSyncedDataTime);
        print('Updated last sync time to: $lastSyncedDataTime');
      } else {
        print(
            'Not yet time to sync Pressure data. Next sync in: ${_syncDuration - DateTime.now().difference(lastDataTime)}');
      }
    } catch (e) {
      print('Pressure sync error: $e');
      print('Stack trace: ${StackTrace.current}');
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

  Future<void> _deleteDatabase() async {
    try {
      print('🗑️ Deleting old database file...');
      final dir = await getApplicationSupportDirectory();
      final dbPath = p.join(dir.path, 'flexo_sense.sqlite');
      final dbFile = File(dbPath);

      if (await dbFile.exists()) {
        await dbFile.delete();
        print('✅ Database file deleted successfully');
      } else {
        print('ℹ️ Database file does not exist, nothing to delete');
      }
    } catch (e) {
      print('❌ Error deleting database file: $e');
    }
  }
}
