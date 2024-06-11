import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/widgets/Divider/divider.dart';
import '../../../../common/widgets/images/rounded_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/controllers/user controller/recruiter_controller.dart';
import '../../student_dashboard/screen/widget/profile_menu_tile.dart';

class AddJobDetails extends StatelessWidget {
  const AddJobDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecruiterController());
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 140,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: dark ? CSColors.white : CSColors.firstColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            "Post",
            style: dark
                ? CSTextTheme.lightTextTheme.titleMedium
                : CSTextTheme.darkTextTheme.titleMedium,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            bottom: CSSizes.spaceBtwSections,
            right: CSSizes.sm,
            left: CSSizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ver(CSSizes.defaultSpace),
            Center(
              child: CSRoundedImage(
                onPressed: () {
                  controller.pickImage(ImageSource.gallery);
                },
                backgroundColor: CSColors.transparent,
                height: CSDeviceUtils.getScreenHeight() * 0.2,
                imageUrl: companyLogo[0],
              ),
            ),
            const CSDividerBold(),
            StudProfileMenus(
                showActionWidget: false,
                title: "Company Name",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                seeMoreWidget: false,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                showActionWidget: false,
                title: "Drive Date",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                seeMoreWidget: false,
                showChildWidget: true,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "DD/MM/YYYY",
                      hintStyle: dark
                          ? CSTextTheme.darkTextTheme.bodyLarge
                          : CSTextTheme.lightTextTheme.bodyLarge,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                showActionWidget: false,
                title: "About Company",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                seeMoreWidget: false,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                showActionWidget: false,
                title: "Location",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                seeMoreWidget: false,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Last Date of Registration",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Job Profile",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Industry Type",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Qualification",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Salary & Benefits Package",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Cut off Criteria",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Duties/Responsibilities",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Skills Required",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Probation/Training Period",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Service Agreement",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Drive Mode",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Joining Location",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Joining Period",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Selection Process",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
            const CSDividerBold(),
            StudProfileMenus(
                seeMoreWidget: false,
                showActionWidget: false,
                title: "Other Conditions/Details",
                titleStyle: dark
                    ? CSTextTheme.darkTextTheme.headlineSmall
                    : CSTextTheme.lightTextTheme.headlineSmall,
                showChildWidget: true,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                )),
          ],
        ),
      ),
    );
  }
}
