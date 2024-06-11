import 'package:campus_safar/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class CSProfileMenu extends StatelessWidget {
  const CSProfileMenu({
    super.key,
    this.icon = Icons.keyboard_arrow_right_outlined,
    this.onPressed,
    required this.title,
    required this.value,
    this.valueStyle,
    this.titleStyle,
    this.showIcon = true,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String title, value;
  final TextStyle? titleStyle, valueStyle;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 3,
            child: Text(
              title,
              style: titleStyle ??
                  (CSHelperFunctions.isDarkMode(context)
                      ? CSTextTheme.darkTextTheme.titleLarge
                      : CSTextTheme.lightTextTheme.titleLarge),
              maxLines: 2,
            )),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            flex: 5,
            child: Text(
              value,
              style: valueStyle ??
                  (CSHelperFunctions.isDarkMode(context)
                      ? CSTextTheme.darkTextTheme.bodyLarge
                      : CSTextTheme.lightTextTheme.bodyLarge),
              overflow: TextOverflow.ellipsis,
            )),
        if (showIcon)
          Expanded(
              child: Icon(
            icon,
            size: CSSizes.iconSm,
          )),
      ],
    );
  }
}
