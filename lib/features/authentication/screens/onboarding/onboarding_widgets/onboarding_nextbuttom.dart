import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/controllers.onboarding/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return SizedBox(
        width: 300,
        child: Animate(
          effects: const [
            FadeEffect(
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 1000))
          ],
          child: TextButton(
            onPressed: () => OnBoardingController.instance.nextPage(),
            style: ElevatedButton.styleFrom(
                backgroundColor: dark ? CSColors.white : CSColors.firstColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
            child: AutoSizeText(
              "Get Started",
              style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontWeight: FontWeight.w500,
                color: dark ? CSColors.firstColor : CSColors.white,
              ),
            ),
          ),
        ));
  }
}

//onPressed: () => OnBoardingController.instance.nextPage(),
