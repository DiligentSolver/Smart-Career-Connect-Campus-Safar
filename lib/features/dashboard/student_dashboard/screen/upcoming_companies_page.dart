import 'package:campus_safar/common/widgets/Divider/divider.dart';
import 'package:campus_safar/common/widgets/custom_shapes/container/header_container.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/apply_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/profile_menu_tile.dart';
import 'package:campus_safar/utils/constants/sizes.dart';
import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/icons/favourite_icon.dart';
import '../../../../common/widgets/images/rounded_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';

class UpcomingCompanyPage extends StatelessWidget {
  const UpcomingCompanyPage({
    super.key,
    required this.title,
    required this.image,
    required this.date,
    required this.aboutCompany,
    required this.location,
    required this.lastDate,
    required this.jobProfile,
    required this.industryType,
    required this.salaryBenefits,
    required this.qualification,
    required this.cutOff,
    required this.responsibilities,
    required this.skillsRequired,
    required this.probationPeriod,
    required this.serviceAgreement,
    required this.joiningLocation,
    required this.driveMode,
    required this.joiningPeriod,
    required this.selectionProcess,
    required this.otherConditions,
  });

  final String title;
  final String image;
  final String date;
  final String aboutCompany;
  final String location;
  final String lastDate;
  final String jobProfile;
  final String industryType;
  final String salaryBenefits;
  final String qualification;
  final String cutOff;
  final String responsibilities;
  final String skillsRequired;
  final String probationPeriod;
  final String serviceAgreement;
  final String joiningLocation;
  final String driveMode;
  final String joiningPeriod;
  final String selectionProcess;
  final String otherConditions;

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: 140,
          height: 40,
          child: FloatingActionButton(
            onPressed: () => Get.to(() => const CSApplyForm()),
            backgroundColor: dark ? CSColors.white : CSColors.firstColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              "Apply Now",
              style: dark
                  ? CSTextTheme.lightTextTheme.titleMedium
                  : CSTextTheme.darkTextTheme.titleMedium,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: CSAppBar(
          backgroundColor: CSColors.firstColor,
          borderColor: Colors.transparent,
          showBackArrow: true,
          changeArrowColor: true,
          arrowColor: CSColors.white,
          actions: [
            CSFavouriteIcon(
              companyName: title,
            )
          ],
        ),
        body: Column(
          children: [
            CustomHeaderContainer(
              padding: const EdgeInsets.only(bottom: 40.0, right: 15, left: 15),
              containerColor: CSColors.firstColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CSRoundedImage(
                      backgroundColor: CSColors.transparent,
                      height: CSDeviceUtils.getScreenHeight() * 0.2,
                      imageUrl: image,
                      isNetworkImage: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        style: CSTextTheme.darkTextTheme.displayLarge,
                      ),
                      Text(
                        date,
                        style: CSTextTheme.darkTextTheme.bodyLarge,
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    bottom: CSSizes.spaceBtwSections,
                    right: CSSizes.sm,
                    left: CSSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StudProfileMenus(
                      showActionWidget: false,
                      title: "About Company",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      seeMoreContent: aboutCompany,
                      trimLength: 200,
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      showActionWidget: false,
                      title: "Location",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      seeMoreWidget: false,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        location,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Last Date of Registration",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        lastDate,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Job Profile",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        jobProfile,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Industry Type",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        industryType,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Qualification",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        qualification,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Salary & Benefits Package",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        salaryBenefits,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Cut off Criteria",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        cutOff,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Duties/Responsibilities",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        responsibilities,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Skills Required",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        skillsRequired,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Probation/Training Period",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        probationPeriod,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Service Agreement",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        serviceAgreement,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Drive Mode",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        driveMode,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Joining Location",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        joiningLocation,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Joining Period",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        joiningPeriod,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Selection Process",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        selectionProcess,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                      seeMoreWidget: false,
                      showActionWidget: false,
                      title: "Other Conditions/Details",
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.headlineSmall
                          : CSTextTheme.lightTextTheme.headlineSmall,
                      showChildWidget: true,
                      child: Text(
                        textAlign: TextAlign.left,
                        otherConditions,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
