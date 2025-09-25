import 'package:flex_sense/application/constants/ble_constant.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';

class Magnetic {
  final String address;
  final DateTime time;
  final int x;
  final int y;
  final int z;

  Magnetic({
    required this.address,
    required this.time,
    required this.x,
    required this.y,
    required this.z,
  });

  static DateTime? _timeView;
  static DateTime? _timeSave;

  static List<Magnetic> _generateMagneticList(dynamic map, DateTime initialTime, bool isView) {
    List<Magnetic> magneticList = [];
    DateTime? lastTime = isView ? _timeView : _timeSave;

    for (var i = 0; i < map['x'].length; i++) {
      lastTime = (lastTime ?? initialTime).add(const Duration(milliseconds: BleConstant.magneticSampleCycle));
      lastTime = DateTime(lastTime.year, lastTime.month, lastTime.day, lastTime.hour, lastTime.minute, lastTime.second, lastTime.millisecond);

      magneticList.add(Magnetic(
        address: map['address'],
        time: lastTime,
        x: map['x'][i],
        y: map['y'][i],
        z: map['z'][i],
      ));
    }

    if (isView) {
      _timeView = lastTime;
    } else {
      _timeSave = lastTime;
    }

    return magneticList;
  }

  static List<Magnetic> fromMapToMagneticListView(dynamic map, DateTime time) {
    return _generateMagneticList(map, time, true);
  }

  static List<Magnetic> fromMapToMagneticListSave(dynamic map, DateTime time) {
    return _generateMagneticList(map, time, false);
  }

  static void resetTime() {
    _timeSave = null;
    _timeView = null;
  }

  MagneticEntityData toMagneticEntityData() {
    return MagneticEntityData(
      deviceAddress: address,
      time: time,
      x: x,
      y: y,
      z: z,
    );
  }
}
