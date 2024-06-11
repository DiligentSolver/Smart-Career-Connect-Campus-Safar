import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../student_dashboard/screen/account_screen.dart';

class RecNotifications extends StatelessWidget {
  const RecNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        appBar: CSAppBar(
          showBackArrow: true,
          changeArrowColor: true,
          arrowColor: dark ? CSColors.white : CSColors.black,
          title: Text(
            "Notifications",
            style: dark
                ? CSTextTheme.darkTextTheme.headlineLarge
                : CSTextTheme.lightTextTheme.headlineLarge,
          ),
          actions: [
            PopupMenuButton(
              onSelected: (item) => StudProfile.handleClick(item),
              icon: const Icon(CupertinoIcons.settings),
              iconColor: dark ? CSColors.white : CSColors.black,
              iconSize: CSSizes.iconMd,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      value: 0,
                      onTap: () {},
                      child: Text(
                        "Notification Settings",
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      )),
                ];
              },
            ),
          ],
        ),
        body: Center(
          child: Text(
            "No notifications are here right now ",
            style: dark
                ? CSTextTheme.darkTextTheme.bodyLarge
                : CSTextTheme.lightTextTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
