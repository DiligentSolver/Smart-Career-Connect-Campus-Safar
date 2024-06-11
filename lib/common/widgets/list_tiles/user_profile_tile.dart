import 'package:campus_safar/utils/constants/sizes.dart';
import 'package:campus_safar/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/helpers/helper_functions.dart';

class CSUserProfileTile extends StatelessWidget {
  const CSUserProfileTile({
    super.key,
    this.onPressed,
    required this.title,
    required this.subtitle,
    this.leading,
    this.trailingColor,
    this.tileColor,
    this.showIcon = true,
  });

  final VoidCallback? onPressed;
  final String title, subtitle;
  final Widget? leading;
  final Color? trailingColor, tileColor;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return ListTile(
      tileColor: tileColor,
      leading: leading,
      title: Text(
        title,
        style: dark
            ? CSTextTheme.darkTextTheme.headlineMedium
            : CSTextTheme.lightTextTheme.headlineMedium,
      ),
      subtitle: Text(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        subtitle,
        style: dark
            ? CSTextTheme.darkTextTheme.titleSmall
            : CSTextTheme.lightTextTheme.titleSmall,
      ),
      trailing: showIcon
          ? IconButton(
              onPressed: onPressed,
              iconSize: CSSizes.iconMd,
              color: trailingColor,
              icon: const Icon(CupertinoIcons.pencil))
          : Container(),
    );
  }
}
