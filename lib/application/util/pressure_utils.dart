import 'package:flex_sense/data/data_source/local/drift/app_database.dart';

class PressureWithIndex {
  final DateTime? time;
  final int index;
  final double voltage;

  PressureWithIndex({
    this.time,
    required this.index,
    required this.voltage,
  });
}

class PressureUtils {
  static List<PressureWithIndex> convertEntityToPressureWithIndex(List<PressureEntityData> data) {
    List<PressureWithIndex> pressureWithIndexes = [];

    for (var i = 0; i < data.length; i++) {
      final element = data[i];
      final voltages = element.voltages.split(';').map((s) => double.parse(s)).toList();
      for (var j = 0; j < voltages.length; j++) {
        final pressureWithIndex =
            PressureWithIndex(index: j, voltage: voltages[j], time: element.time);
        pressureWithIndexes.add(pressureWithIndex);
      }
    }

    return pressureWithIndexes;
  }
}
