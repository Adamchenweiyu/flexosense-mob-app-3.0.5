import 'package:flex_sense/application/constants/ble_constant.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/plugin/device_core/models/imu/accel.dart';
import 'package:flex_sense/plugin/device_core/models/imu/gyros.dart';
import 'package:flex_sense/plugin/device_core/models/imu/roll_pitch_yaw.dart';

class Imu {
  final String address;
  final DateTime time;
  final Accel accel;
  final Gyros gyros;
  final RollPitchYaw rollPitchYaw;

  Imu({
    required this.address,
    required this.time,
    required this.accel,
    required this.gyros,
    required this.rollPitchYaw,
  });

  static DateTime? _timeView;
  static DateTime? _timeSave;

  static List<Imu> _generateImuList(dynamic map, DateTime initialTime, bool isView) {
    List<Imu> imuList = [];
    DateTime? lastTime = isView ? _timeView : _timeSave;

    for (var i = 0; i < map['accel']['x'].length; i++) {
      lastTime = (lastTime ?? initialTime).add(const Duration(milliseconds: BleConstant.imuSampleCycle));
      lastTime = DateTime(lastTime.year, lastTime.month, lastTime.day, lastTime.hour, lastTime.minute, lastTime.second, lastTime.millisecond);

      Imu imu = Imu(
        address: map['address'],
        time: lastTime,
        accel: Accel(
          address: map['address'],
          time: lastTime,
          x: map['accel']['x'][i],
          y: map['accel']['y'][i],
          z: map['accel']['z'][i],
        ),
        gyros: Gyros(
          address: map['address'],
          time: lastTime,
          x: map['gyros']['x'][i],
          y: map['gyros']['y'][i],
          z: map['gyros']['z'][i],
        ),
        rollPitchYaw: RollPitchYaw(
          address: map['address'],
          time: lastTime,
          roll: map['rollPitchYaw']['roll'][i],
          pitch: map['rollPitchYaw']['pitch'][i],
          yaw: map['rollPitchYaw']['yaw'][i],
        ),
      );

      imuList.add(imu);
    }

    if (isView) {
      _timeView = lastTime;
    } else {
      _timeSave = lastTime;
    }

    return imuList;
  }

  static List<Imu> fromMapToImuListView(dynamic map, DateTime time) {
    return _generateImuList(map, time, true);
  }

  static List<Imu> fromMapToImuListSave(dynamic map, DateTime time) {
    return _generateImuList(map, time, false);
  }

  static void resetTime() {
    _timeSave = null;
    _timeView = null;
  }

  ImuEntityData toImuEntityData() {
    return ImuEntityData(
      deviceAddress: address,
      time: time,
      accX: accel.x,
      accY: accel.y,
      accZ: accel.z,
      gyrosX: gyros.x,
      gyrosY: gyros.y,
      gyrosZ: gyros.z,
      roll: rollPitchYaw.roll,
      pitch: rollPitchYaw.pitch,
      yaw: rollPitchYaw.yaw,
    );
  }
}
