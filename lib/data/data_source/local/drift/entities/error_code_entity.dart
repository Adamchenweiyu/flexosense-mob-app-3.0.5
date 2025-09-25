import 'package:drift/drift.dart';

class ErrorCodeEntity extends Table {
  DateTimeColumn get time => dateTime()();
  IntColumn get imuSensor => integer()();
  IntColumn get magSensor => integer()();
  IntColumn get batteryMonitor => integer()();
  IntColumn get pressureSensor => integer()();

  TextColumn get deviceAddress => text()();

  @override
  Set<Column> get primaryKey => {time};
}