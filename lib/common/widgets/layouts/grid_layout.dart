import 'package:flutter/material.dart';
import '../../../utils/device/device_utility.dart';

class CSGridLayout extends StatelessWidget {
  const CSGridLayout(
      {super.key,
      this.mainAxisExtent = 220,
      required this.itemCount,
      required this.itemBuilder});

  final double? mainAxisExtent;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: CSDeviceUtils.getScreenHeight() * 0.02,
        crossAxisSpacing: CSDeviceUtils.getScreenWidth() * 0.02,
        mainAxisExtent: mainAxisExtent,
      ),
    );
  }
}
