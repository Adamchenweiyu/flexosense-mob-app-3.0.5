// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_sense/plugin/device_core/models/battery_info.dart';
import 'package:flex_sense/plugin/device_core/models/connected_device.dart';
import 'package:flex_sense/plugin/device_core/models/device_info.dart';
import 'package:flex_sense/plugin/device_core/models/error_code.dart';
import 'package:flex_sense/plugin/device_core/models/imu/accel.dart';
import 'package:flex_sense/plugin/device_core/models/imu/gyros.dart';
import 'package:flex_sense/plugin/device_core/models/imu/roll_pitch_yaw.dart';
import 'package:flex_sense/plugin/device_core/models/magnetic.dart';
import 'package:flex_sense/plugin/device_core/models/pressure.dart';
import 'package:flex_sense/plugin/device_core/models/timestamp.dart';

enum DeviceDetailGettingLocalData {
  none,
  imu,
  magnetic,
  pressure,
}

class DeviceDetailState {
  ConnectedDevice? device;
  DeviceInfo? deviceInfo;
  TimeStamp? timeStamp;
  ErrorCode? errorCode;
  BatteryInfo? batteryInfo;
  List<Accel> accelList;
  List<Gyros> gyrosList;
  List<RollPitchYaw> rollPitchYawList;
  List<Magnetic> magneticList;
  List<double> pressureVoltagesList;
  DeviceDetailGettingLocalData gettingLocalData;

  DeviceDetailState({
    this.device,
    this.deviceInfo,
    this.timeStamp,
    this.errorCode,
    this.batteryInfo,
    required this.accelList,
    required this.gyrosList,
    required this.rollPitchYawList,
    required this.magneticList,
    required this.pressureVoltagesList,
    this.gettingLocalData = DeviceDetailGettingLocalData.none,
  });

  DeviceDetailState copyWith({
    ConnectedDevice? device,
    DeviceInfo? deviceInfo,
    TimeStamp? timeStamp,
    ErrorCode? errorCode,
    BatteryInfo? batteryInfo,
    List<Accel>? accelList,
    List<Gyros>? gyrosList,
    List<RollPitchYaw>? rollPitchYawList,
    List<Magnetic>? magneticList,
    List<double>? pressureVoltagesList,
    DeviceDetailGettingLocalData? gettingLocalData,
  }) {
    return DeviceDetailState(
      device: device ?? this.device,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      timeStamp: timeStamp ?? this.timeStamp,
      errorCode: errorCode ?? this.errorCode,
      batteryInfo: batteryInfo ?? this.batteryInfo,
      accelList: accelList ?? this.accelList,
      gyrosList: gyrosList ?? this.gyrosList,
      rollPitchYawList: rollPitchYawList ?? this.rollPitchYawList,
      magneticList: magneticList ?? this.magneticList,
      pressureVoltagesList: pressureVoltagesList ?? this.pressureVoltagesList,
      gettingLocalData: gettingLocalData ?? this.gettingLocalData,
    );
  }
}
