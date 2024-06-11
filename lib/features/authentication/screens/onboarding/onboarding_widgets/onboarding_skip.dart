import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/controllers.onboarding/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Ver(10),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 16.0),
          child: GestureDetector(
            onTap: () => OnBoardingController.instance.skipPage(),
            child: AutoSizeText(
              "Skip",
              maxLines: 1,
              style: GoogleFonts.inter(
                  color: dark ? CSColors.white70 : CSColors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
