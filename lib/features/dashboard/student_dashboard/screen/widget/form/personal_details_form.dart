import 'package:campus_safar/common/widgets/list_tiles/edit_profile_tile.dart';
import 'package:campus_safar/data/repositories/user_repository.dart';
import 'package:campus_safar/features/authentication/controllers/user%20controller/recruiter_controller.dart';
import 'package:campus_safar/features/authentication/controllers/user%20controller/student_controller.dart';
import 'package:campus_safar/features/authentication/models/student_model.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../../common/widgets/Divider/divider.dart';
import '../../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import 'package:get/get.dart';
import '../../../../../../utils/theme/custom_themes/text_theme.dart';

class CSEditPersonalDetailForm extends StatelessWidget {
  const CSEditPersonalDetailForm({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    final controller = Get.put(StudentController());
    final recController = Get.put(RecruiterController());
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final nameField = TextEditingController();
    final emailField = TextEditingController();
    final numberField = TextEditingController();
    final addressField = TextEditingController();
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
            "Edit Profile",
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
                      recController.image != null
                          ? GestureDetector(
                              onTap: () {
                                recController.openFile(
                                    fileExtension: '.pdf',
                                    url: controller.user.value.resume ??
                                        'Resume');
                              },
                              child: Container(
                                width: CSDeviceUtils.getScreenWidth() / 2,
                                height: CSDeviceUtils.getScreenHeight() * 0.20,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: CSColors.white.withOpacity(0.1),
                                ),
                                child: recController.image,
                              ),
                            )
                          : Container(),
                      const CSDividerBold(),
                      OutlinedButton(
                        onPressed: () {
                          recController.pickFile(FileType.custom, ['pdf']);
                        },
                        style: OutlinedButton.styleFrom(
                            disabledBackgroundColor: CSColors.grey,
                            side: const BorderSide(color: CSColors.secondColor),
                            fixedSize: Size(
                                CSDeviceUtils.getScreenWidth() * 0.80, 0.0)),
                        child: Text(
                          "Upload Resume",
                          style: dark
                              ? CSTextTheme.darkTextTheme.titleLarge
                              : CSTextTheme.lightTextTheme.titleLarge,
                        ),
                      ),
                      const CSDividerBold(),
                      const CSDivider(),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          title: "Name",
                          hintText: "Enter Name",
                          controller: nameField),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          title: "E-Mail",
                          hintText: "Enter E-Mail",
                          controller: emailField),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          title: "Mobile No.",
                          hintText: "Enter Mobile No.",
                          controller: numberField),
                      const CSDividerBold(),
                      CSEditProfileMenu(
                          title: "Address",
                          hintText: "Enter Address",
                          controller: addressField),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: 140,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              StudentModel editProfile = StudentModel(
                  fullName: nameField.text,
                  email: emailField.text,
                  address: addressField.text,
                  mobileNumber: numberField.text);
              userRepo.updateStudentDetails(editProfile);
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
