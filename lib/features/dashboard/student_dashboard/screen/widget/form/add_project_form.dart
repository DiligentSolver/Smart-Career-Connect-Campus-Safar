import 'package:campus_safar/common/widgets/icons/circular_icon.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/Divider/divider.dart';
import '../../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../../data/repositories/user_repository.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/loaders.dart';
import '../../../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../../../authentication/models/student_model.dart';
import '../profile_menu_tile.dart';

class CSEditProjectForm extends StatelessWidget {
  const CSEditProjectForm({super.key, this.padding, this.hintStyle});

  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final projTitleField = TextEditingController();
    final projDescField = TextEditingController();
    final technologyUsedField = TextEditingController();
    final startDateField = TextEditingController();
    final endDateField = TextEditingController();
    final userRepo = Get.put(UserRepository());
    return SafeArea(
      child: Scaffold(
        appBar: CSAppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.close,
              size: CSSizes.iconMd,
            ),
            color: dark ? CSColors.white : CSColors.black,
          ),
          title: Text(
            "Add Project",
            style: dark
                ? CSTextTheme.darkTextTheme.headlineMedium
                : CSTextTheme.lightTextTheme.headlineMedium,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(CSSizes.listViewSpacing),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      StudProfileMenus(
                          seeMoreWidget: false,
                          showActionWidget: false,
                          title: "Project Title",
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.headlineSmall
                              : CSTextTheme.lightTextTheme.headlineSmall,
                          showChildWidget: true,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Add title of your project",
                                hintStyle: dark
                                    ? CSTextTheme.darkTextTheme.bodyMedium
                                    : CSTextTheme.lightTextTheme.bodyMedium,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            controller: projTitleField,
                          )),
                      const CSDividerBold(),
                      StudProfileMenus(
                          seeMoreWidget: false,
                          showActionWidget: false,
                          title: "Project Description",
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.headlineSmall
                              : CSTextTheme.lightTextTheme.headlineSmall,
                          showChildWidget: true,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Add Project Description",
                                hintStyle: dark
                                    ? CSTextTheme.darkTextTheme.bodyMedium
                                    : CSTextTheme.lightTextTheme.bodyMedium,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            controller: projDescField,
                          )),
                      const CSDividerBold(),
                      StudProfileMenus(
                          seeMoreWidget: false,
                          showActionWidget: false,
                          title: "Technology Used",
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.headlineSmall
                              : CSTextTheme.lightTextTheme.headlineSmall,
                          showChildWidget: true,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Add technologies you've used",
                                hintStyle: dark
                                    ? CSTextTheme.darkTextTheme.bodyMedium
                                    : CSTextTheme.lightTextTheme.bodyMedium,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            controller: technologyUsedField,
                          )),
                      const CSDividerBold(),
                      StudProfileMenus(
                          seeMoreWidget: false,
                          showActionWidget: false,
                          title: "Start Date:",
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.headlineSmall
                              : CSTextTheme.lightTextTheme.headlineSmall,
                          showChildWidget: true,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "DD/MM/YYYY",
                                hintStyle: dark
                                    ? CSTextTheme.darkTextTheme.bodyMedium
                                    : CSTextTheme.lightTextTheme.bodyMedium,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            controller: startDateField,
                          )),
                      const CSDividerBold(),
                      StudProfileMenus(
                          seeMoreWidget: false,
                          showActionWidget: false,
                          title: "End Date:",
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.headlineSmall
                              : CSTextTheme.lightTextTheme.headlineSmall,
                          showChildWidget: true,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "DD/MM/YYYY",
                                hintStyle: dark
                                    ? CSTextTheme.darkTextTheme.bodyMedium
                                    : CSTextTheme.lightTextTheme.bodyMedium,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            controller: endDateField,
                          )),
                    ],
                  ),
                ),
              ),
              CSCircularIcon(
                padding: const EdgeInsets.all(CSSizes.sm),
                backgroundColor: CSColors.white.withOpacity(0.1),
                icon: Icons.delete,
                iconSize: CSSizes.iconLg,
                onPressed: () {},
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: 140,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              StudentModel editProject = StudentModel(
                  projectTitle: projTitleField.text,
                  projectDescription: projDescField.text,
                  technologiesUsed: technologyUsedField.text,
                  projStartDate: startDateField.text,
                  projEndDate: endDateField.text);
              userRepo.updateStuProjDetails(editProject);
              Loader.successSnackBar(title: "Saved");
            },
            backgroundColor: dark ? CSColors.white : CSColors.firstColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              "Save",
              style: dark
                  ? CSTextTheme.lightTextTheme.titleMedium
                  : CSTextTheme.darkTextTheme.titleMedium,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
