import 'package:campus_safar/utils/constants/sizes.dart';
import 'package:campus_safar/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class CSCircularIcon extends StatelessWidget {
  const CSCircularIcon({
    super.key,
    this.width,
    this.height,
    this.iconSize = CSSizes.lg,
    required this.icon,
    this.iconColor,
    this.backgroundColor = CSColors.transparent,
    this.onPressed,
    this.label = "",
    this.showBorder = false,
    this.padding,
    this.showLabel = false,
  });

  final double? width, height, iconSize;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final String label;
  final bool showBorder, showLabel;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            padding: padding,
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
                border: showBorder
                    ? Border.all(
                        color: CSColors.grey.withOpacity(0.5), width: 1)
                    : null),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            )),
        showLabel
            ? Text(
                label,
                style: CSTextTheme.darkTextTheme.bodySmall,
              )
            : Container(),
      ],
    );
  }
}
