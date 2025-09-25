import 'package:drift/drift.dart';

class TimestampEntity extends Table {
  DateTimeColumn get time => dateTime()();

  DateTimeColumn get timeValue => dateTime()();

  TextColumn get deviceAddress => text()();

  @override
  Set<Column> get primaryKey => {time};
}