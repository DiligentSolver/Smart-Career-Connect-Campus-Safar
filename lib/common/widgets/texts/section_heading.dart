import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme/custom_themes/text_theme.dart';

class CSSectionHeading extends StatelessWidget {
  const CSSectionHeading(
      {super.key,
      this.onPressed,
      this.textColor,
      this.buttonTitle = 'View All',
      this.showTextButton = true,
      required this.title,
      this.actionWidget,
      this.titleStyle,
      this.showActionWidget = false});

  final Color? textColor;
  final bool showTextButton;
  final String title, buttonTitle;
  final TextStyle? titleStyle;
  final VoidCallback? onPressed;
  final Widget? actionWidget;
  final bool showActionWidget;

  @override
  Widget build(BuildContext context) {
    final darkMode = CSHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showTextButton)
          TextButton(
              onPressed: onPressed,
              child: Text(
                buttonTitle,
                style: darkMode
                    ? CSTextTheme.darkTextTheme.bodyMedium
                    : CSTextTheme.lightTextTheme.bodyMedium,
              )),
        if (showActionWidget) Container(child: actionWidget)
      ],
    );
  }
}
