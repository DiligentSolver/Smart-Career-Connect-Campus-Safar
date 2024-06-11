import 'package:campus_safar/common/widgets/texts/section_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/Divider/divider.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/images/editable_profile_image.dart';
import '../../../../common/widgets/list_tiles/edit_profile_tile.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/models/recruiter_model.dart';
import '../../../authentication/models/student_model.dart';
import '../../student_dashboard/screen/edit_profile_photo.dart';

class RecProfile extends StatelessWidget {
  const RecProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final nameField = TextEditingController();
    final emailField = TextEditingController();
    final numberField = TextEditingController();
    final companyNameField = TextEditingController();
    final designationField = TextEditingController();
    final locationField = TextEditingController();
    final websiteField = TextEditingController();
    final userRepo = Get.put(UserRepository());
    return SafeArea(
        child: Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        arrowColor: dark ? CSColors.white : CSColors.black,
        title: Text(
          "Profile",
          style: dark
              ? CSTextTheme.darkTextTheme.headlineLarge
              : CSTextTheme.lightTextTheme.headlineLarge,
        ),
      ),

      ///Body
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
            const CSDividerBold(),
            CSEditProfileMenu(
              title: "Organisation",
              hintText: "Enter Organisation",
              controller: companyNameField,
            ),
            const CSDividerBold(),
            CSEditProfileMenu(
              title: "Designation",
              hintText: "Enter Designation",
              controller: designationField,
            ),
            const CSDividerBold(),
            CSEditProfileMenu(
              title: "Location",
              hintText: "Enter Location",
              controller: locationField,
            ),
            const CSDividerBold(),
            CSEditProfileMenu(
              title: "Website",
              hintText: "Enter URL",
              controller: websiteField,
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 140,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            RecruiterModel editProfile = RecruiterModel(
                fullName: nameField.text,
                email: emailField.text,
                mobileNumber: numberField.text,
                companyName: companyNameField.text,
                designation: designationField.text,
                location: locationField.text);
            userRepo.updateRecruiterDetails(editProfile);
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
