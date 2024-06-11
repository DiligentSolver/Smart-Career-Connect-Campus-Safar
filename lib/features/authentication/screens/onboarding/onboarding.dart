import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/controllers.onboarding/onboarding_controller.dart';
import 'onboarding_widgets/onboarding_content.dart';
import 'onboarding_widgets/onboarding_dotnavigation.dart';
import 'onboarding_widgets/onboarding_nextbuttom.dart';
import 'onboarding_widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static List<Onboard> onboardData = [
    Onboard(
      image: CSImages.onBoardingImage1,
      title: CSTexts.onBoardingTitle1,
      title2: CSTexts.onBoarding2ndTitle1,
      subTitle: CSTexts.onBoardingSubTitle1,
      description: CSTexts.onBoardingBody1,
    ),
    Onboard(
      image: CSImages.onBoardingImage2,
      title: CSTexts.onBoardingTitle2,
      title2: CSTexts.onBoarding2ndTitle2,
      subTitle: CSTexts.onBoardingSubTitle2,
      description: CSTexts.onBoardingBody2,
    ),
    Onboard(
      image: CSImages.onBoardingImage3,
      title: CSTexts.onBoardingTitle3,
      title2: CSTexts.onBoarding2ndTitle3,
      subTitle: CSTexts.onBoardingSubTitle3,
      description: CSTexts.onBoardingBody3,
    ),
  ];

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

bool isLastPage = false;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    final controller = Get.put(OnBoardingController());
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            dark ? CSColors.darkThemeBg : CSColors.onBoardingLightBg,
        body: Column(
          children: [
            /// Skip Button
            Expanded(
                child: isLastPage ? const SizedBox() : const OnBoardingSkip()),

            ///Horizontal Scrollable Pages
            Expanded(
              flex: 16,
              child: PageView.builder(
                  itemCount: OnBoardingScreen.onboardData.length,
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.updatePageIndicator;
                    setState(() {
                      isLastPage =
                          index == OnBoardingScreen.onboardData.length - 1;
                    });
                  },
                  itemBuilder: (context, index) => OnBoardingContent(
                      image: OnBoardingScreen.onboardData[index].image,
                      title: OnBoardingScreen.onboardData[index].title,
                      title2: OnBoardingScreen.onboardData[index].title2,
                      subTitle: OnBoardingScreen.onboardData[index].subTitle,
                      description:
                          OnBoardingScreen.onboardData[index].description)),
            ),

            /// Dot Navigation SmoothPageIndicator
            const Expanded(child: OnBoardingDotNavigation()),
            Ver(10),

            /// Circular Button
            isLastPage
                ? const Expanded(child: OnBoardingNextButton())
                : const Expanded(child: SizedBox()),
            Ver(10)
          ],
        ),
      ),
    );
  }
}
