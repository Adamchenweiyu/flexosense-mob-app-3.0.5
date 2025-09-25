import 'package:flutter/material.dart';

class AppColors {
  static Color white = HexColor.fromHex("#FFFFFF");

  static Color primaryBase = HexColor.fromHex("#2A56BD");
  static Color primaryLight = HexColor.fromHex("#6089DB");
  static Color primaryLighter = HexColor.fromHex("#ADC5F0");
  static Color primaryLightest = HexColor.fromHex("#E6EFFF");

  static Color blueBase = HexColor.fromHex("##007DD6");
  static Color blueDarker = HexColor.fromHex("#055085");

  static Color coalBase = HexColor.fromHex("#8E939E");
  static Color coalLight = HexColor.fromHex("#C0C5D1");
  static Color coalLighter = HexColor.fromHex("#D8DCE5");
  static Color coalDarker = HexColor.fromHex("#3A3D42");
  static Color coalDarkest = HexColor.fromHex("#282A2E");

  static Color black1 = HexColor.fromHex("#16191C");
  static Color grey1 = HexColor.fromHex("#AEAEAE");
  static Color grey2 = HexColor.fromHex("#F1F1F1");

  static Color fogBackground = HexColor.fromHex("#F5F6FA");

  static Color systemErrorPrimary = HexColor.fromHex("#E12424");

  static Color greyScale = HexColor.fromHex("#8492A6");
  static Color blackSecondary = HexColor.fromHex("#262626");
  static Color secondaryBlack1 = HexColor.fromHex("#8C8C8C");
  static Color secondaryBlack2 = HexColor.fromHex("#595959");

  static Color redBase = HexColor.fromHex("#D62F2F");
  static Color redLight = HexColor.fromHex("#EB7A7A");
  static Color semanticRed = HexColor.fromHex("#F63F3F");
  static Color semanticRed3 = HexColor.fromHex("#F63F3F");

  static Color semanticOrange = HexColor.fromHex("#EB7844");
  static Color semanticOrange4 = HexColor.fromHex("#EB7844").withOpacity(0.4);
  static Color semanticOrange5 = HexColor.fromHex("#F5B89A").withOpacity(0.5);

  static Color semanticYellow = HexColor.fromHex("#FFBC3F");
  static Color semanticYellow3 = HexColor.fromHex("#FFBC3F");

  static Color greenBase = HexColor.fromHex("#25B84C");
  static Color semanticGreen = HexColor.fromHex("#61E76A");
  static Color semanticGreen4 = HexColor.fromHex("#45C75B");
  static Color semanticGreen3 = HexColor.fromHex("#61E76A");

  static Color semanticBlue = HexColor.fromHex("#36B1FF");
  static Color semanticBlue3 = HexColor.fromHex("#36B1FF");
  static Color semanticBlue4 = HexColor.fromHex("#1D70C6");

  static Color neutral = HexColor.fromHex("#F0F0F0");
  static Color neutral2 = HexColor.fromHex("#F5F5F5");

  static Color blackSecondary1 = HexColor.fromHex("#8C8C8C");
  static Color blackSecondary2 = HexColor.fromHex("#595959");
  static Color blackSecondary3 = HexColor.fromHex("#454545");
  static Color blackSecondary4 = HexColor.fromHex("#262626");
  static Color blackSecondary5 = HexColor.fromHex("#1F1F1F");

  static Color boxShadow = HexColor.fromHex("#F4F6FA");
  static Color divider = HexColor.fromHex("#221C19").withOpacity(0.2);
  static Color neutral3 = HexColor.fromHex("#F0F0F0");
  static Color neutral4 = HexColor.fromHex("#D9D9D9");

  static Color primaryBlue2 = HexColor.fromHex("#99C2FF");
  static Color primaryBlue3 = HexColor.fromHex("#4C94FF");
  static Color primaryBlue4 = HexColor.fromHex("#0067FF");
  static Color primaryBlue5 = HexColor.fromHex("#004CBB");

  static Color gradientColor = HexColor.fromHex("#F0F7FF");
}

extension HexColor on Color {
  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = "FF$hex"; // 8 char with opacity 100%
    }
    return Color(int.parse(hex, radix: 16));
  }
}
