import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/edu_details_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/profile_menu_tile.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/Divider/divider.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';

class CSEducationScreen extends StatelessWidget {
  const CSEducationScreen({super.key, this.padding, this.hintStyle});

  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Education",
          style: dark
              ? CSTextTheme.darkTextTheme.headlineMedium
              : CSTextTheme.lightTextTheme.headlineMedium,
        ),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const CSEditEduDetailForm()),
              iconSize: CSSizes.iconMd,
              icon: const Icon(CupertinoIcons.add)),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(CSSizes.listViewSpacing),
          shrinkWrap: true,
          itemCount: qualification.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                StudProfileMenus(
                    title: qualification[index],
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.headlineSmall
                        : CSTextTheme.lightTextTheme.headlineSmall,
                    addActionButton: true,
                    actionButton: IconButton(
                        onPressed: () =>
                            Get.to(() => const CSEditEduDetailForm()),
                        iconSize: CSSizes.iconMd,
                        icon: const Icon(CupertinoIcons.pencil)),
                    changeActionButton: IconButton(
                        onPressed: () => Get.delete(),
                        iconSize: CSSizes.iconMd,
                        icon: const Icon(Icons.delete)),
                    seeMoreWidget: false,
                    showChildWidget: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Information Technology",
                          style: dark
                              ? CSTextTheme.darkTextTheme.titleLarge
                              : CSTextTheme.lightTextTheme.titleLarge,
                        ),
                        Text(
                          eduInstitute[index],
                          style: dark
                              ? CSTextTheme.darkTextTheme.titleMedium
                              : CSTextTheme.lightTextTheme.titleMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              eduStartYear[index],
                              style: dark
                                  ? CSTextTheme.darkTextTheme.bodyLarge
                                  : CSTextTheme.lightTextTheme.bodyLarge,
                            ),
                            Text(
                              " - ",
                              style: dark
                                  ? CSTextTheme.darkTextTheme.bodyLarge
                                  : CSTextTheme.lightTextTheme.bodyLarge,
                            ),
                            Text(
                              eduEndYear[index],
                              style: dark
                                  ? CSTextTheme.darkTextTheme.bodyLarge
                                  : CSTextTheme.lightTextTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Grade:",
                              style: dark
                                  ? CSTextTheme.darkTextTheme.bodyLarge
                                  : CSTextTheme.lightTextTheme.bodyLarge,
                            ),
                            Text(
                              eduGrade[index],
                              style: dark
                                  ? CSTextTheme.darkTextTheme.bodyLarge
                                  : CSTextTheme.lightTextTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    )),
                const CSDividerBold(),
              ],
            );
          }),
    );
  }
}
