import 'package:campus_safar/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CSShadowStyle {
  static final verticalCardShadow = BoxShadow(
      color: CSColors.grey.withOpacity(0.2),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalCardShadow = BoxShadow(
      color: CSColors.grey.withOpacity(0.2),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
