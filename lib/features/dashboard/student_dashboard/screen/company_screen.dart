import 'package:campus_safar/common/widgets/images/rounded_image.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/apply_form.dart';
import 'package:campus_safar/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/controllers/company.controller/company_controller.dart';
import 'attendance_screen.dart';

class StudCompaniesPage extends StatefulWidget {
  const StudCompaniesPage({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<StudCompaniesPage> createState() => _StudCompaniesPageState();
}

class _StudCompaniesPageState extends State<StudCompaniesPage> {
  @override
  Widget build(BuildContext context) {
    final pdfController = Get.put(CompanyController());
    bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
        child: DefaultTabController(
      initialIndex: widget.initialIndex,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Companies",
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
                    "Upcoming",
                    style: dark
                        ? CSTextTheme.darkTextTheme.bodyLarge
                        : CSTextTheme.lightTextTheme.bodyLarge,
                  ),
                ),
                Tab(
                    child: Text(
                  "Applied",
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
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: companyNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(companyNames[index]),
                  subtitle: Text(companyDates[index]),
                  leading: CSRoundedImage(
                    borderRadius: CSSizes.sm,
                    backgroundColor: CSColors.white,
                    imageUrl: companyLogo[index],
                    height: 56,
                    width: 56,
                  ),
                  trailing: ElevatedButton(
                      onPressed: () => Get.to(() => const CSApplyForm()),
                      style: dark
                          ? CSElevatedButtonTheme.darkElevatedButtonTheme.style
                          : CSElevatedButtonTheme
                              .lightElevatedButtonTheme.style,
                      child: const Text('Apply')),
                );
              }),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: companyNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(companyNames[index]),
                  subtitle: Text(companyDates[index]),
                  leading: CSRoundedImage(
                    borderRadius: CSSizes.sm,
                    backgroundColor: CSColors.white,
                    imageUrl: companyLogo[index],
                    height: 56,
                    width: 56,
                  ),
                  trailing: ElevatedButton(
                      onPressed: () => Get.to(() => const AttendancePage()),
                      style: dark
                          ? CSElevatedButtonTheme.darkElevatedButtonTheme.style
                          : CSElevatedButtonTheme
                              .lightElevatedButtonTheme.style,
                      child: const Text('Attendance')),
                );
              }),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: companyNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(companyNames[index]),
                  subtitle: Text(companyDates[index]),
                  leading: CSRoundedImage(
                    borderRadius: CSSizes.sm,
                    backgroundColor: CSColors.white,
                    imageUrl: companyLogo[index],
                    height: 56,
                    width: 56,
                  ),
                  trailing: ElevatedButton(
                      onPressed: () {
                        pdfController.openFile(
                            url:
                                'https://community.pepperdine.edu/studentemployment/content/job-offer-letter-template.pdf',
                            fileName: 'job-offer-letter-template.pdf');
                      },
                      style: dark
                          ? CSElevatedButtonTheme.darkElevatedButtonTheme.style
                          : CSElevatedButtonTheme
                              .lightElevatedButtonTheme.style,
                      child: const Text('View')),
                );
              }),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: companyNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(companyNames[index]),
                  subtitle: Text(companyDates[index]),
                  leading: CSRoundedImage(
                    borderRadius: CSSizes.sm,
                    backgroundColor: CSColors.white,
                    imageUrl: companyLogo[index],
                    height: 56,
                    width: 56,
                  ),
                  trailing: ElevatedButton(
                      onPressed: () {
                        pdfController.openFile(
                            url:
                                'https://community.pepperdine.edu/studentemployment/content/job-offer-letter-template.pdf',
                            fileName: 'job-offer-letter-template.pdf');
                      },
                      style: dark
                          ? CSElevatedButtonTheme.darkElevatedButtonTheme.style
                          : CSElevatedButtonTheme
                              .lightElevatedButtonTheme.style,
                      child: const Text('View')),
                );
              }),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: companyNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(companyNames[index]),
                  subtitle: Text(companyDates[index]),
                  leading: CSRoundedImage(
                    borderRadius: CSSizes.sm,
                    backgroundColor: CSColors.white,
                    imageUrl: companyLogo[index],
                    height: 56,
                    width: 56,
                  ),
                  trailing: ElevatedButton(
                      onPressed: () {
                        pdfController.openFile(
                            url:
                                'https://community.pepperdine.edu/studentemployment/content/job-offer-letter-template.pdf',
                            fileName: 'job-offer-letter-template');
                      },
                      style: dark
                          ? CSElevatedButtonTheme.darkElevatedButtonTheme.style
                          : CSElevatedButtonTheme
                              .lightElevatedButtonTheme.style,
                      child: const Text('View')),
                );
              }),
        ]),
      ),
    ));
  }
}
