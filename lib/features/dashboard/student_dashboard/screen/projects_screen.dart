import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/add_project_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/profile_menu_tile.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:see_more/see_more_widget.dart';
import '../../../../common/widgets/Divider/divider.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';

class CSProjectsScreen extends StatelessWidget {
  const CSProjectsScreen({super.key, this.padding, this.hintStyle});

  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Projects",
          style: dark
              ? CSTextTheme.darkTextTheme.headlineMedium
              : CSTextTheme.lightTextTheme.headlineMedium,
        ),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const CSEditProjectForm()),
              iconSize: CSSizes.iconMd,
              icon: const Icon(CupertinoIcons.add)),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(CSSizes.listViewSpacing),
          shrinkWrap: true,
          itemCount: project.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                StudProfileMenus(
                    title: project[index],
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.headlineSmall
                        : CSTextTheme.lightTextTheme.headlineSmall,
                    addActionButton: true,
                    actionButton: IconButton(
                        onPressed: () =>
                            Get.to(() => const CSEditProjectForm()),
                        iconSize: CSSizes.iconMd,
                        icon: const Icon(CupertinoIcons.pencil)),
                    changeActionButton: IconButton(
                        onPressed: () => Get.delete(),
                        iconSize: CSSizes.iconMd,
                        icon: const Icon(Icons.delete)),
                    seeMoreWidget: false,
                    showChildWidget: true,
                    child: SeeMoreWidget(
                      projDescription[index],
                      trimLength: 120,
                      textStyle: GoogleFonts.openSans(
                          fontSize: 14,
                          color: dark
                              ? CSColors.white.withOpacity(0.8)
                              : CSColors.black.withOpacity(0.8)),
                      seeMoreText: "see more",
                      seeMoreStyle: GoogleFonts.openSans(
                          fontSize: 14, color: CSColors.grey),
                      seeLessText: "see less",
                      seeLessStyle: GoogleFonts.openSans(
                          fontSize: 14, color: CSColors.grey),
                    )),
                const CSDividerBold(),
              ],
            );
          }),
    );
  }
}
