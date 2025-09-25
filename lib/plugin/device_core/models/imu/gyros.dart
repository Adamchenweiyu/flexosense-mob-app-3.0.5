class Gyros {
  String address;
  DateTime time;
  final int x;
  final int y;
  final int z;

  Gyros({
    required this.address,
    required this.time,
    required this.x,
    required this.y,
    required this.z,
  });

  static List<Gyros> fromMapToGyrosList(dynamic map) {
    final List<Gyros> gyrosList = [];
    for (var i = 0; i < map['x'].length; i++) {
      final gyros = Gyros(
        address: map['address'],
        time: DateTime.now(),
        x: map['x'][i],
        y: map['y'][i],
        z: map['z'][i],
      );
      gyrosList.add(gyros);
    }

    return gyrosList;
  }
}
