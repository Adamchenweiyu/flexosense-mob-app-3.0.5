import 'package:drift/drift.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';

abstract class PressureRepo {
  Future<void> insertPressureData(PressureEntityData data);
  Future<void> insertPressureDataList(List<PressureEntityData> list);

  MultiSelectable<PressureEntityData> get({
    String? deviceAddress,
    DateTime? fromTime,
    DateTime? toTime,
  });

  MultiSelectable<PressureEntityData> getLatest({int limit = 1});

  Future<void> deleteAll();

  /// Deletes rows whose `time` ≤ [cutOff]; returns rows removed.
  Future<int> deleteUpTo(DateTime cutOff);
}
