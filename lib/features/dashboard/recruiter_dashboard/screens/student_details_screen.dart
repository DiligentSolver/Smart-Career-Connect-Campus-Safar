import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:see_more/see_more_widget.dart';
import '../../../../common/widgets/Divider/divider.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/controllers/company.controller/company_controller.dart';
import '../../../authentication/controllers/user controller/student_controller.dart';

class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen(
      {super.key,
      required this.heading,
      required this.fullName,
      required this.resume,
      required this.email,
      required this.mobileNumber,
      required this.about,
      required this.address,
      required this.instituteName,
      required this.course,
      required this.branch,
      required this.startYear,
      required this.passingYear,
      required this.percentage,
      required this.projectTitle,
      required this.projectDescription,
      required this.technologiesUsed,
      required this.projStartDate,
      required this.projEndDate,
      required this.education,
      required this.skills,
      required this.projects});

  final String fullName,
      resume,
      email,
      mobileNumber,
      heading,
      about,
      address,
      instituteName,
      course,
      branch,
      startYear,
      passingYear,
      percentage,
      projectTitle,
      projectDescription,
      technologiesUsed,
      projStartDate,
      projEndDate,
      education,
      skills,
      projects;

  @override
  Widget build(BuildContext context) {
    Get.put(StudentController());
    final pdfController = Get.put(CompanyController());
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
        child: Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Student Details",
          style: dark
              ? CSTextTheme.darkTextTheme.headlineLarge
              : CSTextTheme.lightTextTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            top: CSSizes.listViewSpacing,
            bottom: CSSizes.listViewSpacing,
            left: CSSizes.md,
            right: CSSizes.md),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CSSectionHeading(
                  title: fullName,
                  titleStyle: dark
                      ? CSTextTheme.darkTextTheme.displayMedium
                      : CSTextTheme.lightTextTheme.displayMedium,
                  showTextButton: false,
                ),
                Text(
                  heading,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: dark
                      ? CSTextTheme.darkTextTheme.titleLarge
                      : CSTextTheme.lightTextTheme.titleLarge,
                ),
                CSAppBar(
                  leading: const Icon(
                    CupertinoIcons.mail_solid,
                    size: CSSizes.iconSm,
                  ),
                  centerTitle: false,
                  title: Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                  ),
                  titleTextStyle: dark
                      ? CSTextTheme.darkTextTheme.bodyLarge
                      : CSTextTheme.lightTextTheme.bodyLarge,
                  toolbarHeight: CSSizes.iconMd,
                  leadingWidth: CSSizes.defaultSpace,
                  borderColor: CSColors.transparent,
                ),
                CSAppBar(
                  leading: const Icon(
                    CupertinoIcons.phone,
                    size: CSSizes.iconSm,
                  ),
                  centerTitle: false,
                  title: Text(
                    mobileNumber,
                  ),
                  titleTextStyle: dark
                      ? CSTextTheme.darkTextTheme.bodyLarge
                      : CSTextTheme.lightTextTheme.bodyLarge,
                  toolbarHeight: CSSizes.iconMd,
                  leadingWidth: CSSizes.defaultSpace,
                  borderColor: CSColors.transparent,
                ),
                CSAppBar(
                  leading: const Icon(CupertinoIcons.location_solid,
                      size: CSSizes.iconSm),
                  centerTitle: false,
                  title: Text(
                    address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  titleTextStyle: dark
                      ? CSTextTheme.darkTextTheme.bodyLarge
                      : CSTextTheme.lightTextTheme.bodyLarge,
                  toolbarHeight: CSSizes.iconMd,
                  leadingWidth: CSSizes.defaultSpace,
                  borderColor: CSColors.transparent,
                ),
              ],
            ),
            const CSDivider(),
            CSSectionHeading(
              title: "Resume",
              titleStyle: dark
                  ? CSTextTheme.darkTextTheme.headlineSmall
                  : CSTextTheme.lightTextTheme.headlineSmall,
              showTextButton: false,
            ),
            OutlinedButton(
              onPressed: () {
                pdfController.openFile(url: resume, fileName: 'pdf');
              },
              style: OutlinedButton.styleFrom(
                  disabledBackgroundColor: CSColors.grey,
                  side: const BorderSide(color: CSColors.secondColor),
                  fixedSize: Size(CSDeviceUtils.getScreenWidth() * 0.80, 0.0)),
              child: Text(
                "View Resume",
                style: dark
                    ? CSTextTheme.darkTextTheme.titleLarge
                    : CSTextTheme.lightTextTheme.titleLarge,
              ),
            ),
            const CSDivider(),
            CSSectionHeading(
              title: "About",
              titleStyle: dark
                  ? CSTextTheme.darkTextTheme.headlineSmall
                  : CSTextTheme.lightTextTheme.headlineSmall,
              showTextButton: false,
            ),
            SeeMoreWidget(
              about,
              trimLength: 120,
              textStyle: GoogleFonts.openSans(
                  fontSize: 14,
                  color: dark
                      ? CSColors.white.withOpacity(0.8)
                      : CSColors.black.withOpacity(0.8)),
              seeMoreText: "see more",
              seeMoreStyle:
                  GoogleFonts.openSans(fontSize: 14, color: CSColors.grey),
              seeLessText: "see less",
              seeLessStyle:
                  GoogleFonts.openSans(fontSize: 14, color: CSColors.grey),
            ),
            const CSDivider(),
            CSSectionHeading(
              title: "Education",
              titleStyle: dark
                  ? CSTextTheme.darkTextTheme.headlineSmall
                  : CSTextTheme.lightTextTheme.headlineSmall,
              showTextButton: false,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: course.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CSSectionHeading(
                        title: course,
                        titleStyle: dark
                            ? CSTextTheme.darkTextTheme.titleLarge
                            : CSTextTheme.lightTextTheme.titleLarge,
                        showTextButton: false,
                      ),
                      Text(
                        branch,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ),
                      Text(
                        instituteName,
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleSmall
                            : CSTextTheme.lightTextTheme.titleSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            startYear,
                            style: dark
                                ? CSTextTheme.darkTextTheme.bodyLarge
                                : CSTextTheme.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            " - ",
                            style: dark
                                ? CSTextTheme.darkTextTheme.bodyLarge
                                : CSTextTheme.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            passingYear,
                            style: dark
                                ? CSTextTheme.darkTextTheme.bodyLarge
                                : CSTextTheme.lightTextTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Grade:",
                            style: dark
                                ? CSTextTheme.darkTextTheme.bodyLarge
                                : CSTextTheme.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            percentage,
                            style: dark
                                ? CSTextTheme.darkTextTheme.bodyLarge
                                : CSTextTheme.lightTextTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            const CSDivider(),
            CSSectionHeading(
              title: "Skills",
              titleStyle: dark
                  ? CSTextTheme.darkTextTheme.headlineSmall
                  : CSTextTheme.lightTextTheme.headlineSmall,
              showTextButton: false,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: skills.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    CSSectionHeading(
                      title: skills,
                      titleStyle: dark
                          ? CSTextTheme.darkTextTheme.titleLarge
                          : CSTextTheme.lightTextTheme.titleLarge,
                      showTextButton: false,
                    ),
                  ],
                );
              },
            ),
            const CSDivider(),
            CSSectionHeading(
              title: "Projects",
              titleStyle: dark
                  ? CSTextTheme.darkTextTheme.headlineSmall
                  : CSTextTheme.lightTextTheme.headlineSmall,
              showTextButton: false,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: projects.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CSSectionHeading(
                        title: projects,
                        titleStyle: dark
                            ? CSTextTheme.darkTextTheme.titleLarge
                            : CSTextTheme.lightTextTheme.titleLarge,
                        showTextButton: false,
                      ),
                      SeeMoreWidget(
                        projectDescription,
                        trimLength: 120,
                        textStyle: GoogleFonts.openSans(
                            fontSize: 14,
                            color: dark
                                ? CSColors.white.withOpacity(0.8)
                                : CSColors.black.withOpacity(0.8)),
                        seeMoreText: "see more",
                        seeMoreStyle: GoogleFonts.openSans(
                            fontSize: 14, color: CSColors.grey),
                        seeLessText: "see less",
                        seeLessStyle: GoogleFonts.openSans(
                            fontSize: 14, color: CSColors.grey),
                      ),
                      Text(
                        technologiesUsed,
                        style: dark
                            ? CSTextTheme.darkTextTheme.bodyLarge
                            : CSTextTheme.lightTextTheme.bodyLarge,
                      ),
                      Text(
                        projStartDate,
                        style: dark
                            ? CSTextTheme.darkTextTheme.bodyLarge
                            : CSTextTheme.lightTextTheme.bodyLarge,
                      ),
                      Text(
                        " - ",
                        style: dark
                            ? CSTextTheme.darkTextTheme.bodyLarge
                            : CSTextTheme.lightTextTheme.bodyLarge,
                      ),
                      Text(
                        projEndDate,
                        style: dark
                            ? CSTextTheme.darkTextTheme.bodyLarge
                            : CSTextTheme.lightTextTheme.bodyLarge,
                      ),
                      const CSDivider(),
                    ],
                  );
                }),
          ],
        ),
      ),
    ));
  }
}
