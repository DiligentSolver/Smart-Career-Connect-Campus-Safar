import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:see_more/see_more_widget.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class StudProfileMenus extends StatelessWidget {
  const StudProfileMenus({
    super.key,
    required this.title,
    this.seeMoreWidget = true,
    this.child,
    this.seeMoreContent,
    this.actionButton,
    this.showChildWidget = false,
    this.addActionButton = false,
    this.onPressed,
    this.containerColor,
    this.titleStyle,
    this.showActionWidget = true,
    this.trimLength = 120,
    this.padding = const EdgeInsets.only(right: CSSizes.sm, left: CSSizes.sm),
    this.changeActionButton,
  });

  final String title;
  final bool seeMoreWidget;
  final Widget? child;
  final String? seeMoreContent;
  final Widget? changeActionButton, actionButton;
  final bool addActionButton;
  final bool showChildWidget;
  final void Function()? onPressed;
  final Color? containerColor;
  final TextStyle? titleStyle;
  final bool showActionWidget;
  final int trimLength;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: dark ? CSColors.white.withOpacity(0.1) : CSColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          CSSectionHeading(
              title: title,
              titleStyle: titleStyle,
              showTextButton: false,
              showActionWidget: showActionWidget,
              actionWidget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (addActionButton) Container(child: actionButton),
                  changeActionButton ??
                      IconButton(
                          onPressed: onPressed,
                          iconSize: CSSizes.iconMd,
                          icon: const Icon(CupertinoIcons.pencil)),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: CSSizes.sm),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (seeMoreWidget)
                SeeMoreWidget(
                  seeMoreContent!,
                  trimLength: trimLength,
                  textStyle: GoogleFonts.openSans(
                      fontSize: 14,
                      color: dark
                          ? CSColors.white.withOpacity(0.8)
                          : CSColors.black.withOpacity(0.8)),
                  seeMoreText: "see more",
                  seeMoreStyle:
                      GoogleFonts.openSans(fontSize: 14, color: CSColors.grey),
                  seeLessText: "see less",
                  seeLessStyle:
                      GoogleFonts.openSans(fontSize: 14, color: CSColors.grey),
                ),
              if (showChildWidget)
                Container(
                  padding: const EdgeInsets.only(bottom: CSSizes.sm),
                  child: child,
                )
            ]),
          )
        ],
      ),
    );
  }
}
