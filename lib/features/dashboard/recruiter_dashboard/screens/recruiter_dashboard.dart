import 'package:campus_safar/common/widgets/Divider/divider.dart';
import 'package:campus_safar/common/widgets/layouts/list_layout.dart';
import 'package:campus_safar/common/widgets/texts/section_heading.dart';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/posting_screen.dart';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/rec_notifications.dart';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/student_details_screen.dart';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/students_screen.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:campus_safar/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/custom_shapes/cards/horizontal_card.dart';
import '../../../../common/widgets/custom_shapes/container/header_container.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../authentication/controllers/user controller/recruiter_controller.dart';
import '../../student_dashboard/screen/company_screen.dart';
import '../../student_dashboard/screen/widget/two_cards_row.dart';

class RecDashboard extends StatefulWidget {
  const RecDashboard({super.key});

  @override
  State<RecDashboard> createState() => _RecDashboardState();
}

class _RecDashboardState extends State<RecDashboard> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecruiterController());
    final dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: dark ? CSColors.darkThemeBg : CSColors.lightBg,
        body: Column(
          children: [
            /// Header
            CustomHeaderContainer(
              containerColor: CSColors.firstColor,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CSAppBar(
                      borderColor: Colors.transparent,
                      leading: const CSCircularImage(
                        height: 64,
                        width: 64,
                        //isNetworkImage: true,
                        assetImage: AssetImage(CSImages.user1),
                        //networkImage: Image.file(controller.pickedImage!),
                      ),
                      centerTitle: false,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.user.value.fullName ?? '',
                              style: CSTextTheme.darkTextTheme.headlineMedium,
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.user.value.recruiterId ?? '',
                              style: CSTextTheme.darkTextTheme.headlineSmall,
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.user.value.companyName ?? '',
                              style: CSTextTheme.darkTextTheme.titleLarge,
                            ),
                          )
                        ],
                      ),
                      actions: [
                        IconButton(
                          onPressed: () =>
                              Get.to(() => const RecNotifications()),
                          icon: const Icon(Icons.notifications_rounded),
                          iconSize: CSSizes.iconLg,
                          color: dark ? CSColors.white : CSColors.white,
                        ),
                      ],
                    ),
                    Ver(CSSizes.spaceBtwSections),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                    top: CSSizes.listViewSpacing,
                    right: CSSizes.md,
                    left: CSSizes.md),
                children: [
                  CustomCardsRow(
                    text1Style: CSTextTheme.darkTextTheme.headlineSmall,
                    text2Style: CSTextTheme.darkTextTheme.titleLarge,
                    cardColor1: CSColors.card1,
                    cardColor2: CSColors.card2,
                    card1text1: "${companyNames.length}",
                    card1text2: "Applied Students",
                    card2text1: "${companyNames.length}",
                    card2text2: "Shortlisted Students",
                    onTap1: () =>
                        Get.to(() => const StudentsPage(initialIndex: 1)),
                    onTap2: () =>
                        Get.to(() => const StudCompaniesPage(initialIndex: 2)),
                  ),
                  Ver(15),
                  CustomCardsRow(
                    text1Style: CSTextTheme.darkTextTheme.headlineSmall,
                    text2Style: CSTextTheme.darkTextTheme.titleLarge,
                    cardColor1: CSColors.card3,
                    cardColor2: CSColors.card4,
                    card1text1: "${companyNames.length}",
                    card1text2: "Placed Students",
                    card2text1: "${companyNames.length}",
                    card2text2: "Offered Students",
                    onTap1: () =>
                        Get.to(() => const StudCompaniesPage(initialIndex: 3)),
                    onTap2: () =>
                        Get.to(() => const StudCompaniesPage(initialIndex: 4)),
                  ),
                  Ver(15),
                  Divider(
                    height: CSSizes.dividerHeight,
                    color: dark ? CSColors.darkerGrey : CSColors.grey,
                  ),
                  Ver(10),
                  CSSectionHeading(
                    title: "Job Applicants",
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.headlineSmall
                        : CSTextTheme.lightTextTheme.headlineSmall,
                    onPressed: () =>
                        Get.to(() => const StudentsPage(initialIndex: 1)),
                  ),
                  CSListLayout(
                    itemCount: jobApplicants.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CSHorizontalCard(
                        onTap: () => Get.to(() => StudentDetailsScreen(
                              fullName: jobApplicants[index],
                              heading: studentHeading[index],
                              about:
                                  'Dedicated final year student seeking for an opportunity to contribute my skills in dignified organisation.',
                              address: 'Indore',
                              education: qualification[index],
                              course: qualification[index],
                              branch: 'Information Technology',
                              percentage: eduGrade[index],
                              projectDescription: projDescription[index],
                              passingYear: eduEndYear[index],
                              startYear: eduStartYear[index],
                              email: 'abc@gmail.com',
                              mobileNumber: '91 9009029626',
                              skills: skills[index],
                              resume:
                                  'https://cdn-3.zlibrary.to/v1/files/1c4f6b8c-f8a6-4e8b-b511-e36cb205fba7/download?t=ZBaX3DnxCPeKjKL8tqWNaLhmhdjYEqGx',
                              instituteName: eduInstitute[index],
                              projectTitle: project[index],
                              technologiesUsed: skills[index],
                              projStartDate: eduStartYear[index],
                              projEndDate: eduEndYear[index],
                              projects: '',
                            )),
                        title1: jobApplicants[index],
                        image: studentImg[index],
                        title2: studentHeading[index],
                        title3: qualification[index],
                        title4: eduStartYear[index],
                        title5: eduEndYear[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const CSDividerBold();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => const PostScreen(
                initialIndex: 0,
              )),
          backgroundColor: CSColors.firstColor,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          elevation: 10,
          hoverElevation: 20,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
