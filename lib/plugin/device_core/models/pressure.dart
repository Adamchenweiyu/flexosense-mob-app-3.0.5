// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';

class Pressure {
  String address;
  DateTime time;
  List<double> voltages;

  Pressure({
    required this.address,
    required this.time,
    required this.voltages,
  });

  static Pressure fromRawValue(dynamic map) {
    DateTime time = DateTime.now();
    time = DateTime(time.year, time.month, time.day, time.hour, time.minute, time.second, time.millisecond);

    return Pressure(
      address: map['address'],
      time: time,
      voltages: List<double>.from(map['voltages']),
    );
  }

  PressureEntityData toPressureEntityData() {
    return PressureEntityData(
      deviceAddress: address,
      time: time,
      voltages: voltages.join(';'),
    );
  }
}
