import 'package:drift/drift.dart';

class DeviceInfoEntity extends Table {
  DateTimeColumn get time => dateTime()();
  TextColumn get deviceName => text()();
  TextColumn get deviceAddress => text()();
  TextColumn get hwVersion => text()();
  TextColumn get fwVersion => text()();

  @override
  Set<Column> get primaryKey => {time};
}