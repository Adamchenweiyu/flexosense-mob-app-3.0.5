import 'package:flex_sense/plugin/device_core/enum/event_enum.dart';
import 'package:flex_sense/plugin/device_core/models/imu/accel.dart';
import 'package:flex_sense/plugin/device_core/models/battery_info.dart';
import 'package:flex_sense/plugin/device_core/models/connected_device.dart';
import 'package:flex_sense/plugin/device_core/models/device_info.dart';
import 'package:flex_sense/plugin/device_core/models/error_code.dart';
import 'package:flex_sense/plugin/device_core/models/found_device.dart';
import 'package:flex_sense/plugin/device_core/models/imu/gyros.dart';
import 'package:flex_sense/plugin/device_core/models/imu/imu.dart';
import 'package:flex_sense/plugin/device_core/models/magnetic.dart';
import 'package:flex_sense/plugin/device_core/models/pressure.dart';
import 'package:flex_sense/plugin/device_core/models/imu/roll_pitch_yaw.dart';
import 'package:flex_sense/plugin/device_core/models/timestamp.dart';

class DeviceEventTask {
  final EventEnum? event;
  final dynamic data;

  DeviceEventTask({
    this.event,
    required this.data,
  });

  @override
  String toString() => 'DeviceEventTask(event: $event, data: $data)';

  FoundDevice toScannedDevice() {
    return FoundDevice.fromMap(data);
  }

  ConnectedDevice toConnectedDevice() {
    return ConnectedDevice.fromMap(data);
  }

  DeviceInfo toDeviceInfo() {
    return DeviceInfo.fromMap(data);
  }

  ErrorCode toErrorCode() {
    return ErrorCode.fromMap(data);
  }

  BatteryInfo toBatteryInfo() {
    return BatteryInfo.fromMap(data);
  }

  TimeStamp toTimeStamp() {
    return TimeStamp.fromMap(data);
  }

  List<Imu> toImuListView(DateTime time) {
    return Imu.fromMapToImuListView(data, time);
  }

    List<Imu> toImuListSave(DateTime time) {
    return Imu.fromMapToImuListSave(data, time);
  }

  List<Magnetic> toMagneticListView(DateTime time) {
    return Magnetic.fromMapToMagneticListView(data, time);
  }

  List<Magnetic> toMagneticListSave(DateTime time) {
    return Magnetic.fromMapToMagneticListSave(data, time);
  }

  List<RollPitchYaw> toRollPitchYawList() {
    return RollPitchYaw.fromMapToRollPitchYawList(data);
  }

  Pressure toPressure() {
    return Pressure.fromRawValue(data);
  }
}
