import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';

class CSListLayout extends StatelessWidget {
  const CSListLayout(
      {super.key,
      this.mainAxisExtent,
      required this.itemCount,
      required this.itemBuilder,
      required this.separatorBuilder});

  final double? mainAxisExtent;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int) separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(CSSizes.sm),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder,
    );
  }
}
