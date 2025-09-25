import 'package:drift/drift.dart';
import 'package:flex_sense/application/util/logger.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/data/repository/imu_repo/imu_repo.dart';

class ImuRepoImpl extends ImuRepo {
  final AppDatabase appDatabase;
  ImuRepoImpl(this.appDatabase);

  // ─────────────────────────────────────────────────────────────────────────
  // Query helpers
  // ─────────────────────────────────────────────────────────────────────────
  @override
  MultiSelectable<ImuEntityData> get({
    String? deviceAddress,
    DateTime? fromTime,
    DateTime? toTime,
  }) {
    final query = appDatabase.select(appDatabase.imuEntity);

    if (deviceAddress != null) {
      query.where((t) => t.deviceAddress.equals(deviceAddress));
    }
    if (fromTime != null) {
      query.where((t) => t.time.isBiggerThan(Variable(fromTime)));
    }
    if (toTime != null) {
      query.where((t) => t.time.isSmallerOrEqualValue(toTime));
    }
    return query;
  }

  @override
  MultiSelectable<ImuEntityData> getLatest({int limit = 1}) {
    final q = appDatabase.select(appDatabase.imuEntity)
      ..orderBy([(t) => OrderingTerm(expression: t.time, mode: OrderingMode.desc)])
      ..limit(limit);
    return q;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Inserts
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<void> insertImuData(ImuEntityData imuEntity) async {
    await appDatabase.into(appDatabase.imuEntity).insert(
          imuEntity,
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Future<void> insertImuDataList(List<ImuEntityData> list) async {
    await appDatabase.batch((batch) {
      batch.insertAll(
        appDatabase.imuEntity,
        list,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Deletes
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<void> deleteAll() async {
    try {
      await appDatabase.delete(appDatabase.imuEntity).go();
    } catch (e) {
      Log.e('Error deleting all IMU data: $e');
    }
  }

  @override
  Future<int> deleteUpTo(DateTime cutOff) async {
    try {
      final deleted = await (appDatabase.delete(appDatabase.imuEntity)
            ..where((t) => t.time.isSmallerOrEqualValue(cutOff)))
          .go();
      return deleted;
    } catch (e) {
      Log.e('Error deleting IMU data up to $cutOff: $e');
      rethrow;
    }
  }
}
