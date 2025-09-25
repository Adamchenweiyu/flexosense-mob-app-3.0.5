import 'package:flex_sense/presentation/l10n/locale_enum.dart';

class SystemState {
  LocaleEnum currentLocale;

  SystemState({
    this.currentLocale = LocaleEnum.en,
  });

  SystemState copyWith({
    LocaleEnum? currentLocale,
  }) {
    return SystemState(
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }
}
