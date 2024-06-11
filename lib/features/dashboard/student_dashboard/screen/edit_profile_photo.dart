import 'package:campus_safar/common/widgets/appbar/app_bar.dart';
import 'package:campus_safar/common/widgets/images/circular_image.dart';
import 'package:campus_safar/data/repositories/user_repository.dart';
import 'package:campus_safar/features/authentication/controllers/user%20controller/student_controller.dart';
import 'package:campus_safar/features/authentication/models/student_model.dart';
import 'package:campus_safar/utils/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';

class StuEditProfileImg extends StatefulWidget {
  const StuEditProfileImg({
    super.key, required this.image,
  });

  final String image;

  @override
  State<StuEditProfileImg> createState() => _StuEditProfileImgState();
}

class _StuEditProfileImgState extends State<StuEditProfileImg> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    final userRepo = Get.put(UserRepository());
    final dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: CSColors.black,
        appBar: CSAppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.close,
              size: CSSizes.iconMd,
            ),
            color: CSColors.white,
          ),
          centerTitle: false,
          title: const Text(
            "Profile Photo",
          ),
          titleTextStyle: CSTextTheme.darkTextTheme.headlineLarge,
          borderColor: CSColors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                      builder: (context) => Container(
                            height: CSDeviceUtils.getScreenHeight() * 0.192,
                            padding: const EdgeInsets.only(
                                right: CSSizes.md, left: CSSizes.md),
                            child: Column(
                              children: [
                                CSSectionHeading(
                                  title: "Profile Photo",
                                  titleStyle: dark
                                      ? CSTextTheme.darkTextTheme.headlineSmall
                                      : CSTextTheme
                                          .lightTextTheme.headlineSmall,
                                  showTextButton: false,
                                  showActionWidget: true,
                                  actionWidget: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.delete)),
                                ),
                                Row(
                                  children: [
                                    CSCircularIcon(
                                      showLabel: true,
                                      padding: const EdgeInsets.all(CSSizes.md),
                                      icon: CupertinoIcons.camera,
                                      iconSize: CSSizes.iconMd,
                                      label: "Camera",
                                      onPressed: () {
                                        controller
                                            .pickImage(ImageSource.camera);
                                        StudentModel profilePic = StudentModel(profileImg: '${FirebaseStorage.instance.ref('gs://smartcareerconnect-c8269.appspot.com/Profile Images/XJebmJDfk5RHKDsEqmnaS9OSzy72/001.jpg')}');
                                        userRepo.updateStuProfileImg(profilePic);
                                      },
                                      showBorder: true,
                                    ),
                                    Hor(10),
                                    CSCircularIcon(
                                      showLabel: true,
                                      padding: const EdgeInsets.all(CSSizes.md),
                                      icon: CupertinoIcons.photo,
                                      iconSize: CSSizes.iconMd,
                                      label: "Gallery",
                                      onPressed: () {
                                        controller
                                            .pickImage(ImageSource.gallery);
                                      },
                                      showBorder: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                },
                iconSize: CSSizes.iconLg,
                color: CSColors.white,
                icon: const Icon(CupertinoIcons.pencil))
          ],
        ),
        body: const Padding(
            padding: EdgeInsets.all(CSSizes.md),
            child: Center(
              child: CSCircularImage(
                //networkImage: Image.file(controller.pickedImage!),
                height: 400,
                width: 400,
                assetImage: AssetImage(CSImages.user1),
              ),
            )),
      ),
    );
  }
}
