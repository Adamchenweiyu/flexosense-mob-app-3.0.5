import 'package:drift/drift.dart';

class ImuEntity extends Table {
  TextColumn get deviceAddress => text()();
  DateTimeColumn get time => dateTime()();

  IntColumn get accX => integer()();
  IntColumn get accY => integer()();
  IntColumn get accZ => integer()();

  IntColumn get gyrosX => integer()();
  IntColumn get gyrosY => integer()();
  IntColumn get gyrosZ => integer()();

  IntColumn get msgIndex => integer()();

  @override
  Set<Column> get primaryKey => {deviceAddress, time};
}
