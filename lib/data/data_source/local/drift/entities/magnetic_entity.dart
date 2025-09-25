import 'package:drift/drift.dart';

class MagneticEntity extends Table {
  DateTimeColumn get time => dateTime()();
  IntColumn get x => integer()();
  IntColumn get y => integer()();
  IntColumn get z => integer()();

  TextColumn get deviceAddress => text()();

  IntColumn get msgIndex => integer()();

  @override
  Set<Column> get primaryKey => {deviceAddress, time};
}