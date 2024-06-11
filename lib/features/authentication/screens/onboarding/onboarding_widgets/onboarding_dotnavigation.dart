import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controllers/controllers.onboarding/onboarding_controller.dart';
import 'onboarding_content.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = CSHelperFunctions.isDarkMode(context);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: SmoothPageIndicator(
                    count: 3,
                    controller: controller.pageController,
                    onDotClicked: controller.dotNavigationClick,
                    effect: ExpandingDotsEffect(
                        activeDotColor:
                            dark ? CSColors.white : CSColors.firstColor,
                        dotColor: dark ? CSColors.grey : CSColors.thirdColor,
                        radius: 15,
                        dotHeight: 8,
                        dotWidth: 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  // TODO: implement onboardData
  Future<List<Onboard>> get onboardData async => throw UnimplementedError();
}
