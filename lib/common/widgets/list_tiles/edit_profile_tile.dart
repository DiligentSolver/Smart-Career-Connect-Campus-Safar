import 'package:campus_safar/common/widgets/Divider/divider.dart';
import 'package:campus_safar/features/authentication/controllers/user%20controller/student_controller.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class CSEditProfileMenu extends StatelessWidget {
  const CSEditProfileMenu({
    super.key,
    required this.title,
    this.titleStyle,
    required this.hintText,
    this.hintStyle,
    this.onSubmitted,
    this.padding = const EdgeInsets.only(right: CSSizes.sm, left: CSSizes.sm),
    this.controller,
  });
  final String title, hintText;
  final TextStyle? titleStyle, hintStyle;
  final void Function(String)? onSubmitted;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    final cont = Get.put(StudentController());
    return Container(
        padding: padding,
        decoration: BoxDecoration(
            color: dark ? CSColors.white.withOpacity(0.1) : CSColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: titleStyle ??
                          (CSHelperFunctions.isDarkMode(context)
                              ? CSTextTheme.darkTextTheme.titleLarge
                              : CSTextTheme.lightTextTheme.titleLarge),
                      maxLines: 3,
                    ),
                  ),
                  Text(
                    ":  ",
                    style: titleStyle ??
                        (CSHelperFunctions.isDarkMode(context)
                            ? CSTextTheme.darkTextTheme.titleLarge
                            : CSTextTheme.lightTextTheme.titleLarge),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: hintStyle ??
                            (CSHelperFunctions.isDarkMode(context)
                                ? CSTextTheme.darkTextTheme.bodyMedium
                                : CSTextTheme.lightTextTheme.bodyMedium),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    onFieldSubmitted: onSubmitted,
                    controller: controller,
                    initialValue: null,
                  ),
                  const CSDivider()
                ],
              ),
            ),
          ],
        ));
  }
}
