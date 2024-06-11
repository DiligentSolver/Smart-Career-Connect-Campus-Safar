import 'package:campus_safar/features/dashboard/student_dashboard/controller/favourite_controller.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/company_screen.dart';
import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/custom_shapes/cards/vertical_card.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';

class StudSavedScreen extends StatelessWidget {
  const StudSavedScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    final dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        appBar: CSAppBar(
          title: Text(
            title,
            style: dark
                ? CSTextTheme.darkTextTheme.headlineLarge
                : CSTextTheme.lightTextTheme.headlineLarge,
          ),
          actions: [
            IconButton(
                onPressed: () => Get.to(() => const StudCompaniesPage(
                      initialIndex: 0,
                    )),
                iconSize: CSSizes.iconMd,
                icon: const Icon(CupertinoIcons.add))
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(
              top: CSSizes.listViewSpacing,
              right: CSSizes.sm,
              left: CSSizes.sm),
          // child: FutureBuilder(
          //   future: controller.favouriteCompanies(),
          //   builder: (context, snapshot) {
          //     return CSGridLayout(
          //       itemCount: companyLogo.length,
          //       mainAxisExtent: CSDeviceUtils.getScreenHeight() / 2 * 0.48,
          //       itemBuilder: (_, index) => CSVerticalCard(
          //         title1: companyNames[index],
          //         image: companyLogo[index],
          //         title2: companyDates[index],
          //         imgContainerHeight: CSDeviceUtils.getScreenHeight() * 0.125,
          //       ),
          //     );
          //   },
          // ),
        )),
      ),
    );
  }
}
