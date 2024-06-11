import 'package:campus_safar/common/widgets/list_tiles/edit_profile_tile.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/Divider/divider.dart';
import '../../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../../data/repositories/user_repository.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/loaders.dart';
import '../../../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../../../authentication/models/student_model.dart';

class CSEditEduDetailForm extends StatelessWidget {
  const CSEditEduDetailForm({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final instituteField = TextEditingController();
    final courseField = TextEditingController();
    final branchField = TextEditingController();
    final startYearField = TextEditingController();
    final endYearField = TextEditingController();
    final percentageField = TextEditingController();
    final backlogsField = TextEditingController();
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
            "Edit Education Details",
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
                      CSEditProfileMenu(
                          controller: instituteField,
                          title: "School",
                          hintText: "Ex. SAGE University"),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          controller: courseField,
                          title: "Degree",
                          hintText: "Ex. Master's"),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          controller: branchField,
                          title: "Field of study",
                          hintText: "Ex. Technical"),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          controller: startYearField,
                          title: "Start Year",
                          hintText: "DD/MM/YYYY"),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          controller: endYearField,
                          title: "Passing Year",
                          hintText: "DD/MM/YYYY"),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          controller: percentageField,
                          title: "CGPA or %",
                          hintText: "Enter CGPA or %"),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          controller: backlogsField,
                          title: "Backlogs",
                          hintText: "Enter no. of Backlog(if any)"),
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
              StudentModel editEdu = StudentModel(
                  instituteName: instituteField.text,
                  course: courseField.text,
                  branch: branchField.text,
                  startYear: startYearField.text,
                  passingYear: endYearField.text,
                  percentage: percentageField.text,
                  backlogs: backlogsField.text);
              userRepo.updateStuEduDetails(editEdu);
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
