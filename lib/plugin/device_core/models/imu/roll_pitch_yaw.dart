// ignore_for_file: public_member_api_docs, sort_constructors_first


class RollPitchYaw {
  String address;
  DateTime time;
  final double roll;
  final double pitch;
  final double yaw;

  RollPitchYaw({
    required this.address,
    required this.time,
    required this.roll,
    required this.pitch,
    required this.yaw,
  });

  static List<RollPitchYaw> fromMapToRollPitchYawList(dynamic map) {
    final List<RollPitchYaw> rollPitchYawList = [];
    
    for (var i = 0; i < map['roll'].length; i++) {
      final rollPitchYaw = RollPitchYaw(
        address: map['address'],
        time: DateTime.now(),
        roll: map['roll'][i],
        pitch: map['pitch'][i],
        yaw: map['yaw'][i],
      );
      rollPitchYawList.add(rollPitchYaw);
    }

    return rollPitchYawList;
  }
}
