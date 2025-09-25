import 'package:drift/drift.dart';

class PressureEntity extends Table {
  DateTimeColumn get time => dateTime()();
  TextColumn get deviceAddress => text()();
  TextColumn get voltages => text()();

  @override
  Set<Column> get primaryKey => {time};
}
