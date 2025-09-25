import 'dart:ui';

enum LocaleEnum {
  vi('vi'),
  en('en');

  final String value;
  const LocaleEnum(this.value);

  static final Map<String, LocaleEnum> byStr = {};

  static LocaleEnum? getByString(String code) {
    if (byStr.isEmpty) {
      for (LocaleEnum status in LocaleEnum.values) {
        byStr[status.value] = status;
      }
    }

    return byStr[code];
  }

  Locale get getLocale {
    switch (this) {
      case vi:
        return Locale(LocaleEnum.vi.value);
      case en:
        return Locale(LocaleEnum.en.value);
      default:
        return Locale(LocaleEnum.en.value);
    }
  }

  String get getValueForDateTimeFormat {
    switch (this) {
      case vi:
        return 'vi';
      case en:
        return 'en';
    }
  }
}
