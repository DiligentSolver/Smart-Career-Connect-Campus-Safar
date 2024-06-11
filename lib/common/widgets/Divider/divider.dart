import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class CSDivider extends StatelessWidget {
  const CSDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return Padding(
        padding: const EdgeInsets.only(top: CSSizes.xs, bottom: CSSizes.xs),
        child: Divider(
          height: CSSizes.dividerHeight,
          color: dark
              ? CSColors.white.withOpacity(0.5)
              : CSColors.black.withOpacity(0.1),
        ));
  }
}

class CSDividerBold extends StatelessWidget {
  const CSDividerBold({super.key, this.color, this.height = CSSizes.sm});
  final Color? color;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(height: height, color: color);
  }
}
