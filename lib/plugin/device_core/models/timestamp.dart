class TimeStamp {
  final DateTime time;

  TimeStamp({
    required this.time,
  });

  static TimeStamp fromMap(dynamic map) {
    final epoch = map['epoch'] as int;
    final time = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return TimeStamp(time: time);
  }
}
