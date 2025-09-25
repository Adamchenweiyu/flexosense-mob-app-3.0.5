class FoundDevice {
  final String? name;
  final String address;

  FoundDevice({
    this.name,
    required this.address,
  });

  static FoundDevice fromMap(dynamic map) {
    return FoundDevice(
      name: map['name'],
      address: map['address'],
    );
  }
}
