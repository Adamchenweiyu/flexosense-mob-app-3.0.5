import 'package:drift/drift.dart';
import 'package:flex_sense/application/util/logger.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/data/repository/pressure_repo/pressure_repo.dart';

class PressureRepoImpl extends PressureRepo {
  final AppDatabase db;
  PressureRepoImpl(this.db);

  // ── Queries ────────────────────────────────────────────────────────────
  @override
  MultiSelectable<PressureEntityData> get({
    String? deviceAddress,
    DateTime? fromTime,
    DateTime? toTime,
  }) {
    final q = db.select(db.pressureEntity);
    if (deviceAddress != null) q.where((t) => t.deviceAddress.equals(deviceAddress));
    if (fromTime != null) q.where((t) => t.time.isBiggerThanValue(fromTime));
    if (toTime != null) q.where((t) => t.time.isSmallerOrEqualValue(toTime));
    return q;
  }

  @override
  MultiSelectable<PressureEntityData> getLatest({int limit = 1}) => (db.select(db.pressureEntity)
    ..orderBy([(t) => OrderingTerm(expression: t.time, mode: OrderingMode.desc)])
    ..limit(limit));

  // ── Inserts ────────────────────────────────────────────────────────────
  @override
  Future<void> insertPressureData(PressureEntityData data) async =>
      db.into(db.pressureEntity).insert(data, mode: InsertMode.insertOrReplace);

  @override
  Future<void> insertPressureDataList(List<PressureEntityData> list) async =>
      db.batch((b) => b.insertAll(
            db.pressureEntity,
            list,
            mode: InsertMode.insertOrReplace,
          ));

  // ── Deletes ────────────────────────────────────────────────────────────
  @override
  Future<void> deleteAll() async {
    try {
      await db.delete(db.pressureEntity).go();
    } catch (e) {
      Log.e('pressure deleteAll error: $e');
    }
  }

  @override
  Future<int> deleteUpTo(DateTime cutOff) async {
    try {
      return (db.delete(db.pressureEntity)..where((t) => t.time.isSmallerOrEqualValue(cutOff)))
          .go();
    } catch (e) {
      Log.e('pressure deleteUpTo error: $e');
      rethrow;
    }
  }
}
