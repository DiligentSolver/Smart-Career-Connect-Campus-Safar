import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';

class CSVerticalCardShimmer extends StatelessWidget {
  const CSVerticalCardShimmer({super.key, this.itemCount = 4});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return CSGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
            width: 100,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              /// Image
              //CSShimmerEffect(width: 150, height: 180),
              SizedBox(height: CSSizes.spaceBtwItems),

              /// Text
              //CSShimmerEffect(width:160, height: 15),
              SizedBox(height: CSSizes.spaceBtwItems / 2),
              //CSShimmerEffect(width: 110, height: 15),
            ])));
  }
}
