// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ImuEntityTable extends ImuEntity
    with TableInfo<$ImuEntityTable, ImuEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImuEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _deviceAddressMeta =
      const VerificationMeta('deviceAddress');
  @override
  late final GeneratedColumn<String> deviceAddress = GeneratedColumn<String>(
      'device_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _accXMeta = const VerificationMeta('accX');
  @override
  late final GeneratedColumn<int> accX = GeneratedColumn<int>(
      'acc_x', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _accYMeta = const VerificationMeta('accY');
  @override
  late final GeneratedColumn<int> accY = GeneratedColumn<int>(
      'acc_y', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _accZMeta = const VerificationMeta('accZ');
  @override
  late final GeneratedColumn<int> accZ = GeneratedColumn<int>(
      'acc_z', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _gyrosXMeta = const VerificationMeta('gyrosX');
  @override
  late final GeneratedColumn<int> gyrosX = GeneratedColumn<int>(
      'gyros_x', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _gyrosYMeta = const VerificationMeta('gyrosY');
  @override
  late final GeneratedColumn<int> gyrosY = GeneratedColumn<int>(
      'gyros_y', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _gyrosZMeta = const VerificationMeta('gyrosZ');
  @override
  late final GeneratedColumn<int> gyrosZ = GeneratedColumn<int>(
      'gyros_z', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _msgIndexMeta =
      const VerificationMeta('msgIndex');
  @override
  late final GeneratedColumn<int> msgIndex = GeneratedColumn<int>(
      'msg_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [deviceAddress, time, accX, accY, accZ, gyrosX, gyrosY, gyrosZ, msgIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'imu_entity';
  @override
  VerificationContext validateIntegrity(Insertable<ImuEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('device_address')) {
      context.handle(
          _deviceAddressMeta,
          deviceAddress.isAcceptableOrUnknown(
              data['device_address']!, _deviceAddressMeta));
    } else if (isInserting) {
      context.missing(_deviceAddressMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('acc_x')) {
      context.handle(
          _accXMeta, accX.isAcceptableOrUnknown(data['acc_x']!, _accXMeta));
    } else if (isInserting) {
      context.missing(_accXMeta);
    }
    if (data.containsKey('acc_y')) {
      context.handle(
          _accYMeta, accY.isAcceptableOrUnknown(data['acc_y']!, _accYMeta));
    } else if (isInserting) {
      context.missing(_accYMeta);
    }
    if (data.containsKey('acc_z')) {
      context.handle(
          _accZMeta, accZ.isAcceptableOrUnknown(data['acc_z']!, _accZMeta));
    } else if (isInserting) {
      context.missing(_accZMeta);
    }
    if (data.containsKey('gyros_x')) {
      context.handle(_gyrosXMeta,
          gyrosX.isAcceptableOrUnknown(data['gyros_x']!, _gyrosXMeta));
    } else if (isInserting) {
      context.missing(_gyrosXMeta);
    }
    if (data.containsKey('gyros_y')) {
      context.handle(_gyrosYMeta,
          gyrosY.isAcceptableOrUnknown(data['gyros_y']!, _gyrosYMeta));
    } else if (isInserting) {
      context.missing(_gyrosYMeta);
    }
    if (data.containsKey('gyros_z')) {
      context.handle(_gyrosZMeta,
          gyrosZ.isAcceptableOrUnknown(data['gyros_z']!, _gyrosZMeta));
    } else if (isInserting) {
      context.missing(_gyrosZMeta);
    }
    if (data.containsKey('msg_index')) {
      context.handle(_msgIndexMeta,
          msgIndex.isAcceptableOrUnknown(data['msg_index']!, _msgIndexMeta));
    } else if (isInserting) {
      context.missing(_msgIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deviceAddress, time};
  @override
  ImuEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImuEntityData(
      deviceAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_address'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      accX: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}acc_x'])!,
      accY: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}acc_y'])!,
      accZ: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}acc_z'])!,
      gyrosX: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gyros_x'])!,
      gyrosY: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gyros_y'])!,
      gyrosZ: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gyros_z'])!,
      msgIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}msg_index'])!,
    );
  }

  @override
  $ImuEntityTable createAlias(String alias) {
    return $ImuEntityTable(attachedDatabase, alias);
  }
}

class ImuEntityData extends DataClass implements Insertable<ImuEntityData> {
  final String deviceAddress;
  final DateTime time;
  final int accX;
  final int accY;
  final int accZ;
  final int gyrosX;
  final int gyrosY;
  final int gyrosZ;
  final int msgIndex;
  const ImuEntityData(
      {required this.deviceAddress,
      required this.time,
      required this.accX,
      required this.accY,
      required this.accZ,
      required this.gyrosX,
      required this.gyrosY,
      required this.gyrosZ,
      required this.msgIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['device_address'] = Variable<String>(deviceAddress);
    map['time'] = Variable<DateTime>(time);
    map['acc_x'] = Variable<int>(accX);
    map['acc_y'] = Variable<int>(accY);
    map['acc_z'] = Variable<int>(accZ);
    map['gyros_x'] = Variable<int>(gyrosX);
    map['gyros_y'] = Variable<int>(gyrosY);
    map['gyros_z'] = Variable<int>(gyrosZ);
    map['msg_index'] = Variable<int>(msgIndex);
    return map;
  }

  ImuEntityCompanion toCompanion(bool nullToAbsent) {
    return ImuEntityCompanion(
      deviceAddress: Value(deviceAddress),
      time: Value(time),
      accX: Value(accX),
      accY: Value(accY),
      accZ: Value(accZ),
      gyrosX: Value(gyrosX),
      gyrosY: Value(gyrosY),
      gyrosZ: Value(gyrosZ),
      msgIndex: Value(msgIndex),
    );
  }

  factory ImuEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImuEntityData(
      deviceAddress: serializer.fromJson<String>(json['deviceAddress']),
      time: serializer.fromJson<DateTime>(json['time']),
      accX: serializer.fromJson<int>(json['accX']),
      accY: serializer.fromJson<int>(json['accY']),
      accZ: serializer.fromJson<int>(json['accZ']),
      gyrosX: serializer.fromJson<int>(json['gyrosX']),
      gyrosY: serializer.fromJson<int>(json['gyrosY']),
      gyrosZ: serializer.fromJson<int>(json['gyrosZ']),
      msgIndex: serializer.fromJson<int>(json['msgIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deviceAddress': serializer.toJson<String>(deviceAddress),
      'time': serializer.toJson<DateTime>(time),
      'accX': serializer.toJson<int>(accX),
      'accY': serializer.toJson<int>(accY),
      'accZ': serializer.toJson<int>(accZ),
      'gyrosX': serializer.toJson<int>(gyrosX),
      'gyrosY': serializer.toJson<int>(gyrosY),
      'gyrosZ': serializer.toJson<int>(gyrosZ),
      'msgIndex': serializer.toJson<int>(msgIndex),
    };
  }

  ImuEntityData copyWith(
          {String? deviceAddress,
          DateTime? time,
          int? accX,
          int? accY,
          int? accZ,
          int? gyrosX,
          int? gyrosY,
          int? gyrosZ,
          int? msgIndex}) =>
      ImuEntityData(
        deviceAddress: deviceAddress ?? this.deviceAddress,
        time: time ?? this.time,
        accX: accX ?? this.accX,
        accY: accY ?? this.accY,
        accZ: accZ ?? this.accZ,
        gyrosX: gyrosX ?? this.gyrosX,
        gyrosY: gyrosY ?? this.gyrosY,
        gyrosZ: gyrosZ ?? this.gyrosZ,
        msgIndex: msgIndex ?? this.msgIndex,
      );
  ImuEntityData copyWithCompanion(ImuEntityCompanion data) {
    return ImuEntityData(
      deviceAddress: data.deviceAddress.present
          ? data.deviceAddress.value
          : this.deviceAddress,
      time: data.time.present ? data.time.value : this.time,
      accX: data.accX.present ? data.accX.value : this.accX,
      accY: data.accY.present ? data.accY.value : this.accY,
      accZ: data.accZ.present ? data.accZ.value : this.accZ,
      gyrosX: data.gyrosX.present ? data.gyrosX.value : this.gyrosX,
      gyrosY: data.gyrosY.present ? data.gyrosY.value : this.gyrosY,
      gyrosZ: data.gyrosZ.present ? data.gyrosZ.value : this.gyrosZ,
      msgIndex: data.msgIndex.present ? data.msgIndex.value : this.msgIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImuEntityData(')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('time: $time, ')
          ..write('accX: $accX, ')
          ..write('accY: $accY, ')
          ..write('accZ: $accZ, ')
          ..write('gyrosX: $gyrosX, ')
          ..write('gyrosY: $gyrosY, ')
          ..write('gyrosZ: $gyrosZ, ')
          ..write('msgIndex: $msgIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      deviceAddress, time, accX, accY, accZ, gyrosX, gyrosY, gyrosZ, msgIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImuEntityData &&
          other.deviceAddress == this.deviceAddress &&
          other.time == this.time &&
          other.accX == this.accX &&
          other.accY == this.accY &&
          other.accZ == this.accZ &&
          other.gyrosX == this.gyrosX &&
          other.gyrosY == this.gyrosY &&
          other.gyrosZ == this.gyrosZ &&
          other.msgIndex == this.msgIndex);
}

class ImuEntityCompanion extends UpdateCompanion<ImuEntityData> {
  final Value<String> deviceAddress;
  final Value<DateTime> time;
  final Value<int> accX;
  final Value<int> accY;
  final Value<int> accZ;
  final Value<int> gyrosX;
  final Value<int> gyrosY;
  final Value<int> gyrosZ;
  final Value<int> msgIndex;
  final Value<int> rowid;
  const ImuEntityCompanion({
    this.deviceAddress = const Value.absent(),
    this.time = const Value.absent(),
    this.accX = const Value.absent(),
    this.accY = const Value.absent(),
    this.accZ = const Value.absent(),
    this.gyrosX = const Value.absent(),
    this.gyrosY = const Value.absent(),
    this.gyrosZ = const Value.absent(),
    this.msgIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImuEntityCompanion.insert({
    required String deviceAddress,
    required DateTime time,
    required int accX,
    required int accY,
    required int accZ,
    required int gyrosX,
    required int gyrosY,
    required int gyrosZ,
    required int msgIndex,
    this.rowid = const Value.absent(),
  })  : deviceAddress = Value(deviceAddress),
        time = Value(time),
        accX = Value(accX),
        accY = Value(accY),
        accZ = Value(accZ),
        gyrosX = Value(gyrosX),
        gyrosY = Value(gyrosY),
        gyrosZ = Value(gyrosZ),
        msgIndex = Value(msgIndex);
  static Insertable<ImuEntityData> custom({
    Expression<String>? deviceAddress,
    Expression<DateTime>? time,
    Expression<int>? accX,
    Expression<int>? accY,
    Expression<int>? accZ,
    Expression<int>? gyrosX,
    Expression<int>? gyrosY,
    Expression<int>? gyrosZ,
    Expression<int>? msgIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (deviceAddress != null) 'device_address': deviceAddress,
      if (time != null) 'time': time,
      if (accX != null) 'acc_x': accX,
      if (accY != null) 'acc_y': accY,
      if (accZ != null) 'acc_z': accZ,
      if (gyrosX != null) 'gyros_x': gyrosX,
      if (gyrosY != null) 'gyros_y': gyrosY,
      if (gyrosZ != null) 'gyros_z': gyrosZ,
      if (msgIndex != null) 'msg_index': msgIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImuEntityCompanion copyWith(
      {Value<String>? deviceAddress,
      Value<DateTime>? time,
      Value<int>? accX,
      Value<int>? accY,
      Value<int>? accZ,
      Value<int>? gyrosX,
      Value<int>? gyrosY,
      Value<int>? gyrosZ,
      Value<int>? msgIndex,
      Value<int>? rowid}) {
    return ImuEntityCompanion(
      deviceAddress: deviceAddress ?? this.deviceAddress,
      time: time ?? this.time,
      accX: accX ?? this.accX,
      accY: accY ?? this.accY,
      accZ: accZ ?? this.accZ,
      gyrosX: gyrosX ?? this.gyrosX,
      gyrosY: gyrosY ?? this.gyrosY,
      gyrosZ: gyrosZ ?? this.gyrosZ,
      msgIndex: msgIndex ?? this.msgIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deviceAddress.present) {
      map['device_address'] = Variable<String>(deviceAddress.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (accX.present) {
      map['acc_x'] = Variable<int>(accX.value);
    }
    if (accY.present) {
      map['acc_y'] = Variable<int>(accY.value);
    }
    if (accZ.present) {
      map['acc_z'] = Variable<int>(accZ.value);
    }
    if (gyrosX.present) {
      map['gyros_x'] = Variable<int>(gyrosX.value);
    }
    if (gyrosY.present) {
      map['gyros_y'] = Variable<int>(gyrosY.value);
    }
    if (gyrosZ.present) {
      map['gyros_z'] = Variable<int>(gyrosZ.value);
    }
    if (msgIndex.present) {
      map['msg_index'] = Variable<int>(msgIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImuEntityCompanion(')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('time: $time, ')
          ..write('accX: $accX, ')
          ..write('accY: $accY, ')
          ..write('accZ: $accZ, ')
          ..write('gyrosX: $gyrosX, ')
          ..write('gyrosY: $gyrosY, ')
          ..write('gyrosZ: $gyrosZ, ')
          ..write('msgIndex: $msgIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BatteryInfoEntityTable extends BatteryInfoEntity
    with TableInfo<$BatteryInfoEntityTable, BatteryInfoEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatteryInfoEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isChargingMeta =
      const VerificationMeta('isCharging');
  @override
  late final GeneratedColumn<bool> isCharging = GeneratedColumn<bool>(
      'is_charging', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_charging" IN (0, 1))'));
  static const VerificationMeta _voltageMeta =
      const VerificationMeta('voltage');
  @override
  late final GeneratedColumn<double> voltage = GeneratedColumn<double>(
      'voltage', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _deviceAddressMeta =
      const VerificationMeta('deviceAddress');
  @override
  late final GeneratedColumn<String> deviceAddress = GeneratedColumn<String>(
      'device_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [time, level, isCharging, voltage, deviceAddress];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'battery_info_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<BatteryInfoEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('is_charging')) {
      context.handle(
          _isChargingMeta,
          isCharging.isAcceptableOrUnknown(
              data['is_charging']!, _isChargingMeta));
    } else if (isInserting) {
      context.missing(_isChargingMeta);
    }
    if (data.containsKey('voltage')) {
      context.handle(_voltageMeta,
          voltage.isAcceptableOrUnknown(data['voltage']!, _voltageMeta));
    } else if (isInserting) {
      context.missing(_voltageMeta);
    }
    if (data.containsKey('device_address')) {
      context.handle(
          _deviceAddressMeta,
          deviceAddress.isAcceptableOrUnknown(
              data['device_address']!, _deviceAddressMeta));
    } else if (isInserting) {
      context.missing(_deviceAddressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {time};
  @override
  BatteryInfoEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatteryInfoEntityData(
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      isCharging: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_charging'])!,
      voltage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}voltage'])!,
      deviceAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_address'])!,
    );
  }

  @override
  $BatteryInfoEntityTable createAlias(String alias) {
    return $BatteryInfoEntityTable(attachedDatabase, alias);
  }
}

class BatteryInfoEntityData extends DataClass
    implements Insertable<BatteryInfoEntityData> {
  final DateTime time;
  final int level;
  final bool isCharging;
  final double voltage;
  final String deviceAddress;
  const BatteryInfoEntityData(
      {required this.time,
      required this.level,
      required this.isCharging,
      required this.voltage,
      required this.deviceAddress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['time'] = Variable<DateTime>(time);
    map['level'] = Variable<int>(level);
    map['is_charging'] = Variable<bool>(isCharging);
    map['voltage'] = Variable<double>(voltage);
    map['device_address'] = Variable<String>(deviceAddress);
    return map;
  }

  BatteryInfoEntityCompanion toCompanion(bool nullToAbsent) {
    return BatteryInfoEntityCompanion(
      time: Value(time),
      level: Value(level),
      isCharging: Value(isCharging),
      voltage: Value(voltage),
      deviceAddress: Value(deviceAddress),
    );
  }

  factory BatteryInfoEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatteryInfoEntityData(
      time: serializer.fromJson<DateTime>(json['time']),
      level: serializer.fromJson<int>(json['level']),
      isCharging: serializer.fromJson<bool>(json['isCharging']),
      voltage: serializer.fromJson<double>(json['voltage']),
      deviceAddress: serializer.fromJson<String>(json['deviceAddress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'time': serializer.toJson<DateTime>(time),
      'level': serializer.toJson<int>(level),
      'isCharging': serializer.toJson<bool>(isCharging),
      'voltage': serializer.toJson<double>(voltage),
      'deviceAddress': serializer.toJson<String>(deviceAddress),
    };
  }

  BatteryInfoEntityData copyWith(
          {DateTime? time,
          int? level,
          bool? isCharging,
          double? voltage,
          String? deviceAddress}) =>
      BatteryInfoEntityData(
        time: time ?? this.time,
        level: level ?? this.level,
        isCharging: isCharging ?? this.isCharging,
        voltage: voltage ?? this.voltage,
        deviceAddress: deviceAddress ?? this.deviceAddress,
      );
  BatteryInfoEntityData copyWithCompanion(BatteryInfoEntityCompanion data) {
    return BatteryInfoEntityData(
      time: data.time.present ? data.time.value : this.time,
      level: data.level.present ? data.level.value : this.level,
      isCharging:
          data.isCharging.present ? data.isCharging.value : this.isCharging,
      voltage: data.voltage.present ? data.voltage.value : this.voltage,
      deviceAddress: data.deviceAddress.present
          ? data.deviceAddress.value
          : this.deviceAddress,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatteryInfoEntityData(')
          ..write('time: $time, ')
          ..write('level: $level, ')
          ..write('isCharging: $isCharging, ')
          ..write('voltage: $voltage, ')
          ..write('deviceAddress: $deviceAddress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(time, level, isCharging, voltage, deviceAddress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatteryInfoEntityData &&
          other.time == this.time &&
          other.level == this.level &&
          other.isCharging == this.isCharging &&
          other.voltage == this.voltage &&
          other.deviceAddress == this.deviceAddress);
}

class BatteryInfoEntityCompanion
    extends UpdateCompanion<BatteryInfoEntityData> {
  final Value<DateTime> time;
  final Value<int> level;
  final Value<bool> isCharging;
  final Value<double> voltage;
  final Value<String> deviceAddress;
  final Value<int> rowid;
  const BatteryInfoEntityCompanion({
    this.time = const Value.absent(),
    this.level = const Value.absent(),
    this.isCharging = const Value.absent(),
    this.voltage = const Value.absent(),
    this.deviceAddress = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BatteryInfoEntityCompanion.insert({
    required DateTime time,
    required int level,
    required bool isCharging,
    required double voltage,
    required String deviceAddress,
    this.rowid = const Value.absent(),
  })  : time = Value(time),
        level = Value(level),
        isCharging = Value(isCharging),
        voltage = Value(voltage),
        deviceAddress = Value(deviceAddress);
  static Insertable<BatteryInfoEntityData> custom({
    Expression<DateTime>? time,
    Expression<int>? level,
    Expression<bool>? isCharging,
    Expression<double>? voltage,
    Expression<String>? deviceAddress,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (time != null) 'time': time,
      if (level != null) 'level': level,
      if (isCharging != null) 'is_charging': isCharging,
      if (voltage != null) 'voltage': voltage,
      if (deviceAddress != null) 'device_address': deviceAddress,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BatteryInfoEntityCompanion copyWith(
      {Value<DateTime>? time,
      Value<int>? level,
      Value<bool>? isCharging,
      Value<double>? voltage,
      Value<String>? deviceAddress,
      Value<int>? rowid}) {
    return BatteryInfoEntityCompanion(
      time: time ?? this.time,
      level: level ?? this.level,
      isCharging: isCharging ?? this.isCharging,
      voltage: voltage ?? this.voltage,
      deviceAddress: deviceAddress ?? this.deviceAddress,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (isCharging.present) {
      map['is_charging'] = Variable<bool>(isCharging.value);
    }
    if (voltage.present) {
      map['voltage'] = Variable<double>(voltage.value);
    }
    if (deviceAddress.present) {
      map['device_address'] = Variable<String>(deviceAddress.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatteryInfoEntityCompanion(')
          ..write('time: $time, ')
          ..write('level: $level, ')
          ..write('isCharging: $isCharging, ')
          ..write('voltage: $voltage, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeviceInfoEntityTable extends DeviceInfoEntity
    with TableInfo<$DeviceInfoEntityTable, DeviceInfoEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceInfoEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deviceNameMeta =
      const VerificationMeta('deviceName');
  @override
  late final GeneratedColumn<String> deviceName = GeneratedColumn<String>(
      'device_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deviceAddressMeta =
      const VerificationMeta('deviceAddress');
  @override
  late final GeneratedColumn<String> deviceAddress = GeneratedColumn<String>(
      'device_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hwVersionMeta =
      const VerificationMeta('hwVersion');
  @override
  late final GeneratedColumn<String> hwVersion = GeneratedColumn<String>(
      'hw_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fwVersionMeta =
      const VerificationMeta('fwVersion');
  @override
  late final GeneratedColumn<String> fwVersion = GeneratedColumn<String>(
      'fw_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [time, deviceName, deviceAddress, hwVersion, fwVersion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_info_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<DeviceInfoEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('device_name')) {
      context.handle(
          _deviceNameMeta,
          deviceName.isAcceptableOrUnknown(
              data['device_name']!, _deviceNameMeta));
    } else if (isInserting) {
      context.missing(_deviceNameMeta);
    }
    if (data.containsKey('device_address')) {
      context.handle(
          _deviceAddressMeta,
          deviceAddress.isAcceptableOrUnknown(
              data['device_address']!, _deviceAddressMeta));
    } else if (isInserting) {
      context.missing(_deviceAddressMeta);
    }
    if (data.containsKey('hw_version')) {
      context.handle(_hwVersionMeta,
          hwVersion.isAcceptableOrUnknown(data['hw_version']!, _hwVersionMeta));
    } else if (isInserting) {
      context.missing(_hwVersionMeta);
    }
    if (data.containsKey('fw_version')) {
      context.handle(_fwVersionMeta,
          fwVersion.isAcceptableOrUnknown(data['fw_version']!, _fwVersionMeta));
    } else if (isInserting) {
      context.missing(_fwVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {time};
  @override
  DeviceInfoEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceInfoEntityData(
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      deviceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_name'])!,
      deviceAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_address'])!,
      hwVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hw_version'])!,
      fwVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fw_version'])!,
    );
  }

  @override
  $DeviceInfoEntityTable createAlias(String alias) {
    return $DeviceInfoEntityTable(attachedDatabase, alias);
  }
}

class DeviceInfoEntityData extends DataClass
    implements Insertable<DeviceInfoEntityData> {
  final DateTime time;
  final String deviceName;
  final String deviceAddress;
  final String hwVersion;
  final String fwVersion;
  const DeviceInfoEntityData(
      {required this.time,
      required this.deviceName,
      required this.deviceAddress,
      required this.hwVersion,
      required this.fwVersion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['time'] = Variable<DateTime>(time);
    map['device_name'] = Variable<String>(deviceName);
    map['device_address'] = Variable<String>(deviceAddress);
    map['hw_version'] = Variable<String>(hwVersion);
    map['fw_version'] = Variable<String>(fwVersion);
    return map;
  }

  DeviceInfoEntityCompanion toCompanion(bool nullToAbsent) {
    return DeviceInfoEntityCompanion(
      time: Value(time),
      deviceName: Value(deviceName),
      deviceAddress: Value(deviceAddress),
      hwVersion: Value(hwVersion),
      fwVersion: Value(fwVersion),
    );
  }

  factory DeviceInfoEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceInfoEntityData(
      time: serializer.fromJson<DateTime>(json['time']),
      deviceName: serializer.fromJson<String>(json['deviceName']),
      deviceAddress: serializer.fromJson<String>(json['deviceAddress']),
      hwVersion: serializer.fromJson<String>(json['hwVersion']),
      fwVersion: serializer.fromJson<String>(json['fwVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'time': serializer.toJson<DateTime>(time),
      'deviceName': serializer.toJson<String>(deviceName),
      'deviceAddress': serializer.toJson<String>(deviceAddress),
      'hwVersion': serializer.toJson<String>(hwVersion),
      'fwVersion': serializer.toJson<String>(fwVersion),
    };
  }

  DeviceInfoEntityData copyWith(
          {DateTime? time,
          String? deviceName,
          String? deviceAddress,
          String? hwVersion,
          String? fwVersion}) =>
      DeviceInfoEntityData(
        time: time ?? this.time,
        deviceName: deviceName ?? this.deviceName,
        deviceAddress: deviceAddress ?? this.deviceAddress,
        hwVersion: hwVersion ?? this.hwVersion,
        fwVersion: fwVersion ?? this.fwVersion,
      );
  DeviceInfoEntityData copyWithCompanion(DeviceInfoEntityCompanion data) {
    return DeviceInfoEntityData(
      time: data.time.present ? data.time.value : this.time,
      deviceName:
          data.deviceName.present ? data.deviceName.value : this.deviceName,
      deviceAddress: data.deviceAddress.present
          ? data.deviceAddress.value
          : this.deviceAddress,
      hwVersion: data.hwVersion.present ? data.hwVersion.value : this.hwVersion,
      fwVersion: data.fwVersion.present ? data.fwVersion.value : this.fwVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceInfoEntityData(')
          ..write('time: $time, ')
          ..write('deviceName: $deviceName, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('hwVersion: $hwVersion, ')
          ..write('fwVersion: $fwVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(time, deviceName, deviceAddress, hwVersion, fwVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceInfoEntityData &&
          other.time == this.time &&
          other.deviceName == this.deviceName &&
          other.deviceAddress == this.deviceAddress &&
          other.hwVersion == this.hwVersion &&
          other.fwVersion == this.fwVersion);
}

class DeviceInfoEntityCompanion extends UpdateCompanion<DeviceInfoEntityData> {
  final Value<DateTime> time;
  final Value<String> deviceName;
  final Value<String> deviceAddress;
  final Value<String> hwVersion;
  final Value<String> fwVersion;
  final Value<int> rowid;
  const DeviceInfoEntityCompanion({
    this.time = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.deviceAddress = const Value.absent(),
    this.hwVersion = const Value.absent(),
    this.fwVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceInfoEntityCompanion.insert({
    required DateTime time,
    required String deviceName,
    required String deviceAddress,
    required String hwVersion,
    required String fwVersion,
    this.rowid = const Value.absent(),
  })  : time = Value(time),
        deviceName = Value(deviceName),
        deviceAddress = Value(deviceAddress),
        hwVersion = Value(hwVersion),
        fwVersion = Value(fwVersion);
  static Insertable<DeviceInfoEntityData> custom({
    Expression<DateTime>? time,
    Expression<String>? deviceName,
    Expression<String>? deviceAddress,
    Expression<String>? hwVersion,
    Expression<String>? fwVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (time != null) 'time': time,
      if (deviceName != null) 'device_name': deviceName,
      if (deviceAddress != null) 'device_address': deviceAddress,
      if (hwVersion != null) 'hw_version': hwVersion,
      if (fwVersion != null) 'fw_version': fwVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceInfoEntityCompanion copyWith(
      {Value<DateTime>? time,
      Value<String>? deviceName,
      Value<String>? deviceAddress,
      Value<String>? hwVersion,
      Value<String>? fwVersion,
      Value<int>? rowid}) {
    return DeviceInfoEntityCompanion(
      time: time ?? this.time,
      deviceName: deviceName ?? this.deviceName,
      deviceAddress: deviceAddress ?? this.deviceAddress,
      hwVersion: hwVersion ?? this.hwVersion,
      fwVersion: fwVersion ?? this.fwVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (deviceName.present) {
      map['device_name'] = Variable<String>(deviceName.value);
    }
    if (deviceAddress.present) {
      map['device_address'] = Variable<String>(deviceAddress.value);
    }
    if (hwVersion.present) {
      map['hw_version'] = Variable<String>(hwVersion.value);
    }
    if (fwVersion.present) {
      map['fw_version'] = Variable<String>(fwVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceInfoEntityCompanion(')
          ..write('time: $time, ')
          ..write('deviceName: $deviceName, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('hwVersion: $hwVersion, ')
          ..write('fwVersion: $fwVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ErrorCodeEntityTable extends ErrorCodeEntity
    with TableInfo<$ErrorCodeEntityTable, ErrorCodeEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ErrorCodeEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _imuSensorMeta =
      const VerificationMeta('imuSensor');
  @override
  late final GeneratedColumn<int> imuSensor = GeneratedColumn<int>(
      'imu_sensor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _magSensorMeta =
      const VerificationMeta('magSensor');
  @override
  late final GeneratedColumn<int> magSensor = GeneratedColumn<int>(
      'mag_sensor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _batteryMonitorMeta =
      const VerificationMeta('batteryMonitor');
  @override
  late final GeneratedColumn<int> batteryMonitor = GeneratedColumn<int>(
      'battery_monitor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pressureSensorMeta =
      const VerificationMeta('pressureSensor');
  @override
  late final GeneratedColumn<int> pressureSensor = GeneratedColumn<int>(
      'pressure_sensor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _deviceAddressMeta =
      const VerificationMeta('deviceAddress');
  @override
  late final GeneratedColumn<String> deviceAddress = GeneratedColumn<String>(
      'device_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        time,
        imuSensor,
        magSensor,
        batteryMonitor,
        pressureSensor,
        deviceAddress
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'error_code_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<ErrorCodeEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('imu_sensor')) {
      context.handle(_imuSensorMeta,
          imuSensor.isAcceptableOrUnknown(data['imu_sensor']!, _imuSensorMeta));
    } else if (isInserting) {
      context.missing(_imuSensorMeta);
    }
    if (data.containsKey('mag_sensor')) {
      context.handle(_magSensorMeta,
          magSensor.isAcceptableOrUnknown(data['mag_sensor']!, _magSensorMeta));
    } else if (isInserting) {
      context.missing(_magSensorMeta);
    }
    if (data.containsKey('battery_monitor')) {
      context.handle(
          _batteryMonitorMeta,
          batteryMonitor.isAcceptableOrUnknown(
              data['battery_monitor']!, _batteryMonitorMeta));
    } else if (isInserting) {
      context.missing(_batteryMonitorMeta);
    }
    if (data.containsKey('pressure_sensor')) {
      context.handle(
          _pressureSensorMeta,
          pressureSensor.isAcceptableOrUnknown(
              data['pressure_sensor']!, _pressureSensorMeta));
    } else if (isInserting) {
      context.missing(_pressureSensorMeta);
    }
    if (data.containsKey('device_address')) {
      context.handle(
          _deviceAddressMeta,
          deviceAddress.isAcceptableOrUnknown(
              data['device_address']!, _deviceAddressMeta));
    } else if (isInserting) {
      context.missing(_deviceAddressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {time};
  @override
  ErrorCodeEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ErrorCodeEntityData(
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      imuSensor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}imu_sensor'])!,
      magSensor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mag_sensor'])!,
      batteryMonitor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}battery_monitor'])!,
      pressureSensor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pressure_sensor'])!,
      deviceAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_address'])!,
    );
  }

  @override
  $ErrorCodeEntityTable createAlias(String alias) {
    return $ErrorCodeEntityTable(attachedDatabase, alias);
  }
}

class ErrorCodeEntityData extends DataClass
    implements Insertable<ErrorCodeEntityData> {
  final DateTime time;
  final int imuSensor;
  final int magSensor;
  final int batteryMonitor;
  final int pressureSensor;
  final String deviceAddress;
  const ErrorCodeEntityData(
      {required this.time,
      required this.imuSensor,
      required this.magSensor,
      required this.batteryMonitor,
      required this.pressureSensor,
      required this.deviceAddress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['time'] = Variable<DateTime>(time);
    map['imu_sensor'] = Variable<int>(imuSensor);
    map['mag_sensor'] = Variable<int>(magSensor);
    map['battery_monitor'] = Variable<int>(batteryMonitor);
    map['pressure_sensor'] = Variable<int>(pressureSensor);
    map['device_address'] = Variable<String>(deviceAddress);
    return map;
  }

  ErrorCodeEntityCompanion toCompanion(bool nullToAbsent) {
    return ErrorCodeEntityCompanion(
      time: Value(time),
      imuSensor: Value(imuSensor),
      magSensor: Value(magSensor),
      batteryMonitor: Value(batteryMonitor),
      pressureSensor: Value(pressureSensor),
      deviceAddress: Value(deviceAddress),
    );
  }

  factory ErrorCodeEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ErrorCodeEntityData(
      time: serializer.fromJson<DateTime>(json['time']),
      imuSensor: serializer.fromJson<int>(json['imuSensor']),
      magSensor: serializer.fromJson<int>(json['magSensor']),
      batteryMonitor: serializer.fromJson<int>(json['batteryMonitor']),
      pressureSensor: serializer.fromJson<int>(json['pressureSensor']),
      deviceAddress: serializer.fromJson<String>(json['deviceAddress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'time': serializer.toJson<DateTime>(time),
      'imuSensor': serializer.toJson<int>(imuSensor),
      'magSensor': serializer.toJson<int>(magSensor),
      'batteryMonitor': serializer.toJson<int>(batteryMonitor),
      'pressureSensor': serializer.toJson<int>(pressureSensor),
      'deviceAddress': serializer.toJson<String>(deviceAddress),
    };
  }

  ErrorCodeEntityData copyWith(
          {DateTime? time,
          int? imuSensor,
          int? magSensor,
          int? batteryMonitor,
          int? pressureSensor,
          String? deviceAddress}) =>
      ErrorCodeEntityData(
        time: time ?? this.time,
        imuSensor: imuSensor ?? this.imuSensor,
        magSensor: magSensor ?? this.magSensor,
        batteryMonitor: batteryMonitor ?? this.batteryMonitor,
        pressureSensor: pressureSensor ?? this.pressureSensor,
        deviceAddress: deviceAddress ?? this.deviceAddress,
      );
  ErrorCodeEntityData copyWithCompanion(ErrorCodeEntityCompanion data) {
    return ErrorCodeEntityData(
      time: data.time.present ? data.time.value : this.time,
      imuSensor: data.imuSensor.present ? data.imuSensor.value : this.imuSensor,
      magSensor: data.magSensor.present ? data.magSensor.value : this.magSensor,
      batteryMonitor: data.batteryMonitor.present
          ? data.batteryMonitor.value
          : this.batteryMonitor,
      pressureSensor: data.pressureSensor.present
          ? data.pressureSensor.value
          : this.pressureSensor,
      deviceAddress: data.deviceAddress.present
          ? data.deviceAddress.value
          : this.deviceAddress,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ErrorCodeEntityData(')
          ..write('time: $time, ')
          ..write('imuSensor: $imuSensor, ')
          ..write('magSensor: $magSensor, ')
          ..write('batteryMonitor: $batteryMonitor, ')
          ..write('pressureSensor: $pressureSensor, ')
          ..write('deviceAddress: $deviceAddress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(time, imuSensor, magSensor, batteryMonitor,
      pressureSensor, deviceAddress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ErrorCodeEntityData &&
          other.time == this.time &&
          other.imuSensor == this.imuSensor &&
          other.magSensor == this.magSensor &&
          other.batteryMonitor == this.batteryMonitor &&
          other.pressureSensor == this.pressureSensor &&
          other.deviceAddress == this.deviceAddress);
}

class ErrorCodeEntityCompanion extends UpdateCompanion<ErrorCodeEntityData> {
  final Value<DateTime> time;
  final Value<int> imuSensor;
  final Value<int> magSensor;
  final Value<int> batteryMonitor;
  final Value<int> pressureSensor;
  final Value<String> deviceAddress;
  final Value<int> rowid;
  const ErrorCodeEntityCompanion({
    this.time = const Value.absent(),
    this.imuSensor = const Value.absent(),
    this.magSensor = const Value.absent(),
    this.batteryMonitor = const Value.absent(),
    this.pressureSensor = const Value.absent(),
    this.deviceAddress = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ErrorCodeEntityCompanion.insert({
    required DateTime time,
    required int imuSensor,
    required int magSensor,
    required int batteryMonitor,
    required int pressureSensor,
    required String deviceAddress,
    this.rowid = const Value.absent(),
  })  : time = Value(time),
        imuSensor = Value(imuSensor),
        magSensor = Value(magSensor),
        batteryMonitor = Value(batteryMonitor),
        pressureSensor = Value(pressureSensor),
        deviceAddress = Value(deviceAddress);
  static Insertable<ErrorCodeEntityData> custom({
    Expression<DateTime>? time,
    Expression<int>? imuSensor,
    Expression<int>? magSensor,
    Expression<int>? batteryMonitor,
    Expression<int>? pressureSensor,
    Expression<String>? deviceAddress,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (time != null) 'time': time,
      if (imuSensor != null) 'imu_sensor': imuSensor,
      if (magSensor != null) 'mag_sensor': magSensor,
      if (batteryMonitor != null) 'battery_monitor': batteryMonitor,
      if (pressureSensor != null) 'pressure_sensor': pressureSensor,
      if (deviceAddress != null) 'device_address': deviceAddress,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ErrorCodeEntityCompanion copyWith(
      {Value<DateTime>? time,
      Value<int>? imuSensor,
      Value<int>? magSensor,
      Value<int>? batteryMonitor,
      Value<int>? pressureSensor,
      Value<String>? deviceAddress,
      Value<int>? rowid}) {
    return ErrorCodeEntityCompanion(
      time: time ?? this.time,
      imuSensor: imuSensor ?? this.imuSensor,
      magSensor: magSensor ?? this.magSensor,
      batteryMonitor: batteryMonitor ?? this.batteryMonitor,
      pressureSensor: pressureSensor ?? this.pressureSensor,
      deviceAddress: deviceAddress ?? this.deviceAddress,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (imuSensor.present) {
      map['imu_sensor'] = Variable<int>(imuSensor.value);
    }
    if (magSensor.present) {
      map['mag_sensor'] = Variable<int>(magSensor.value);
    }
    if (batteryMonitor.present) {
      map['battery_monitor'] = Variable<int>(batteryMonitor.value);
    }
    if (pressureSensor.present) {
      map['pressure_sensor'] = Variable<int>(pressureSensor.value);
    }
    if (deviceAddress.present) {
      map['device_address'] = Variable<String>(deviceAddress.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ErrorCodeEntityCompanion(')
          ..write('time: $time, ')
          ..write('imuSensor: $imuSensor, ')
          ..write('magSensor: $magSensor, ')
          ..write('batteryMonitor: $batteryMonitor, ')
          ..write('pressureSensor: $pressureSensor, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MagneticEntityTable extends MagneticEntity
    with TableInfo<$MagneticEntityTable, MagneticEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MagneticEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<int> x = GeneratedColumn<int>(
      'x', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<int> y = GeneratedColumn<int>(
      'y', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _zMeta = const VerificationMeta('z');
  @override
  late final GeneratedColumn<int> z = GeneratedColumn<int>(
      'z', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _deviceAddressMeta =
      const VerificationMeta('deviceAddress');
  @override
  late final GeneratedColumn<String> deviceAddress = GeneratedColumn<String>(
      'device_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _msgIndexMeta =
      const VerificationMeta('msgIndex');
  @override
  late final GeneratedColumn<int> msgIndex = GeneratedColumn<int>(
      'msg_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [time, x, y, z, deviceAddress, msgIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'magnetic_entity';
  @override
  VerificationContext validateIntegrity(Insertable<MagneticEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('z')) {
      context.handle(_zMeta, z.isAcceptableOrUnknown(data['z']!, _zMeta));
    } else if (isInserting) {
      context.missing(_zMeta);
    }
    if (data.containsKey('device_address')) {
      context.handle(
          _deviceAddressMeta,
          deviceAddress.isAcceptableOrUnknown(
              data['device_address']!, _deviceAddressMeta));
    } else if (isInserting) {
      context.missing(_deviceAddressMeta);
    }
    if (data.containsKey('msg_index')) {
      context.handle(_msgIndexMeta,
          msgIndex.isAcceptableOrUnknown(data['msg_index']!, _msgIndexMeta));
    } else if (isInserting) {
      context.missing(_msgIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deviceAddress, time};
  @override
  MagneticEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MagneticEntityData(
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      x: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}x'])!,
      y: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}y'])!,
      z: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}z'])!,
      deviceAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_address'])!,
      msgIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}msg_index'])!,
    );
  }

  @override
  $MagneticEntityTable createAlias(String alias) {
    return $MagneticEntityTable(attachedDatabase, alias);
  }
}

class MagneticEntityData extends DataClass
    implements Insertable<MagneticEntityData> {
  final DateTime time;
  final int x;
  final int y;
  final int z;
  final String deviceAddress;
  final int msgIndex;
  const MagneticEntityData(
      {required this.time,
      required this.x,
      required this.y,
      required this.z,
      required this.deviceAddress,
      required this.msgIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['time'] = Variable<DateTime>(time);
    map['x'] = Variable<int>(x);
    map['y'] = Variable<int>(y);
    map['z'] = Variable<int>(z);
    map['device_address'] = Variable<String>(deviceAddress);
    map['msg_index'] = Variable<int>(msgIndex);
    return map;
  }

  MagneticEntityCompanion toCompanion(bool nullToAbsent) {
    return MagneticEntityCompanion(
      time: Value(time),
      x: Value(x),
      y: Value(y),
      z: Value(z),
      deviceAddress: Value(deviceAddress),
      msgIndex: Value(msgIndex),
    );
  }

  factory MagneticEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MagneticEntityData(
      time: serializer.fromJson<DateTime>(json['time']),
      x: serializer.fromJson<int>(json['x']),
      y: serializer.fromJson<int>(json['y']),
      z: serializer.fromJson<int>(json['z']),
      deviceAddress: serializer.fromJson<String>(json['deviceAddress']),
      msgIndex: serializer.fromJson<int>(json['msgIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'time': serializer.toJson<DateTime>(time),
      'x': serializer.toJson<int>(x),
      'y': serializer.toJson<int>(y),
      'z': serializer.toJson<int>(z),
      'deviceAddress': serializer.toJson<String>(deviceAddress),
      'msgIndex': serializer.toJson<int>(msgIndex),
    };
  }

  MagneticEntityData copyWith(
          {DateTime? time,
          int? x,
          int? y,
          int? z,
          String? deviceAddress,
          int? msgIndex}) =>
      MagneticEntityData(
        time: time ?? this.time,
        x: x ?? this.x,
        y: y ?? this.y,
        z: z ?? this.z,
        deviceAddress: deviceAddress ?? this.deviceAddress,
        msgIndex: msgIndex ?? this.msgIndex,
      );
  MagneticEntityData copyWithCompanion(MagneticEntityCompanion data) {
    return MagneticEntityData(
      time: data.time.present ? data.time.value : this.time,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      z: data.z.present ? data.z.value : this.z,
      deviceAddress: data.deviceAddress.present
          ? data.deviceAddress.value
          : this.deviceAddress,
      msgIndex: data.msgIndex.present ? data.msgIndex.value : this.msgIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MagneticEntityData(')
          ..write('time: $time, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('z: $z, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('msgIndex: $msgIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(time, x, y, z, deviceAddress, msgIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MagneticEntityData &&
          other.time == this.time &&
          other.x == this.x &&
          other.y == this.y &&
          other.z == this.z &&
          other.deviceAddress == this.deviceAddress &&
          other.msgIndex == this.msgIndex);
}

class MagneticEntityCompanion extends UpdateCompanion<MagneticEntityData> {
  final Value<DateTime> time;
  final Value<int> x;
  final Value<int> y;
  final Value<int> z;
  final Value<String> deviceAddress;
  final Value<int> msgIndex;
  final Value<int> rowid;
  const MagneticEntityCompanion({
    this.time = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.z = const Value.absent(),
    this.deviceAddress = const Value.absent(),
    this.msgIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MagneticEntityCompanion.insert({
    required DateTime time,
    required int x,
    required int y,
    required int z,
    required String deviceAddress,
    required int msgIndex,
    this.rowid = const Value.absent(),
  })  : time = Value(time),
        x = Value(x),
        y = Value(y),
        z = Value(z),
        deviceAddress = Value(deviceAddress),
        msgIndex = Value(msgIndex);
  static Insertable<MagneticEntityData> custom({
    Expression<DateTime>? time,
    Expression<int>? x,
    Expression<int>? y,
    Expression<int>? z,
    Expression<String>? deviceAddress,
    Expression<int>? msgIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (time != null) 'time': time,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (z != null) 'z': z,
      if (deviceAddress != null) 'device_address': deviceAddress,
      if (msgIndex != null) 'msg_index': msgIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MagneticEntityCompanion copyWith(
      {Value<DateTime>? time,
      Value<int>? x,
      Value<int>? y,
      Value<int>? z,
      Value<String>? deviceAddress,
      Value<int>? msgIndex,
      Value<int>? rowid}) {
    return MagneticEntityCompanion(
      time: time ?? this.time,
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
      deviceAddress: deviceAddress ?? this.deviceAddress,
      msgIndex: msgIndex ?? this.msgIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (x.present) {
      map['x'] = Variable<int>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<int>(y.value);
    }
    if (z.present) {
      map['z'] = Variable<int>(z.value);
    }
    if (deviceAddress.present) {
      map['device_address'] = Variable<String>(deviceAddress.value);
    }
    if (msgIndex.present) {
      map['msg_index'] = Variable<int>(msgIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MagneticEntityCompanion(')
          ..write('time: $time, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('z: $z, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('msgIndex: $msgIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimestampEntityTable extends TimestampEntity
    with TableInfo<$TimestampEntityTable, TimestampEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimestampEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _timeValueMeta =
      const VerificationMeta('timeValue');
  @override
  late final GeneratedColumn<DateTime> timeValue = GeneratedColumn<DateTime>(
      'time_value', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deviceAddressMeta =
      const VerificationMeta('deviceAddress');
  @override
  late final GeneratedColumn<String> deviceAddress = GeneratedColumn<String>(
      'device_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [time, timeValue, deviceAddress];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timestamp_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<TimestampEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('time_value')) {
      context.handle(_timeValueMeta,
          timeValue.isAcceptableOrUnknown(data['time_value']!, _timeValueMeta));
    } else if (isInserting) {
      context.missing(_timeValueMeta);
    }
    if (data.containsKey('device_address')) {
      context.handle(
          _deviceAddressMeta,
          deviceAddress.isAcceptableOrUnknown(
              data['device_address']!, _deviceAddressMeta));
    } else if (isInserting) {
      context.missing(_deviceAddressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {time};
  @override
  TimestampEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimestampEntityData(
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      timeValue: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_value'])!,
      deviceAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_address'])!,
    );
  }

  @override
  $TimestampEntityTable createAlias(String alias) {
    return $TimestampEntityTable(attachedDatabase, alias);
  }
}

class TimestampEntityData extends DataClass
    implements Insertable<TimestampEntityData> {
  final DateTime time;
  final DateTime timeValue;
  final String deviceAddress;
  const TimestampEntityData(
      {required this.time,
      required this.timeValue,
      required this.deviceAddress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['time'] = Variable<DateTime>(time);
    map['time_value'] = Variable<DateTime>(timeValue);
    map['device_address'] = Variable<String>(deviceAddress);
    return map;
  }

  TimestampEntityCompanion toCompanion(bool nullToAbsent) {
    return TimestampEntityCompanion(
      time: Value(time),
      timeValue: Value(timeValue),
      deviceAddress: Value(deviceAddress),
    );
  }

  factory TimestampEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimestampEntityData(
      time: serializer.fromJson<DateTime>(json['time']),
      timeValue: serializer.fromJson<DateTime>(json['timeValue']),
      deviceAddress: serializer.fromJson<String>(json['deviceAddress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'time': serializer.toJson<DateTime>(time),
      'timeValue': serializer.toJson<DateTime>(timeValue),
      'deviceAddress': serializer.toJson<String>(deviceAddress),
    };
  }

  TimestampEntityData copyWith(
          {DateTime? time, DateTime? timeValue, String? deviceAddress}) =>
      TimestampEntityData(
        time: time ?? this.time,
        timeValue: timeValue ?? this.timeValue,
        deviceAddress: deviceAddress ?? this.deviceAddress,
      );
  TimestampEntityData copyWithCompanion(TimestampEntityCompanion data) {
    return TimestampEntityData(
      time: data.time.present ? data.time.value : this.time,
      timeValue: data.timeValue.present ? data.timeValue.value : this.timeValue,
      deviceAddress: data.deviceAddress.present
          ? data.deviceAddress.value
          : this.deviceAddress,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimestampEntityData(')
          ..write('time: $time, ')
          ..write('timeValue: $timeValue, ')
          ..write('deviceAddress: $deviceAddress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(time, timeValue, deviceAddress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimestampEntityData &&
          other.time == this.time &&
          other.timeValue == this.timeValue &&
          other.deviceAddress == this.deviceAddress);
}

class TimestampEntityCompanion extends UpdateCompanion<TimestampEntityData> {
  final Value<DateTime> time;
  final Value<DateTime> timeValue;
  final Value<String> deviceAddress;
  final Value<int> rowid;
  const TimestampEntityCompanion({
    this.time = const Value.absent(),
    this.timeValue = const Value.absent(),
    this.deviceAddress = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimestampEntityCompanion.insert({
    required DateTime time,
    required DateTime timeValue,
    required String deviceAddress,
    this.rowid = const Value.absent(),
  })  : time = Value(time),
        timeValue = Value(timeValue),
        deviceAddress = Value(deviceAddress);
  static Insertable<TimestampEntityData> custom({
    Expression<DateTime>? time,
    Expression<DateTime>? timeValue,
    Expression<String>? deviceAddress,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (time != null) 'time': time,
      if (timeValue != null) 'time_value': timeValue,
      if (deviceAddress != null) 'device_address': deviceAddress,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimestampEntityCompanion copyWith(
      {Value<DateTime>? time,
      Value<DateTime>? timeValue,
      Value<String>? deviceAddress,
      Value<int>? rowid}) {
    return TimestampEntityCompanion(
      time: time ?? this.time,
      timeValue: timeValue ?? this.timeValue,
      deviceAddress: deviceAddress ?? this.deviceAddress,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (timeValue.present) {
      map['time_value'] = Variable<DateTime>(timeValue.value);
    }
    if (deviceAddress.present) {
      map['device_address'] = Variable<String>(deviceAddress.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimestampEntityCompanion(')
          ..write('time: $time, ')
          ..write('timeValue: $timeValue, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PressureEntityTable extends PressureEntity
    with TableInfo<$PressureEntityTable, PressureEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PressureEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deviceAddressMeta =
      const VerificationMeta('deviceAddress');
  @override
  late final GeneratedColumn<String> deviceAddress = GeneratedColumn<String>(
      'device_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _voltagesMeta =
      const VerificationMeta('voltages');
  @override
  late final GeneratedColumn<String> voltages = GeneratedColumn<String>(
      'voltages', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [time, deviceAddress, voltages];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pressure_entity';
  @override
  VerificationContext validateIntegrity(Insertable<PressureEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('device_address')) {
      context.handle(
          _deviceAddressMeta,
          deviceAddress.isAcceptableOrUnknown(
              data['device_address']!, _deviceAddressMeta));
    } else if (isInserting) {
      context.missing(_deviceAddressMeta);
    }
    if (data.containsKey('voltages')) {
      context.handle(_voltagesMeta,
          voltages.isAcceptableOrUnknown(data['voltages']!, _voltagesMeta));
    } else if (isInserting) {
      context.missing(_voltagesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {time};
  @override
  PressureEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PressureEntityData(
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      deviceAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_address'])!,
      voltages: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}voltages'])!,
    );
  }

  @override
  $PressureEntityTable createAlias(String alias) {
    return $PressureEntityTable(attachedDatabase, alias);
  }
}

class PressureEntityData extends DataClass
    implements Insertable<PressureEntityData> {
  final DateTime time;
  final String deviceAddress;
  final String voltages;
  const PressureEntityData(
      {required this.time,
      required this.deviceAddress,
      required this.voltages});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['time'] = Variable<DateTime>(time);
    map['device_address'] = Variable<String>(deviceAddress);
    map['voltages'] = Variable<String>(voltages);
    return map;
  }

  PressureEntityCompanion toCompanion(bool nullToAbsent) {
    return PressureEntityCompanion(
      time: Value(time),
      deviceAddress: Value(deviceAddress),
      voltages: Value(voltages),
    );
  }

  factory PressureEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PressureEntityData(
      time: serializer.fromJson<DateTime>(json['time']),
      deviceAddress: serializer.fromJson<String>(json['deviceAddress']),
      voltages: serializer.fromJson<String>(json['voltages']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'time': serializer.toJson<DateTime>(time),
      'deviceAddress': serializer.toJson<String>(deviceAddress),
      'voltages': serializer.toJson<String>(voltages),
    };
  }

  PressureEntityData copyWith(
          {DateTime? time, String? deviceAddress, String? voltages}) =>
      PressureEntityData(
        time: time ?? this.time,
        deviceAddress: deviceAddress ?? this.deviceAddress,
        voltages: voltages ?? this.voltages,
      );
  PressureEntityData copyWithCompanion(PressureEntityCompanion data) {
    return PressureEntityData(
      time: data.time.present ? data.time.value : this.time,
      deviceAddress: data.deviceAddress.present
          ? data.deviceAddress.value
          : this.deviceAddress,
      voltages: data.voltages.present ? data.voltages.value : this.voltages,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PressureEntityData(')
          ..write('time: $time, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('voltages: $voltages')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(time, deviceAddress, voltages);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PressureEntityData &&
          other.time == this.time &&
          other.deviceAddress == this.deviceAddress &&
          other.voltages == this.voltages);
}

class PressureEntityCompanion extends UpdateCompanion<PressureEntityData> {
  final Value<DateTime> time;
  final Value<String> deviceAddress;
  final Value<String> voltages;
  final Value<int> rowid;
  const PressureEntityCompanion({
    this.time = const Value.absent(),
    this.deviceAddress = const Value.absent(),
    this.voltages = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PressureEntityCompanion.insert({
    required DateTime time,
    required String deviceAddress,
    required String voltages,
    this.rowid = const Value.absent(),
  })  : time = Value(time),
        deviceAddress = Value(deviceAddress),
        voltages = Value(voltages);
  static Insertable<PressureEntityData> custom({
    Expression<DateTime>? time,
    Expression<String>? deviceAddress,
    Expression<String>? voltages,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (time != null) 'time': time,
      if (deviceAddress != null) 'device_address': deviceAddress,
      if (voltages != null) 'voltages': voltages,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PressureEntityCompanion copyWith(
      {Value<DateTime>? time,
      Value<String>? deviceAddress,
      Value<String>? voltages,
      Value<int>? rowid}) {
    return PressureEntityCompanion(
      time: time ?? this.time,
      deviceAddress: deviceAddress ?? this.deviceAddress,
      voltages: voltages ?? this.voltages,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (deviceAddress.present) {
      map['device_address'] = Variable<String>(deviceAddress.value);
    }
    if (voltages.present) {
      map['voltages'] = Variable<String>(voltages.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PressureEntityCompanion(')
          ..write('time: $time, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('voltages: $voltages, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ImuEntityTable imuEntity = $ImuEntityTable(this);
  late final $BatteryInfoEntityTable batteryInfoEntity =
      $BatteryInfoEntityTable(this);
  late final $DeviceInfoEntityTable deviceInfoEntity =
      $DeviceInfoEntityTable(this);
  late final $ErrorCodeEntityTable errorCodeEntity =
      $ErrorCodeEntityTable(this);
  late final $MagneticEntityTable magneticEntity = $MagneticEntityTable(this);
  late final $TimestampEntityTable timestampEntity =
      $TimestampEntityTable(this);
  late final $PressureEntityTable pressureEntity = $PressureEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        imuEntity,
        batteryInfoEntity,
        deviceInfoEntity,
        errorCodeEntity,
        magneticEntity,
        timestampEntity,
        pressureEntity
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$ImuEntityTableCreateCompanionBuilder = ImuEntityCompanion Function({
  required String deviceAddress,
  required DateTime time,
  required int accX,
  required int accY,
  required int accZ,
  required int gyrosX,
  required int gyrosY,
  required int gyrosZ,
  required int msgIndex,
  Value<int> rowid,
});
typedef $$ImuEntityTableUpdateCompanionBuilder = ImuEntityCompanion Function({
  Value<String> deviceAddress,
  Value<DateTime> time,
  Value<int> accX,
  Value<int> accY,
  Value<int> accZ,
  Value<int> gyrosX,
  Value<int> gyrosY,
  Value<int> gyrosZ,
  Value<int> msgIndex,
  Value<int> rowid,
});

class $$ImuEntityTableFilterComposer
    extends Composer<_$AppDatabase, $ImuEntityTable> {
  $$ImuEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get accX => $composableBuilder(
      column: $table.accX, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get accY => $composableBuilder(
      column: $table.accY, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get accZ => $composableBuilder(
      column: $table.accZ, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get gyrosX => $composableBuilder(
      column: $table.gyrosX, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get gyrosY => $composableBuilder(
      column: $table.gyrosY, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get gyrosZ => $composableBuilder(
      column: $table.gyrosZ, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get msgIndex => $composableBuilder(
      column: $table.msgIndex, builder: (column) => ColumnFilters(column));
}

class $$ImuEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $ImuEntityTable> {
  $$ImuEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get accX => $composableBuilder(
      column: $table.accX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get accY => $composableBuilder(
      column: $table.accY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get accZ => $composableBuilder(
      column: $table.accZ, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get gyrosX => $composableBuilder(
      column: $table.gyrosX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get gyrosY => $composableBuilder(
      column: $table.gyrosY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get gyrosZ => $composableBuilder(
      column: $table.gyrosZ, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get msgIndex => $composableBuilder(
      column: $table.msgIndex, builder: (column) => ColumnOrderings(column));
}

class $$ImuEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImuEntityTable> {
  $$ImuEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<int> get accX =>
      $composableBuilder(column: $table.accX, builder: (column) => column);

  GeneratedColumn<int> get accY =>
      $composableBuilder(column: $table.accY, builder: (column) => column);

  GeneratedColumn<int> get accZ =>
      $composableBuilder(column: $table.accZ, builder: (column) => column);

  GeneratedColumn<int> get gyrosX =>
      $composableBuilder(column: $table.gyrosX, builder: (column) => column);

  GeneratedColumn<int> get gyrosY =>
      $composableBuilder(column: $table.gyrosY, builder: (column) => column);

  GeneratedColumn<int> get gyrosZ =>
      $composableBuilder(column: $table.gyrosZ, builder: (column) => column);

  GeneratedColumn<int> get msgIndex =>
      $composableBuilder(column: $table.msgIndex, builder: (column) => column);
}

class $$ImuEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ImuEntityTable,
    ImuEntityData,
    $$ImuEntityTableFilterComposer,
    $$ImuEntityTableOrderingComposer,
    $$ImuEntityTableAnnotationComposer,
    $$ImuEntityTableCreateCompanionBuilder,
    $$ImuEntityTableUpdateCompanionBuilder,
    (
      ImuEntityData,
      BaseReferences<_$AppDatabase, $ImuEntityTable, ImuEntityData>
    ),
    ImuEntityData,
    PrefetchHooks Function()> {
  $$ImuEntityTableTableManager(_$AppDatabase db, $ImuEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImuEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImuEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImuEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> deviceAddress = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<int> accX = const Value.absent(),
            Value<int> accY = const Value.absent(),
            Value<int> accZ = const Value.absent(),
            Value<int> gyrosX = const Value.absent(),
            Value<int> gyrosY = const Value.absent(),
            Value<int> gyrosZ = const Value.absent(),
            Value<int> msgIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ImuEntityCompanion(
            deviceAddress: deviceAddress,
            time: time,
            accX: accX,
            accY: accY,
            accZ: accZ,
            gyrosX: gyrosX,
            gyrosY: gyrosY,
            gyrosZ: gyrosZ,
            msgIndex: msgIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String deviceAddress,
            required DateTime time,
            required int accX,
            required int accY,
            required int accZ,
            required int gyrosX,
            required int gyrosY,
            required int gyrosZ,
            required int msgIndex,
            Value<int> rowid = const Value.absent(),
          }) =>
              ImuEntityCompanion.insert(
            deviceAddress: deviceAddress,
            time: time,
            accX: accX,
            accY: accY,
            accZ: accZ,
            gyrosX: gyrosX,
            gyrosY: gyrosY,
            gyrosZ: gyrosZ,
            msgIndex: msgIndex,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ImuEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ImuEntityTable,
    ImuEntityData,
    $$ImuEntityTableFilterComposer,
    $$ImuEntityTableOrderingComposer,
    $$ImuEntityTableAnnotationComposer,
    $$ImuEntityTableCreateCompanionBuilder,
    $$ImuEntityTableUpdateCompanionBuilder,
    (
      ImuEntityData,
      BaseReferences<_$AppDatabase, $ImuEntityTable, ImuEntityData>
    ),
    ImuEntityData,
    PrefetchHooks Function()>;
typedef $$BatteryInfoEntityTableCreateCompanionBuilder
    = BatteryInfoEntityCompanion Function({
  required DateTime time,
  required int level,
  required bool isCharging,
  required double voltage,
  required String deviceAddress,
  Value<int> rowid,
});
typedef $$BatteryInfoEntityTableUpdateCompanionBuilder
    = BatteryInfoEntityCompanion Function({
  Value<DateTime> time,
  Value<int> level,
  Value<bool> isCharging,
  Value<double> voltage,
  Value<String> deviceAddress,
  Value<int> rowid,
});

class $$BatteryInfoEntityTableFilterComposer
    extends Composer<_$AppDatabase, $BatteryInfoEntityTable> {
  $$BatteryInfoEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCharging => $composableBuilder(
      column: $table.isCharging, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get voltage => $composableBuilder(
      column: $table.voltage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => ColumnFilters(column));
}

class $$BatteryInfoEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $BatteryInfoEntityTable> {
  $$BatteryInfoEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCharging => $composableBuilder(
      column: $table.isCharging, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get voltage => $composableBuilder(
      column: $table.voltage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress,
      builder: (column) => ColumnOrderings(column));
}

class $$BatteryInfoEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatteryInfoEntityTable> {
  $$BatteryInfoEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<bool> get isCharging => $composableBuilder(
      column: $table.isCharging, builder: (column) => column);

  GeneratedColumn<double> get voltage =>
      $composableBuilder(column: $table.voltage, builder: (column) => column);

  GeneratedColumn<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => column);
}

class $$BatteryInfoEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BatteryInfoEntityTable,
    BatteryInfoEntityData,
    $$BatteryInfoEntityTableFilterComposer,
    $$BatteryInfoEntityTableOrderingComposer,
    $$BatteryInfoEntityTableAnnotationComposer,
    $$BatteryInfoEntityTableCreateCompanionBuilder,
    $$BatteryInfoEntityTableUpdateCompanionBuilder,
    (
      BatteryInfoEntityData,
      BaseReferences<_$AppDatabase, $BatteryInfoEntityTable,
          BatteryInfoEntityData>
    ),
    BatteryInfoEntityData,
    PrefetchHooks Function()> {
  $$BatteryInfoEntityTableTableManager(
      _$AppDatabase db, $BatteryInfoEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatteryInfoEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatteryInfoEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatteryInfoEntityTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> time = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<bool> isCharging = const Value.absent(),
            Value<double> voltage = const Value.absent(),
            Value<String> deviceAddress = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BatteryInfoEntityCompanion(
            time: time,
            level: level,
            isCharging: isCharging,
            voltage: voltage,
            deviceAddress: deviceAddress,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime time,
            required int level,
            required bool isCharging,
            required double voltage,
            required String deviceAddress,
            Value<int> rowid = const Value.absent(),
          }) =>
              BatteryInfoEntityCompanion.insert(
            time: time,
            level: level,
            isCharging: isCharging,
            voltage: voltage,
            deviceAddress: deviceAddress,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BatteryInfoEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BatteryInfoEntityTable,
    BatteryInfoEntityData,
    $$BatteryInfoEntityTableFilterComposer,
    $$BatteryInfoEntityTableOrderingComposer,
    $$BatteryInfoEntityTableAnnotationComposer,
    $$BatteryInfoEntityTableCreateCompanionBuilder,
    $$BatteryInfoEntityTableUpdateCompanionBuilder,
    (
      BatteryInfoEntityData,
      BaseReferences<_$AppDatabase, $BatteryInfoEntityTable,
          BatteryInfoEntityData>
    ),
    BatteryInfoEntityData,
    PrefetchHooks Function()>;
typedef $$DeviceInfoEntityTableCreateCompanionBuilder
    = DeviceInfoEntityCompanion Function({
  required DateTime time,
  required String deviceName,
  required String deviceAddress,
  required String hwVersion,
  required String fwVersion,
  Value<int> rowid,
});
typedef $$DeviceInfoEntityTableUpdateCompanionBuilder
    = DeviceInfoEntityCompanion Function({
  Value<DateTime> time,
  Value<String> deviceName,
  Value<String> deviceAddress,
  Value<String> hwVersion,
  Value<String> fwVersion,
  Value<int> rowid,
});

class $$DeviceInfoEntityTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceInfoEntityTable> {
  $$DeviceInfoEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceName => $composableBuilder(
      column: $table.deviceName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hwVersion => $composableBuilder(
      column: $table.hwVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fwVersion => $composableBuilder(
      column: $table.fwVersion, builder: (column) => ColumnFilters(column));
}

class $$DeviceInfoEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceInfoEntityTable> {
  $$DeviceInfoEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceName => $composableBuilder(
      column: $table.deviceName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hwVersion => $composableBuilder(
      column: $table.hwVersion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fwVersion => $composableBuilder(
      column: $table.fwVersion, builder: (column) => ColumnOrderings(column));
}

class $$DeviceInfoEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceInfoEntityTable> {
  $$DeviceInfoEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get deviceName => $composableBuilder(
      column: $table.deviceName, builder: (column) => column);

  GeneratedColumn<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => column);

  GeneratedColumn<String> get hwVersion =>
      $composableBuilder(column: $table.hwVersion, builder: (column) => column);

  GeneratedColumn<String> get fwVersion =>
      $composableBuilder(column: $table.fwVersion, builder: (column) => column);
}

class $$DeviceInfoEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DeviceInfoEntityTable,
    DeviceInfoEntityData,
    $$DeviceInfoEntityTableFilterComposer,
    $$DeviceInfoEntityTableOrderingComposer,
    $$DeviceInfoEntityTableAnnotationComposer,
    $$DeviceInfoEntityTableCreateCompanionBuilder,
    $$DeviceInfoEntityTableUpdateCompanionBuilder,
    (
      DeviceInfoEntityData,
      BaseReferences<_$AppDatabase, $DeviceInfoEntityTable,
          DeviceInfoEntityData>
    ),
    DeviceInfoEntityData,
    PrefetchHooks Function()> {
  $$DeviceInfoEntityTableTableManager(
      _$AppDatabase db, $DeviceInfoEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceInfoEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceInfoEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceInfoEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> time = const Value.absent(),
            Value<String> deviceName = const Value.absent(),
            Value<String> deviceAddress = const Value.absent(),
            Value<String> hwVersion = const Value.absent(),
            Value<String> fwVersion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DeviceInfoEntityCompanion(
            time: time,
            deviceName: deviceName,
            deviceAddress: deviceAddress,
            hwVersion: hwVersion,
            fwVersion: fwVersion,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime time,
            required String deviceName,
            required String deviceAddress,
            required String hwVersion,
            required String fwVersion,
            Value<int> rowid = const Value.absent(),
          }) =>
              DeviceInfoEntityCompanion.insert(
            time: time,
            deviceName: deviceName,
            deviceAddress: deviceAddress,
            hwVersion: hwVersion,
            fwVersion: fwVersion,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DeviceInfoEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DeviceInfoEntityTable,
    DeviceInfoEntityData,
    $$DeviceInfoEntityTableFilterComposer,
    $$DeviceInfoEntityTableOrderingComposer,
    $$DeviceInfoEntityTableAnnotationComposer,
    $$DeviceInfoEntityTableCreateCompanionBuilder,
    $$DeviceInfoEntityTableUpdateCompanionBuilder,
    (
      DeviceInfoEntityData,
      BaseReferences<_$AppDatabase, $DeviceInfoEntityTable,
          DeviceInfoEntityData>
    ),
    DeviceInfoEntityData,
    PrefetchHooks Function()>;
typedef $$ErrorCodeEntityTableCreateCompanionBuilder = ErrorCodeEntityCompanion
    Function({
  required DateTime time,
  required int imuSensor,
  required int magSensor,
  required int batteryMonitor,
  required int pressureSensor,
  required String deviceAddress,
  Value<int> rowid,
});
typedef $$ErrorCodeEntityTableUpdateCompanionBuilder = ErrorCodeEntityCompanion
    Function({
  Value<DateTime> time,
  Value<int> imuSensor,
  Value<int> magSensor,
  Value<int> batteryMonitor,
  Value<int> pressureSensor,
  Value<String> deviceAddress,
  Value<int> rowid,
});

class $$ErrorCodeEntityTableFilterComposer
    extends Composer<_$AppDatabase, $ErrorCodeEntityTable> {
  $$ErrorCodeEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get imuSensor => $composableBuilder(
      column: $table.imuSensor, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get magSensor => $composableBuilder(
      column: $table.magSensor, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get batteryMonitor => $composableBuilder(
      column: $table.batteryMonitor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pressureSensor => $composableBuilder(
      column: $table.pressureSensor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => ColumnFilters(column));
}

class $$ErrorCodeEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $ErrorCodeEntityTable> {
  $$ErrorCodeEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get imuSensor => $composableBuilder(
      column: $table.imuSensor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get magSensor => $composableBuilder(
      column: $table.magSensor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get batteryMonitor => $composableBuilder(
      column: $table.batteryMonitor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pressureSensor => $composableBuilder(
      column: $table.pressureSensor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress,
      builder: (column) => ColumnOrderings(column));
}

class $$ErrorCodeEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $ErrorCodeEntityTable> {
  $$ErrorCodeEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<int> get imuSensor =>
      $composableBuilder(column: $table.imuSensor, builder: (column) => column);

  GeneratedColumn<int> get magSensor =>
      $composableBuilder(column: $table.magSensor, builder: (column) => column);

  GeneratedColumn<int> get batteryMonitor => $composableBuilder(
      column: $table.batteryMonitor, builder: (column) => column);

  GeneratedColumn<int> get pressureSensor => $composableBuilder(
      column: $table.pressureSensor, builder: (column) => column);

  GeneratedColumn<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => column);
}

class $$ErrorCodeEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ErrorCodeEntityTable,
    ErrorCodeEntityData,
    $$ErrorCodeEntityTableFilterComposer,
    $$ErrorCodeEntityTableOrderingComposer,
    $$ErrorCodeEntityTableAnnotationComposer,
    $$ErrorCodeEntityTableCreateCompanionBuilder,
    $$ErrorCodeEntityTableUpdateCompanionBuilder,
    (
      ErrorCodeEntityData,
      BaseReferences<_$AppDatabase, $ErrorCodeEntityTable, ErrorCodeEntityData>
    ),
    ErrorCodeEntityData,
    PrefetchHooks Function()> {
  $$ErrorCodeEntityTableTableManager(
      _$AppDatabase db, $ErrorCodeEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ErrorCodeEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ErrorCodeEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ErrorCodeEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> time = const Value.absent(),
            Value<int> imuSensor = const Value.absent(),
            Value<int> magSensor = const Value.absent(),
            Value<int> batteryMonitor = const Value.absent(),
            Value<int> pressureSensor = const Value.absent(),
            Value<String> deviceAddress = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ErrorCodeEntityCompanion(
            time: time,
            imuSensor: imuSensor,
            magSensor: magSensor,
            batteryMonitor: batteryMonitor,
            pressureSensor: pressureSensor,
            deviceAddress: deviceAddress,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime time,
            required int imuSensor,
            required int magSensor,
            required int batteryMonitor,
            required int pressureSensor,
            required String deviceAddress,
            Value<int> rowid = const Value.absent(),
          }) =>
              ErrorCodeEntityCompanion.insert(
            time: time,
            imuSensor: imuSensor,
            magSensor: magSensor,
            batteryMonitor: batteryMonitor,
            pressureSensor: pressureSensor,
            deviceAddress: deviceAddress,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ErrorCodeEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ErrorCodeEntityTable,
    ErrorCodeEntityData,
    $$ErrorCodeEntityTableFilterComposer,
    $$ErrorCodeEntityTableOrderingComposer,
    $$ErrorCodeEntityTableAnnotationComposer,
    $$ErrorCodeEntityTableCreateCompanionBuilder,
    $$ErrorCodeEntityTableUpdateCompanionBuilder,
    (
      ErrorCodeEntityData,
      BaseReferences<_$AppDatabase, $ErrorCodeEntityTable, ErrorCodeEntityData>
    ),
    ErrorCodeEntityData,
    PrefetchHooks Function()>;
typedef $$MagneticEntityTableCreateCompanionBuilder = MagneticEntityCompanion
    Function({
  required DateTime time,
  required int x,
  required int y,
  required int z,
  required String deviceAddress,
  required int msgIndex,
  Value<int> rowid,
});
typedef $$MagneticEntityTableUpdateCompanionBuilder = MagneticEntityCompanion
    Function({
  Value<DateTime> time,
  Value<int> x,
  Value<int> y,
  Value<int> z,
  Value<String> deviceAddress,
  Value<int> msgIndex,
  Value<int> rowid,
});

class $$MagneticEntityTableFilterComposer
    extends Composer<_$AppDatabase, $MagneticEntityTable> {
  $$MagneticEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get z => $composableBuilder(
      column: $table.z, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get msgIndex => $composableBuilder(
      column: $table.msgIndex, builder: (column) => ColumnFilters(column));
}

class $$MagneticEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $MagneticEntityTable> {
  $$MagneticEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get z => $composableBuilder(
      column: $table.z, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get msgIndex => $composableBuilder(
      column: $table.msgIndex, builder: (column) => ColumnOrderings(column));
}

class $$MagneticEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $MagneticEntityTable> {
  $$MagneticEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<int> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<int> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<int> get z =>
      $composableBuilder(column: $table.z, builder: (column) => column);

  GeneratedColumn<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => column);

  GeneratedColumn<int> get msgIndex =>
      $composableBuilder(column: $table.msgIndex, builder: (column) => column);
}

class $$MagneticEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MagneticEntityTable,
    MagneticEntityData,
    $$MagneticEntityTableFilterComposer,
    $$MagneticEntityTableOrderingComposer,
    $$MagneticEntityTableAnnotationComposer,
    $$MagneticEntityTableCreateCompanionBuilder,
    $$MagneticEntityTableUpdateCompanionBuilder,
    (
      MagneticEntityData,
      BaseReferences<_$AppDatabase, $MagneticEntityTable, MagneticEntityData>
    ),
    MagneticEntityData,
    PrefetchHooks Function()> {
  $$MagneticEntityTableTableManager(
      _$AppDatabase db, $MagneticEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MagneticEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MagneticEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MagneticEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> time = const Value.absent(),
            Value<int> x = const Value.absent(),
            Value<int> y = const Value.absent(),
            Value<int> z = const Value.absent(),
            Value<String> deviceAddress = const Value.absent(),
            Value<int> msgIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MagneticEntityCompanion(
            time: time,
            x: x,
            y: y,
            z: z,
            deviceAddress: deviceAddress,
            msgIndex: msgIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime time,
            required int x,
            required int y,
            required int z,
            required String deviceAddress,
            required int msgIndex,
            Value<int> rowid = const Value.absent(),
          }) =>
              MagneticEntityCompanion.insert(
            time: time,
            x: x,
            y: y,
            z: z,
            deviceAddress: deviceAddress,
            msgIndex: msgIndex,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MagneticEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MagneticEntityTable,
    MagneticEntityData,
    $$MagneticEntityTableFilterComposer,
    $$MagneticEntityTableOrderingComposer,
    $$MagneticEntityTableAnnotationComposer,
    $$MagneticEntityTableCreateCompanionBuilder,
    $$MagneticEntityTableUpdateCompanionBuilder,
    (
      MagneticEntityData,
      BaseReferences<_$AppDatabase, $MagneticEntityTable, MagneticEntityData>
    ),
    MagneticEntityData,
    PrefetchHooks Function()>;
typedef $$TimestampEntityTableCreateCompanionBuilder = TimestampEntityCompanion
    Function({
  required DateTime time,
  required DateTime timeValue,
  required String deviceAddress,
  Value<int> rowid,
});
typedef $$TimestampEntityTableUpdateCompanionBuilder = TimestampEntityCompanion
    Function({
  Value<DateTime> time,
  Value<DateTime> timeValue,
  Value<String> deviceAddress,
  Value<int> rowid,
});

class $$TimestampEntityTableFilterComposer
    extends Composer<_$AppDatabase, $TimestampEntityTable> {
  $$TimestampEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeValue => $composableBuilder(
      column: $table.timeValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => ColumnFilters(column));
}

class $$TimestampEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $TimestampEntityTable> {
  $$TimestampEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeValue => $composableBuilder(
      column: $table.timeValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress,
      builder: (column) => ColumnOrderings(column));
}

class $$TimestampEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimestampEntityTable> {
  $$TimestampEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<DateTime> get timeValue =>
      $composableBuilder(column: $table.timeValue, builder: (column) => column);

  GeneratedColumn<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => column);
}

class $$TimestampEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimestampEntityTable,
    TimestampEntityData,
    $$TimestampEntityTableFilterComposer,
    $$TimestampEntityTableOrderingComposer,
    $$TimestampEntityTableAnnotationComposer,
    $$TimestampEntityTableCreateCompanionBuilder,
    $$TimestampEntityTableUpdateCompanionBuilder,
    (
      TimestampEntityData,
      BaseReferences<_$AppDatabase, $TimestampEntityTable, TimestampEntityData>
    ),
    TimestampEntityData,
    PrefetchHooks Function()> {
  $$TimestampEntityTableTableManager(
      _$AppDatabase db, $TimestampEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimestampEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimestampEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimestampEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> time = const Value.absent(),
            Value<DateTime> timeValue = const Value.absent(),
            Value<String> deviceAddress = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimestampEntityCompanion(
            time: time,
            timeValue: timeValue,
            deviceAddress: deviceAddress,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime time,
            required DateTime timeValue,
            required String deviceAddress,
            Value<int> rowid = const Value.absent(),
          }) =>
              TimestampEntityCompanion.insert(
            time: time,
            timeValue: timeValue,
            deviceAddress: deviceAddress,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TimestampEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TimestampEntityTable,
    TimestampEntityData,
    $$TimestampEntityTableFilterComposer,
    $$TimestampEntityTableOrderingComposer,
    $$TimestampEntityTableAnnotationComposer,
    $$TimestampEntityTableCreateCompanionBuilder,
    $$TimestampEntityTableUpdateCompanionBuilder,
    (
      TimestampEntityData,
      BaseReferences<_$AppDatabase, $TimestampEntityTable, TimestampEntityData>
    ),
    TimestampEntityData,
    PrefetchHooks Function()>;
typedef $$PressureEntityTableCreateCompanionBuilder = PressureEntityCompanion
    Function({
  required DateTime time,
  required String deviceAddress,
  required String voltages,
  Value<int> rowid,
});
typedef $$PressureEntityTableUpdateCompanionBuilder = PressureEntityCompanion
    Function({
  Value<DateTime> time,
  Value<String> deviceAddress,
  Value<String> voltages,
  Value<int> rowid,
});

class $$PressureEntityTableFilterComposer
    extends Composer<_$AppDatabase, $PressureEntityTable> {
  $$PressureEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get voltages => $composableBuilder(
      column: $table.voltages, builder: (column) => ColumnFilters(column));
}

class $$PressureEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $PressureEntityTable> {
  $$PressureEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get voltages => $composableBuilder(
      column: $table.voltages, builder: (column) => ColumnOrderings(column));
}

class $$PressureEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $PressureEntityTable> {
  $$PressureEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => column);

  GeneratedColumn<String> get voltages =>
      $composableBuilder(column: $table.voltages, builder: (column) => column);
}

class $$PressureEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PressureEntityTable,
    PressureEntityData,
    $$PressureEntityTableFilterComposer,
    $$PressureEntityTableOrderingComposer,
    $$PressureEntityTableAnnotationComposer,
    $$PressureEntityTableCreateCompanionBuilder,
    $$PressureEntityTableUpdateCompanionBuilder,
    (
      PressureEntityData,
      BaseReferences<_$AppDatabase, $PressureEntityTable, PressureEntityData>
    ),
    PressureEntityData,
    PrefetchHooks Function()> {
  $$PressureEntityTableTableManager(
      _$AppDatabase db, $PressureEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PressureEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PressureEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PressureEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> time = const Value.absent(),
            Value<String> deviceAddress = const Value.absent(),
            Value<String> voltages = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PressureEntityCompanion(
            time: time,
            deviceAddress: deviceAddress,
            voltages: voltages,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime time,
            required String deviceAddress,
            required String voltages,
            Value<int> rowid = const Value.absent(),
          }) =>
              PressureEntityCompanion.insert(
            time: time,
            deviceAddress: deviceAddress,
            voltages: voltages,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PressureEntityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PressureEntityTable,
    PressureEntityData,
    $$PressureEntityTableFilterComposer,
    $$PressureEntityTableOrderingComposer,
    $$PressureEntityTableAnnotationComposer,
    $$PressureEntityTableCreateCompanionBuilder,
    $$PressureEntityTableUpdateCompanionBuilder,
    (
      PressureEntityData,
      BaseReferences<_$AppDatabase, $PressureEntityTable, PressureEntityData>
    ),
    PressureEntityData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ImuEntityTableTableManager get imuEntity =>
      $$ImuEntityTableTableManager(_db, _db.imuEntity);
  $$BatteryInfoEntityTableTableManager get batteryInfoEntity =>
      $$BatteryInfoEntityTableTableManager(_db, _db.batteryInfoEntity);
  $$DeviceInfoEntityTableTableManager get deviceInfoEntity =>
      $$DeviceInfoEntityTableTableManager(_db, _db.deviceInfoEntity);
  $$ErrorCodeEntityTableTableManager get errorCodeEntity =>
      $$ErrorCodeEntityTableTableManager(_db, _db.errorCodeEntity);
  $$MagneticEntityTableTableManager get magneticEntity =>
      $$MagneticEntityTableTableManager(_db, _db.magneticEntity);
  $$TimestampEntityTableTableManager get timestampEntity =>
      $$TimestampEntityTableTableManager(_db, _db.timestampEntity);
  $$PressureEntityTableTableManager get pressureEntity =>
      $$PressureEntityTableTableManager(_db, _db.pressureEntity);
}
