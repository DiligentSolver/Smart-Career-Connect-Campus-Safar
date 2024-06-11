import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../styles/shadows.dart';
import '../../images/circular_image.dart';

class CSHorizontalCard extends StatelessWidget {
  const CSHorizontalCard({
    super.key,
    required this.title1,
    required this.image,
    required this.title2,
    this.onTap,
    this.titleStyle,
    this.title2Style,
    required this.title3,
    this.title3Style,
    required this.title4,
    this.title4Style, this.containerWidth, this.containerHeight, required this.title5, this.title5Style,
  });

  final String title1, image, title2, title3, title4,title5;
  final TextStyle? titleStyle, title2Style, title3Style, title4Style,title5Style;
  final VoidCallback? onTap;
  final double? containerWidth, containerHeight;
  @override
  Widget build(BuildContext context) {
    final width = CSDeviceUtils.getScreenWidth();
    final dark = CSHelperFunctions.isDarkMode(context);
    final height = CSDeviceUtils.getScreenHeight();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: containerWidth,
        height: containerHeight??(height / 2 * 0.30),
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5,bottom: 5),
        decoration: BoxDecoration(
          boxShadow: [CSShadowStyle.verticalCardShadow],
          borderRadius: BorderRadius.circular(CSSizes.cardRadiusLg),
          color: CSHelperFunctions.isDarkMode(context)
              ? CSColors.white.withOpacity(0.1)
              : CSColors.white.withOpacity(0.9),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CSCircularImage(
                height: height * 0.25,
                width: width * 0.25,
                assetImage: const AssetImage(CSImages.user1),
                //networkImage: Image.file(controller.pickedImage!),
              ),
            ),
            Hor(CSSizes.md),

            ///-- Details
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title1,
                    style: titleStyle ??
                        (dark
                            ? CSTextTheme.darkTextTheme.headlineMedium
                            : CSTextTheme.lightTextTheme.headlineMedium),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    title2,
                    style: title2Style ??
                        (dark
                            ? CSTextTheme.darkTextTheme.titleLarge
                            : CSTextTheme.lightTextTheme.titleLarge),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    title3,
                    style: title3Style ??
                        (dark
                            ? CSTextTheme.darkTextTheme.bodyMedium
                            : CSTextTheme.lightTextTheme.bodyMedium),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title4,
                        style: title4Style ??
                            (dark
                                ? CSTextTheme.darkTextTheme.bodyMedium
                                : CSTextTheme.lightTextTheme.bodyMedium),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        " - ",
                        style: dark
                            ? CSTextTheme.darkTextTheme.bodyLarge
                            : CSTextTheme
                            .lightTextTheme.bodyLarge,
                      ),
                      Text(
                        title5,
                        style: title5Style ??
                            (dark
                                ? CSTextTheme.darkTextTheme.bodyMedium
                                : CSTextTheme.lightTextTheme.bodyMedium),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
