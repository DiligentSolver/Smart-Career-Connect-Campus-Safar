import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class Onboard {
  final String image, title, title2, subTitle, description;

  Onboard({
    required this.image,
    required this.title,
    required this.title2,
    required this.subTitle,
    required this.description,
  });
}

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.title2,
    required this.subTitle,
    required this.description,
  });

  final String image, title, title2, subTitle, description;

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 8,
          child: Animate(
            effects: const [
              SlideEffect(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  begin: Offset(0, 5),
                  end: Offset(0, 0)),
              FadeEffect()
            ],
            child: Image(
              image: AssetImage(image),
            ),
          ),
        ),
        Flexible(
            flex: 16,
            child: SingleChildScrollView(
              child: Animate(
                effects: const [
                  FadeEffect(
                    delay: Duration(milliseconds: 850),
                  )
                ],
                child: SizedBox(
                  child: Column(
                    children: [
                      AutoSizeText(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: GoogleFonts.lexend(
                          color: dark ? CSColors.white : CSColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 50,
                        ),
                      ),
                      AutoSizeText(
                        title2,
                        maxLines: 1,
                        style: GoogleFonts.lexend(
                            color: dark ? CSColors.white : CSColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                      Ver(5),
                      AutoSizeText(
                        subTitle,
                        maxLines: 1,
                        style: GoogleFonts.lexend(
                            color: dark ? CSColors.white : CSColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Ver(60),
                      SizedBox(
                        width: 300,
                        child: AutoSizeText(
                          description,
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lexend(
                            color: dark ? CSColors.white : CSColors.black,
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
