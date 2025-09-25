import 'package:flex_sense/application/resource/colors/app_colors.dart';
import 'package:flex_sense/application/resource/fonts/app_font.dart';
import 'package:flex_sense/application/resource/styles/app_text_style.dart';
import 'package:flex_sense/application/resource/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeApp {
  static ThemeData getTheme() {
    return ThemeData(
        // main colors
        colorScheme: ColorScheme.fromSwatch(
          errorColor: AppColors.systemErrorPrimary,
          accentColor: AppColors.primaryBase,
          backgroundColor: AppColors.white,
          cardColor: AppColors.white,
        ),
        primaryColorLight: AppColors.primaryBase,
        canvasColor: AppColors.white,
        disabledColor: AppColors.primaryLight,
        // ripple color
        splashColor: AppColors.coalLighter,
        //App bar
        appBarTheme: _appBarTheme(),
        pageTransitionsTheme: _pageTransitionsTheme(),
        textButtonTheme: _textButtonThemeData(),
        // Elevated Button
        elevatedButtonTheme: _elevatedButtonThemeData(),
        //Outline Button
        outlinedButtonTheme: _outlinedButtonTheme(),
        filledButtonTheme: _filledButtonTheme(),
        // Text theme
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.primaryLight,
            selectionColor: AppColors.primaryLight,
            selectionHandleColor: AppColors.primaryLight),
        // input decoration theme (text form field)
        inputDecorationTheme: _inputDecorationTheme());
  }

  static AppBarTheme _appBarTheme() {
    return AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryBase,
            statusBarBrightness: Brightness.dark, //For iOS
            statusBarIconBrightness: Brightness.light //For android
            ),
        centerTitle: true,
        color: AppColors.white,
        elevation: ElevationApp.ev4,
        titleTextStyle: AppTextStyles.bold(color: AppColors.coalDarker, fontSize: AppFontSize.s26));
  }

  static PageTransitionsTheme _pageTransitionsTheme() {
    return const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    });
  }

  static TextButtonThemeData _textButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryBase,
        textStyle: AppTextStyles.bold(color: AppColors.primaryBase, fontSize: AppFontSize.s14),
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: ElevationApp.ev2,
            padding: const EdgeInsets.symmetric(horizontal: PaddingApp.p24),
            fixedSize: const Size(ButtonSizeApp.width, ButtonSizeApp.height),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(BorderRadiusApp.r8)),
            backgroundColor: AppColors.blackSecondary4,
            disabledBackgroundColor: AppColors.primaryLight,
            textStyle: AppTextStyles.bold(color: AppColors.white, fontSize: AppFontSize.s16)));
  }

  static OutlinedButtonThemeData _outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.fogBackground,
        foregroundColor: AppColors.coalDarkest,
        fixedSize: const Size.fromHeight(SizeApp.s44),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BorderRadiusApp.r8),
            side: BorderSide(color: AppColors.coalDarkest, width: BorderWidthApp.w2)),
        side: BorderSide(
          color: AppColors.coalDarkest,
          width: BorderWidthApp.w2,
        ),
        textStyle: AppTextStyles.bold(color: AppColors.coalDarkest),
      ),
    );
  }

  static FilledButtonThemeData _filledButtonTheme() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.blackSecondary4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusApp.r12),
        ),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.all(PaddingApp.p12),
      hintStyle: AppTextStyles.regular(color: AppColors.blackSecondary1, fontSize: AppFontSize.s16)
          .copyWith(letterSpacing: 0),
      labelStyle: AppTextStyles.medium(color: AppColors.greyScale, fontSize: AppFontSize.s14),
      errorStyle: AppTextStyles.regular(color: Colors.transparent, fontSize: AppFontSize.s14),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.coalLighter, width: BorderWidthApp.w1),
          borderRadius: const BorderRadius.all(Radius.circular(BorderRadiusApp.r8))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.coalLight, width: BorderWidthApp.w1),
          borderRadius: const BorderRadius.all(Radius.circular(BorderRadiusApp.r8))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryBlue3, width: BorderWidthApp.w1),
          borderRadius: const BorderRadius.all(Radius.circular(BorderRadiusApp.r8))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redBase, width: BorderWidthApp.w1),
          borderRadius: const BorderRadius.all(Radius.circular(BorderRadiusApp.r8))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redLight, width: BorderWidthApp.w1),
          borderRadius: const BorderRadius.all(Radius.circular(BorderRadiusApp.r8))),
    );
  }
}
