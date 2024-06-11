import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../common/styles/shadows.dart';
import '../../../../../utils/theme/custom_themes/text_theme.dart';

class CustomCardsRow extends StatelessWidget {
  const CustomCardsRow({
    super.key,
    required this.cardColor1,
    required this.cardColor2,
    this.onTap1,
    required this.card1text1,
    this.card1text2 = " ",
    required this.card2text1,
    this.card2text2 = " ",
    this.onTap2,
    this.height = 100,
    this.width = 150,
    this.subText = true,
    this.text1Style,
    this.text2Style,
    this.boxShadow = true,
  });

  final String card1text1, card1text2, card2text1, card2text2;
  final Color cardColor1, cardColor2;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;
  final double? height, width;
  final bool subText, boxShadow;
  final TextStyle? text1Style, text2Style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: onTap1,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                boxShadow:
                    boxShadow ? [CSShadowStyle.verticalCardShadow] : null,
                borderRadius: BorderRadius.circular(20.0),
                color: cardColor1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  card1text1,
                  style: text1Style,
                  textAlign: TextAlign.center,
                ),
                subText
                    ? Text(
                        card1text2,
                        style: text2Style,
                        textAlign: TextAlign.center,
                      )
                    : Container()
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap2,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                boxShadow:
                    boxShadow ? [CSShadowStyle.verticalCardShadow] : null,
                borderRadius: BorderRadius.circular(20.0),
                color: cardColor2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  card2text1,
                  style: text1Style,
                  textAlign: TextAlign.center,
                ),
                subText
                    ? Text(
                        card2text2,
                        style: text2Style,
                        textAlign: TextAlign.center,
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
