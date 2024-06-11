import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../features/dashboard/student_dashboard/controller/favourite_controller.dart';
import '../../../utils/constants/colors.dart';
import 'circular_icon.dart';

class CSFavouriteIcon extends StatelessWidget {
  const CSFavouriteIcon(
      {super.key,
      this.icon,
      this.iconSize,
      this.backgroundColor = CSColors.transparent,
      required this.companyName});
  final IconData? icon;
  final double? iconSize;
  final Color? backgroundColor;
  final String companyName;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => CSCircularIcon(
        icon: controller.isFavourite(companyName)
            ? CupertinoIcons.bookmark_fill
            : CupertinoIcons.bookmark,
        iconColor: controller.isFavourite(companyName)
            ? CSColors.thirdColor
            : CSColors.grey,
        onPressed: () => controller.toggleFavoriteProduct(companyName),
        iconSize: iconSize,
        backgroundColor: CSColors.transparent,
      ),
    );
  }
}
