import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CSRoundedImage extends StatelessWidget {
  const CSRoundedImage(
      {super.key,
      this.width,
      this.height,
      required this.imageUrl,
      this.applyImageRadius = true,
      this.border,
      this.backgroundColor = CSColors.transparent,
      this.fit = BoxFit.contain,
      this.onPressed,
      this.borderRadius = CSSizes.md,
      this.padding,
      this.isNetworkImage = false});

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final bool isNetworkImage;
  final BoxFit? fit;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
              fit: fit,
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider),
        ),
      ),
    );
  }
}
