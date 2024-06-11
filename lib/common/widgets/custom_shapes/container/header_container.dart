import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class CustomHeaderContainer extends StatelessWidget {
  const CustomHeaderContainer({
    super.key,
    required this.child,
    this.containerColor,
    this.height,
    this.decoration,
    this.padding,
  });

  final Widget child;
  final Color? containerColor;
  final double? height;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return CSCurvedEdgeWidget(
      child: Container(
        height: height,
        color: containerColor,
        decoration: decoration,
        padding: padding,

        /// -- If [size.isInfinite: is not true in Stack] error occurred
        child: Stack(
          children: [
            /// -- Background Custom Shapes
            // Positioned(
            //   top: -150,
            //   right: -250,
            //   child: CSCircularContainer(
            //     // height: 180,
            //     // width: 180,
            //     // radius: 180,
            //     backgroundColor: CSColors.white.withOpacity(0.1),
            //   ),
            // ),
            // Positioned(
            //   top: 100,
            //   right: -300,
            //   child: CSCircularContainer(
            //     // height: 200,
            //     // width: 200,
            //     // radius: 200,
            //     backgroundColor: CSColors.white.withOpacity(0.1),
            //   ),
            // ),
            child
          ],
        ),
      ),
    );
  }
}
