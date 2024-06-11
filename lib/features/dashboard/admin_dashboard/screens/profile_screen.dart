import 'package:campus_safar/common/widgets/appbar/app_bar.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/Divider/divider.dart';
import '../../../../common/widgets/images/editable_profile_image.dart';
import '../../../../common/widgets/list_tiles/edit_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/models/admin_model.dart';
import '../../student_dashboard/screen/edit_profile_photo.dart';

class AdmProfile extends StatelessWidget {
  const AdmProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final nameField = TextEditingController();
    final emailField = TextEditingController();
    final numberField = TextEditingController();
    final locationField = TextEditingController();
    final userRepo = Get.put(UserRepository());
    return SafeArea(
        child: Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Profile",
          style: dark
              ? CSTextTheme.darkTextTheme.headlineLarge
              : CSTextTheme.lightTextTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            top: CSSizes.listViewSpacing, right: CSSizes.sm, left: CSSizes.sm),
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => Get.to(() => const StuEditProfileImg(image: '',)),
                child: CSEditableProfileImg(
                  image: CSImages.user1,
                  icon: CupertinoIcons.camera_circle_fill,
                  iconColor: dark ? CSColors.thirdColor : CSColors.secondColor,
                  iconBackgroundColor:
                      dark ? CSColors.darkThemeBg : CSColors.lightBg,
                ),
              ),
            ),
            Ver(CSSizes.listViewSpacing),

            /// Heading Profile Info
            CSSectionHeading(
              title: "Edit Profile Information",
              titleStyle: dark
                  ? CSTextTheme.darkTextTheme.headlineMedium
                  : CSTextTheme.lightTextTheme.headlineMedium,
              showTextButton: false,
            ),
            Ver(CSSizes.spaceBtwItems),
            CSEditProfileMenu(
              title: "Name",
              hintText: "Enter Name",
              controller: nameField,
            ),
            const CSDividerBold(),
            CSEditProfileMenu(
              title: "E-mail",
              hintText: "Enter E-mail",
              controller: emailField,
            ),
            const CSDividerBold(),
            CSEditProfileMenu(
              title: "Phone Number",
              hintText: "Enter Phone Number",
              controller: numberField,
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 140,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            AdminModel editProfile = AdminModel(
              fullName: nameField.text,
              email: emailField.text,
              mobileNumber: numberField.text,
            );
            userRepo.updateAdminDetails(editProfile);
            Loader.successSnackBar(title: "Saved");
          },
          backgroundColor: dark ? CSColors.white : CSColors.firstColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            "Save",
            style: dark
                ? CSTextTheme.lightTextTheme.titleLarge
                : CSTextTheme.darkTextTheme.titleLarge,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
