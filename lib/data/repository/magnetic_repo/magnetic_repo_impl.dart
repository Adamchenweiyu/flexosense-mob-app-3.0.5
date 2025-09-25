import 'package:drift/drift.dart';
import 'package:flex_sense/application/util/logger.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/data/repository/magnetic_repo/magnetic_repo.dart';

class MagneticRepoImpl extends MagneticRepo {
  final AppDatabase db;
  MagneticRepoImpl(this.db);

  // ── Queries ────────────────────────────────────────────────────────────
  @override
  MultiSelectable<MagneticEntityData> get({
    String? deviceAddress,
    DateTime? fromTime,
    DateTime? toTime,
  }) {
    final q = db.select(db.magneticEntity);
    if (deviceAddress != null) q.where((t) => t.deviceAddress.equals(deviceAddress));
    if (fromTime != null) q.where((t) => t.time.isBiggerThanValue(fromTime));
    if (toTime != null) q.where((t) => t.time.isSmallerOrEqualValue(toTime));
    return q;
  }

  @override
  MultiSelectable<MagneticEntityData> getLatest({int limit = 1}) => (db.select(db.magneticEntity)
    ..orderBy([(t) => OrderingTerm(expression: t.time, mode: OrderingMode.desc)])
    ..limit(limit));

  // ── Inserts ────────────────────────────────────────────────────────────
  @override
  Future<void> insertMagneticData(MagneticEntityData data) async =>
      db.into(db.magneticEntity).insert(data, mode: InsertMode.insertOrReplace);

  @override
  Future<void> insertMagneticDataList(List<MagneticEntityData> list) async =>
      db.batch((b) => b.insertAll(
            db.magneticEntity,
            list,
            mode: InsertMode.insertOrReplace,
          ));

  // ── Deletes ────────────────────────────────────────────────────────────
  @override
  Future<void> deleteAll() async {
    try {
      await db.delete(db.magneticEntity).go();
    } catch (e) {
      Log.e('magnetic deleteAll error: $e');
    }
  }

  @override
  Future<int> deleteUpTo(DateTime cutOff) async {
    try {
      return (db.delete(db.magneticEntity)..where((t) => t.time.isSmallerOrEqualValue(cutOff)))
          .go();
    } catch (e) {
      Log.e('magnetic deleteUpTo error: $e');
      rethrow;
    }
  }
}
