import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

// ---Light & Dark Elevated Button Themes
class CSElevatedButtonTheme {
  CSElevatedButtonTheme._();

  /// --Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: CSColors.white,
    backgroundColor: CSColors.secondColor,
    disabledForegroundColor: CSColors.darkerGrey,
    disabledBackgroundColor: CSColors.grey,
    side: const BorderSide(color: CSColors.secondColor),
    textStyle: const TextStyle(
        fontSize: 16, color: CSColors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));

  /// --Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: CSColors.white,
    backgroundColor: CSColors.secondColor,
    disabledForegroundColor: CSColors.darkerGrey,
    disabledBackgroundColor: CSColors.grey,
    side: const BorderSide(color: CSColors.secondColor),
    textStyle: const TextStyle(
        fontSize: 16, color: CSColors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));

  /// --Small Button Size
  static final lightSmallElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: CSColors.white,
    backgroundColor: CSColors.secondColor,
    side: const BorderSide(color: CSColors.secondColor),
    fixedSize: Size(CSDeviceUtils.getScreenWidth() * 0.45, 0.0),
    textStyle: const TextStyle(
        fontSize: 12, color: CSColors.white, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ));
}
