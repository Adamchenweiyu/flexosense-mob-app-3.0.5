import 'package:drift/drift.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';

abstract class ImuRepo {
  Future<void> insertImuData(ImuEntityData imuEntity);
  Future<void> insertImuDataList(List<ImuEntityData> imuEntityList);

  /// Returns every row that matches the optional filters.
  MultiSelectable<ImuEntityData> get({
    String? deviceAddress,
    DateTime? fromTime,
    DateTime? toTime,
  });

  /// Latest [limit] rows ordered by descending `time`.
  MultiSelectable<ImuEntityData> getLatest({int limit = 1});

  /// Deletes **all** IMU rows.
  Future<void> deleteAll();

  /// Deletes rows whose `time` ≤ [cutOff].
  /// Returns the number of rows removed.
  Future<int> deleteUpTo(DateTime cutOff);
}
