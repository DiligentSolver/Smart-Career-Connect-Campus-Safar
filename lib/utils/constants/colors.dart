import 'package:flutter/material.dart';

class CSColors {
  CSColors._();

  // App Basic Colors
  static const Color firstColor = Color(0xFF133C55);
  static const Color secondColor = Color(0xFF386FA4);
  static const Color thirdColor = Color(0xFF59A5D8);
  static const Color fourthColor = Color(0xFF84D2F6);
  static const Color fifthColor = Color(0xFF91E5F6);

  //Text colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color shadow = Color(0x40000000);
  static const Color golden = Color(0xFFffd700);
  static const Color hyperlinkUnvisited = Color(0xFF0000EE);
  static const Color hyperlinkVisited = Color(0xFF551A8B);

  //Gradient Colors
  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xFF133C55),
        Color(0xFF386FA4),
        Color(0xFF59A5D8),
      ]);

  //Background Colors
  static const Color transparent = Colors.transparent;
  static const Color onBoardingLightBg = Color(0xFFF1F4F8);
  static const Color onBoardingDarkBg = Color(0x0001d97c);
  static const Color darkThemeBg = Color(0xFF121B22);
  static const Color darkBg = Color(0xFF272727);
  static const Color lightBg = Color(0xFFF6F6F6);

  //Background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = CSColors.white.withOpacity(0.1);

  // Student Dashboard's Card extra colors
  static const Color pinkCard = Colors.pinkAccent;
  static const Color yellowishCard = Colors.amberAccent;
  static const Color white70 = Colors.white70;
  static Color card1 = const Color(0xFFFCCF31).withOpacity(0.8);
  static Color card2 = const Color(0xFF43CBFF).withOpacity(0.8);
  static Color card3 = const Color(0xFFF97794).withOpacity(0.8);
  static Color card4 = const Color(0xFFF05F57).withOpacity(0.8);

  //Student's Dashboard card shadow color
  static const Color lightCardShadowColor = CSColors.black;
  static const Color darkCardShadowColor = CSColors.golden;

  //light shade
  static const fifthColorShade = Color(0xFFDFFAFF);
  static const redShade = Color(0xFFFF4848);
  static const redLightShade = Color(0xFFFF8484);
  static const greenShade = Color(0xFF85FF88);

  //Background Container Colors
  //Button Colors
  //Border Colors
  static const borderPrimary = Color(0xFFD90909);
  static const borderSecondary = Color(0xFFE6E6E6);
  //Error Colors
  //Error and Validation Colors
  //Neutral Shades
  static const darkGrey = Color(0xFF939393);
  static const darkerGrey = Color(0xFF4F4F4F);
}
