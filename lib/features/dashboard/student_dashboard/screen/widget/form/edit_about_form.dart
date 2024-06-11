import 'package:campus_safar/common/widgets/Divider/divider.dart';
import 'package:campus_safar/features/authentication/models/student_model.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../../data/repositories/user_repository.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/loaders.dart';
import '../../../../../../utils/theme/custom_themes/text_theme.dart';
import '../profile_menu_tile.dart';

class CSEditAboutForm extends StatelessWidget {
  const CSEditAboutForm({super.key, this.hintStyle});

  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final headingField = TextEditingController();
    final aboutField = TextEditingController();
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(CSSizes.listViewSpacing),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                StudProfileMenus(
                    seeMoreWidget: false,
                    showActionWidget: false,
                    title: "Edit Heading",
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.headlineSmall
                        : CSTextTheme.lightTextTheme.headlineSmall,
                    showChildWidget: true,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Ex. Designer, Developer",
                          hintStyle: dark
                              ? CSTextTheme.darkTextTheme.bodyLarge
                              : CSTextTheme.lightTextTheme.bodyLarge,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                      controller: headingField,
                    )),
                const CSDividerBold(),
                StudProfileMenus(
                    seeMoreWidget: false,
                    showActionWidget: false,
                    title: "Edit About",
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.headlineSmall
                        : CSTextTheme.lightTextTheme.headlineSmall,
                    showChildWidget: true,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText:
                              "Write about yourself, your experience, skills, achievements and so on..",
                          hintStyle: dark
                              ? CSTextTheme.darkTextTheme.bodyLarge
                              : CSTextTheme.lightTextTheme.bodyLarge,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                      controller: aboutField,
                    )),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 140,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              StudentModel editAbout = StudentModel(
                  heading: headingField.text, about: aboutField.text);
              userRepo.updateStuAboutDetails(editAbout);
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
