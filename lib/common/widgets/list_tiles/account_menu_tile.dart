import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class CSSettingsMenuTile extends StatelessWidget {
  const CSSettingsMenuTile({
    super.key,
    this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.child,
    this.listStyle,
    this.showLeading = true,
    this.titleStyle,
    this.leading,
  });

  final IconData? icon;
  final String title;
  final Widget? leading, trailing, child;
  final VoidCallback? onTap;
  final ListTileStyle? listStyle;
  final bool showLeading;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return ListTile(
      style: listStyle,
      leading: showLeading
          ? leading ??
              (Icon(icon,
                  size: CSSizes.iconMd,
                  color: dark ? CSColors.white : CSColors.firstColor))
          : null,
      title: Text(title,
          style: titleStyle ??
              (dark
                  ? CSTextTheme.darkTextTheme.headlineSmall
                  : CSTextTheme.lightTextTheme.headlineSmall)),
      subtitle: child,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
