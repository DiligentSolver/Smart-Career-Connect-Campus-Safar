import 'package:campus_safar/features/authentication/controllers/company.controller/company_controller.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../styles/shadows.dart';
import '../../icons/favourite_icon.dart';
import '../../images/rounded_image.dart';
import '../container/rounded_container.dart';

class CSVerticalCard extends StatelessWidget {
  const CSVerticalCard({
    super.key,
    required this.title1,
    required this.image,
    required this.title2,
    this.onTap,
    required this.imgContainerHeight,
    this.titleStyle,
    this.title2Style,
    this.showFavIcon = true,
  });

  final String title1, image, title2;
  final TextStyle? titleStyle, title2Style;
  final VoidCallback? onTap;
  final double imgContainerHeight;
  final bool showFavIcon;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyController());
    final width = CSDeviceUtils.getScreenWidth();
    final dark = CSHelperFunctions.isDarkMode(context);
    final height = CSDeviceUtils.getScreenHeight();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.45,
        height: height / 2 * 0.60,
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        decoration: BoxDecoration(
          boxShadow: [CSShadowStyle.verticalCardShadow],
          borderRadius: BorderRadius.circular(CSSizes.cardRadiusLg),
          color: CSHelperFunctions.isDarkMode(context)
              ? CSColors.white.withOpacity(0.1)
              : CSColors.white.withOpacity(0.9),
        ),
        child: Column(
          children: [
            CSRoundedContainer(
              padding: const EdgeInsets.all(8),
              height: imgContainerHeight,
              width: width * 0.45,
              backgroundColor: CSColors.white,
              child: CSRoundedImage(
                isNetworkImage: true,
                imageUrl: image,
                applyImageRadius: true,
              ),
            ),
            Ver(CSSizes.xs),

            ///-- Details
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title1,
                  style: titleStyle ??
                      (dark
                          ? CSTextTheme.darkTextTheme.titleLarge
                          : CSTextTheme.lightTextTheme.titleLarge),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Ver(CSSizes.xs),
                Divider(
                  height: CSSizes.dividerHeight,
                  color: dark ? CSColors.darkerGrey : CSColors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title2,
                      style: title2Style ??
                          (dark
                              ? CSTextTheme.darkTextTheme.bodyMedium
                              : CSTextTheme.lightTextTheme.bodyMedium),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    showFavIcon
                        ? CSFavouriteIcon(
                            companyName: controller.company.value.companyName,
                          )
                        : Container()
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
