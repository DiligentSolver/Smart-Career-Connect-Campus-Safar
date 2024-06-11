import 'package:campus_safar/features/authentication/controllers/user%20controller/student_controller.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../icons/circular_icon.dart';
import 'circular_image.dart';

class CSEditableProfileImg extends StatelessWidget {
  const CSEditableProfileImg({
    super.key,
    required this.image,
    required this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.width = 100,
    this.height = 100,
  });

  final String image;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Stack(
        children: [
          CSCircularImage(
            width: width,
            height: height,
            assetImage: const AssetImage(CSImages.user1),
            //networkImage: Image.file(controller.pickedImage!),
          ),
          Positioned(
            right: -5,
            bottom: -5,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CSHelperFunctions.isDarkMode(context)
                    ? CSColors.darkThemeBg
                    : CSColors.white,
              ),
              child: CSCircularIcon(
                padding: const EdgeInsets.all(CSSizes.xs - 4),
                icon: icon,
                iconSize: CSSizes.iconLg,
                iconColor: iconColor,
                backgroundColor: iconBackgroundColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
