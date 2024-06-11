import 'package:flutter/material.dart';
import '../../../../../utils/theme/custom_themes/text_theme.dart';

class RectangularClickableCard extends StatelessWidget {
  const RectangularClickableCard({
    super.key,
    required this.title,
    required this.image,
    required this.title2,
    required this.cardColor,
    required this.shadowColor,
  });

  final String title;
  final String image;
  final String title2;
  final Color cardColor, shadowColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shadowColor: shadowColor,
        elevation: 5.0,
        child: Container(
          height: 170,
          padding:
              const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: cardColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Image(
                  image: AssetImage(image),
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: CSTextTheme.lightTextTheme.titleLarge,
                  ),
                  Text(
                    title2,
                    style: CSTextTheme.lightTextTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
