import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class CSSearchBar extends StatelessWidget {
  const CSSearchBar({
    super.key,
    this.onTap,
    this.showBackground = true,
    this.showBorder = true,
    this.icon = Iconsax.search_normal,
    required this.text,
    this.padding = const EdgeInsets.symmetric(horizontal: CSSizes.defaultSpace),
    this.showTrailingIcon = false,
    this.trailingIcon,
    this.onPressed,
  });

  final VoidCallback? onTap;
  final bool showBackground;
  final bool showBorder, showTrailingIcon;
  final IconData? icon, trailingIcon;
  final String text;
  final EdgeInsetsGeometry padding;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: padding,
            child: Container(
                width: CSDeviceUtils.getScreenWidth(),
                padding: const EdgeInsets.all(CSSizes.sm),
                decoration: BoxDecoration(
                  color: showBackground
                      ? dark
                          ? CSColors.darkThemeBg
                          : CSColors.lightBg
                      : CSColors.transparent,
                  borderRadius: BorderRadius.circular(CSSizes.cardRadiusLg),
                  border: showBorder ? Border.all(color: CSColors.grey) : null,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(icon,
                              color:
                                  dark ? CSColors.darkerGrey : CSColors.grey),
                          const SizedBox(width: CSSizes.spaceBtwItems),
                          Text(text,
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      if (showTrailingIcon)
                        IconButton(
                          icon: Icon(trailingIcon,
                              color:
                                  dark ? CSColors.darkerGrey : CSColors.grey),
                          onPressed: onPressed,
                        ),
                    ]))));
  }
}
