// ignore_for_file: public_member_api_docs, sort_constructors_first
class ErrorCode {
  final int imuSensor;
  final int magSensor;
  final int batteryMonitor;
  final int pressureSensor;
  final int wrongSide;

  ErrorCode({
    required this.imuSensor,
    required this.magSensor,
    required this.batteryMonitor,
    required this.pressureSensor,
    required this.wrongSide,
  });

  static ErrorCode fromMap(dynamic map) {
    return ErrorCode(
      imuSensor: map['imuSensor'],
      magSensor: map['magSensor'],
      batteryMonitor: map['batteryMonitor'],
      pressureSensor: map['pressureSensor'],
      wrongSide: map['wrongSide'],
    );
  }
}
