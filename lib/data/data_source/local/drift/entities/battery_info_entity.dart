import 'package:drift/drift.dart';

class BatteryInfoEntity extends Table {
  DateTimeColumn get time => dateTime()();
  IntColumn get level => integer()();
  BoolColumn get isCharging => boolean()();
  RealColumn get voltage => real()();

  TextColumn get deviceAddress => text()();

  @override
  Set<Column> get primaryKey => {time};
}