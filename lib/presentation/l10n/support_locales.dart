import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flex_sense/presentation/l10n/locale_enum.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final supportLocales = [
  Locale(LocaleEnum.vi.value), // Vietnamese
  Locale(LocaleEnum.en.value), // English
];

final localeDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
