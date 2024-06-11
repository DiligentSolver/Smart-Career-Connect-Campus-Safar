import 'package:campus_safar/features/authentication/controllers/user%20controller/recruiter_controller.dart';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/student_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/Divider/divider.dart';
import '../../../../common/widgets/custom_shapes/cards/horizontal_card.dart';
import '../../../../common/widgets/layouts/list_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<StudentsPage> createState() => _StudCompaniesPageState();
}

class _StudCompaniesPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    bool dark = CSHelperFunctions.isDarkMode(context);
    final controller = Get.put(RecruiterController());
    return SafeArea(
        child: DefaultTabController(
      initialIndex: widget.initialIndex,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Students",
            style: dark
                ? CSTextTheme.darkTextTheme.headlineLarge
                : CSTextTheme.lightTextTheme.headlineLarge,
          ),
          bottom: TabBar(
              isScrollable: true,
              indicatorColor: dark ? CSColors.white : CSColors.firstColor,
              tabs: [
                Tab(
                    child: Text(
                  "Applicants",
                  style: dark
                      ? CSTextTheme.darkTextTheme.bodyLarge
                      : CSTextTheme.lightTextTheme.bodyLarge,
                )),
                Tab(
                  child: Text(
                    "Shortlisted",
                    style: dark
                        ? CSTextTheme.darkTextTheme.bodyLarge
                        : CSTextTheme.lightTextTheme.bodyLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    "Placed",
                    style: dark
                        ? CSTextTheme.darkTextTheme.bodyLarge
                        : CSTextTheme.lightTextTheme.bodyLarge,
                  ),
                ),
                Tab(
                    child: Text(
                  "Offered",
                  style: dark
                      ? CSTextTheme.darkTextTheme.bodyLarge
                      : CSTextTheme.lightTextTheme.bodyLarge,
                ))
              ]),
        ),
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.only(
                top: CSSizes.listViewSpacing,
                right: CSSizes.sm,
                left: CSSizes.sm),
            child: CSListLayout(
              itemCount: controller.user.value.applied!.length,
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
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: CSSizes.listViewSpacing,
                right: CSSizes.sm,
                left: CSSizes.sm),
            child: CSListLayout(
              itemCount: controller.user.value.shortlisted!.length,
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
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: CSSizes.listViewSpacing,
                right: CSSizes.sm,
                left: CSSizes.sm),
            child: CSListLayout(
              itemCount: controller.user.value.placed!.length,
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
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: CSSizes.listViewSpacing,
                right: CSSizes.sm,
                left: CSSizes.sm),
            child: CSListLayout(
              itemCount: controller.user.value.offered!.length,
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
          ),
        ]),
      ),
    ));
  }
}
