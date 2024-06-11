import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CSAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CSAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor = CSColors.transparent,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.centerTitle = true,
    this.titleSpacing,
    this.toolbarHeight = 64,
    this.leadingWidth = 64,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.clipBehavior,
    this.showBackArrow = false,
    this.arrowColor,
    this.changeArrowColor = false,
    this.borderColor = CSColors.grey,
    this.bottom,
  });

  final Widget? leading;
  final bool showBackArrow;
  final bool automaticallyImplyLeading = true;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool? centerTitle;
  final bool excludeHeaderSemantics = false;
  final double? titleSpacing;
  final double toolbarOpacity = 1.0;
  final double bottomOpacity = 1.0;
  final double? toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final Clip? clipBehavior;
  final bool changeArrowColor;
  final Color? arrowColor;
  final Color borderColor;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: true,
        title: title,
        titleTextStyle: titleTextStyle,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: CSSizes.iconMd,
                ),
                color: changeArrowColor
                    ? arrowColor
                    : dark
                        ? CSColors.white
                        : CSColors.black,
              )
            : leading,
        actions: actions,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        toolbarHeight: toolbarHeight,
        leadingWidth: leadingWidth,
        centerTitle: centerTitle,
        shape: Border(bottom: BorderSide(color: borderColor)),
        bottom: bottom,
        flexibleSpace: flexibleSpace,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(CSDeviceUtils.getAppBarHeight());
}
