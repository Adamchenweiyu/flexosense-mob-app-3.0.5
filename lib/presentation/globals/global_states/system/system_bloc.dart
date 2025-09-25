import 'dart:ui';

import 'package:flex_sense/presentation/base_bloc/base_cubit.dart';
import 'package:flex_sense/presentation/l10n/locale_enum.dart';
import 'package:flex_sense/presentation/globals/global_states/system/system_state.dart';

/// SystemBloc is a global state management class that manages the system state.
/// It is used to manage the system state such as the current locale.
class SystemBloc extends BaseCubit<SystemState> {
  SystemBloc({
    required Locale locale,
  }) : super(SystemState());

  static LocaleEnum currentLocaleStatic = LocaleEnum.en;

    void changeLocaleData(LocaleEnum locale) {
    currentLocaleStatic = locale;
    // SharedPref.setCurrentLocale(locale.name);
    emit(state.copyWith(currentLocale: locale));
  }

}
