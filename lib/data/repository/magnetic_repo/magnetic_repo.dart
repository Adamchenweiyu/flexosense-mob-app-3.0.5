import 'package:drift/drift.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';

abstract class MagneticRepo {
  Future<void> insertMagneticData(MagneticEntityData data);
  Future<void> insertMagneticDataList(List<MagneticEntityData> list);

  MultiSelectable<MagneticEntityData> get({
    String? deviceAddress,
    DateTime? fromTime,
    DateTime? toTime,
  });

  MultiSelectable<MagneticEntityData> getLatest({int limit = 1});

  Future<void> deleteAll();

  /// Deletes rows whose `time` ≤ [cutOff]; returns rows removed.
  Future<int> deleteUpTo(DateTime cutOff);
}
