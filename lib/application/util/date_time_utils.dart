import 'package:intl/intl.dart';

class DateTimeUtils {}

extension DateTimeUtilsExtension on DateTime {
  String get toFileFormattedDate {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return formatter.format(this).replaceAll(':', '_');
  }

  bool isExpiredToken() {
    final time = subtract(const Duration(seconds: 10));
    return time.isBefore(DateTime.now());
  }
}
