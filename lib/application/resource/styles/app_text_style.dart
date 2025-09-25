import 'package:flex_sense/application/resource/fonts/app_font.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  ///weight: 300
  static TextStyle light({
    double fontSize = 14.0,
    required Color color,
    String fontFamily = AppFontFamily.fontFamilyOpenSans,
    double? lineHeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: AppFontWeight.light,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  ///weight: 400
  static TextStyle regular({
    double fontSize = 16.0,
    required Color color,
    String fontFamily = AppFontFamily.fontFamilyOpenSans,
    double? lineHeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: AppFontWeight.regular,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  ///weight: 500
  static TextStyle medium({
    double fontSize = 16.0,
    required Color color,
    String fontFamily = AppFontFamily.fontFamilyOpenSans,
    double? lineHeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: AppFontWeight.medium,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  ///weight: 600
  static TextStyle semiBold({
    double fontSize = 18.0,
    required Color color,
    String fontFamily = AppFontFamily.fontFamilyOpenSans,
    double? lineHeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: AppFontWeight.semibold,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  ///weight: 700
  static TextStyle bold({
    double fontSize = 18.0,
    required Color color,
    String fontFamily = AppFontFamily.fontFamilyOpenSans,
    double? lineHeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: AppFontWeight.bold,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }
}
