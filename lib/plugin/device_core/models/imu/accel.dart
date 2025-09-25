class Accel {
  String address;
  DateTime time;
  final int x;
  final int y;
  final int z;

  Accel({
    required this.address,
    required this.time,
    required this.x,
    required this.y,
    required this.z,
  });

  static List<Accel> fromMapToAccList(dynamic map) {
    final List<Accel> accList = [];

    for (var i = 0; i < map['x'].length; i++) {
      final acc = Accel(
        address: map['address'],
        time: map['epoch'],
        x: map['x'][i],
        y: map['y'][i],
        z: map['z'][i],
      );
      accList.add(acc);
    }

    return accList;
  }
}
