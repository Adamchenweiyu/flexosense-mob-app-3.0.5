import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:flex_sense/data/data_source/local/drift/entities/battery_info_entity.dart';
import 'package:flex_sense/data/data_source/local/drift/entities/device_info_entity.dart';
import 'package:flex_sense/data/data_source/local/drift/entities/error_code_entity.dart';
import 'package:flex_sense/data/data_source/local/drift/entities/imu_entity.dart';
import 'package:flex_sense/data/data_source/local/drift/entities/magnetic_entity.dart';
import 'package:flex_sense/data/data_source/local/drift/entities/pressure_entity.dart';
import 'package:flex_sense/data/data_source/local/drift/entities/timestamp_entity.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  ImuEntity,
  BatteryInfoEntity,
  DeviceInfoEntity,
  ErrorCodeEntity,
  MagneticEntity,
  TimestampEntity,
  PressureEntity,
])

class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(createDriftIsolateAndConnect().executor);

  static const databasePortName = 'database_isolate_port';

  static void removeIsolate() {
    IsolateNameServer.removePortNameMapping(databasePortName);
  }

  @override
  int get schemaVersion => 1;
}

DatabaseConnection createDriftIsolateAndConnect() {
  final dbPort = IsolateNameServer.lookupPortByName(AppDatabase.databasePortName);

  return DatabaseConnection.delayed(Future.sync(() async {
    final isolate = await _createDriftIsolate();
    return DriftIsolate.fromConnectPort(dbPort ?? isolate).connect(singleClientMode: true);
  }));
}

Future<SendPort> _createDriftIsolate() async {
  // this method is called from the main isolate. Since we can't use
  // getApplicationDocumentsDirectory on a background isolate, we calculate
  // the database path in the foreground isolate and then inform the
  // background isolate about the path.
  final dir = await getApplicationSupportDirectory();
  final path = p.join(dir.path, 'flexo_sense.sqlite');
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );

  // _startBackground will send the DriftIsolate to this ReceivePort
  return await receivePort.first as SendPort;
}

void _startBackground(_IsolateStartRequest request) {
  // this is the entry point from the background isolate! Let's create
  // the database from the path we received
  final executor = NativeDatabase(File(request.targetPath));
  // we're using DriftIsolate.inCurrent here as this method already runs on a
  // background isolate. If we used DriftIsolate.spawn, a third isolate would be
  // started which is not what we want!
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection(executor),
  );

  IsolateNameServer.registerPortWithName(driftIsolate.connectPort, AppDatabase.databasePortName);
  // inform the starting isolate about this, so that it can call .connect()
  request.sendDriftIsolate.send(driftIsolate.connectPort);
}

// used to bundle the SendPort and the target path, since isolate entry point
// functions can only take one parameter.
class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}
