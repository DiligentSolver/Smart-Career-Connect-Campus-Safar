import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/theme/custom_themes/appbar_theme.dart';
import 'package:campus_safar/utils/theme/custom_themes/bottomsheet_theme.dart';
import 'package:campus_safar/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:campus_safar/utils/theme/custom_themes/chip_theme.dart';
import 'package:campus_safar/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:campus_safar/utils/theme/custom_themes/text_theme.dart';
import 'package:campus_safar/utils/theme/custom_themes/textformfield_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CSAppTheme {
  CSAppTheme._();

  ///Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "GoogleFonts",
    brightness: Brightness.light,
    primaryColor: CSColors.firstColor,
    appBarTheme: CSAppBarTheme.lightAppBarTheme,
    scaffoldBackgroundColor: CSColors.lightBg,
    textTheme: CSTextTheme.lightTextTheme,
    chipTheme: CSChipTheme.lightChipTheme,
    bottomSheetTheme: CSBottomSheetTheme.lightBottomSheetTheme,
    inputDecorationTheme: CSTextFormFieldTheme.lightInputDecorationTheme,
    elevatedButtonTheme: CSElevatedButtonTheme.lightElevatedButtonTheme,
    checkboxTheme: CSCheckBoxTheme.lightCheckBoxTheme,
  );

  ///Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "GoogleFonts",
    brightness: Brightness.dark,
    primaryColor: CSColors.firstColor,
    appBarTheme: CSAppBarTheme.darkAppBarTheme,
    scaffoldBackgroundColor: CSColors.darkThemeBg,
    textTheme: CSTextTheme.darkTextTheme,
    chipTheme: CSChipTheme.darkChipTheme,
    bottomSheetTheme: CSBottomSheetTheme.darkBottomSheetTheme,
    inputDecorationTheme: CSTextFormFieldTheme.darkInputDecorationTheme,
    elevatedButtonTheme: CSElevatedButtonTheme.darkElevatedButtonTheme,
    checkboxTheme: CSCheckBoxTheme.darkCheckBoxTheme,
  );
}
