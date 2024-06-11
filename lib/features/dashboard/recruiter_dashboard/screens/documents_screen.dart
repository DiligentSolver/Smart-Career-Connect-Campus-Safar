import 'package:campus_safar/features/authentication/controllers/user%20controller/recruiter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/elevated_button_theme.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/controllers/company.controller/company_controller.dart';

class RecDocuments extends StatefulWidget {
  const RecDocuments({super.key, required this.initialIndex});
  final int initialIndex;
  @override
  State<RecDocuments> createState() => _RecDocumentsState();
}

class _RecDocumentsState extends State<RecDocuments> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecruiterController());
    final pdfController = Get.put(CompanyController());
    final dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
        child: DefaultTabController(
      initialIndex: widget.initialIndex,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "My Documents",
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
                    "Shortlists",
                    style: dark
                        ? CSTextTheme.darkTextTheme.bodyLarge
                        : CSTextTheme.lightTextTheme.bodyLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    "Placed Lists",
                    style: dark
                        ? CSTextTheme.darkTextTheme.bodyLarge
                        : CSTextTheme.lightTextTheme.bodyLarge,
                  ),
                ),
                Tab(
                    child: Text(
                  "Offer Letters",
                  style: dark
                      ? CSTextTheme.darkTextTheme.bodyLarge
                      : CSTextTheme.lightTextTheme.bodyLarge,
                )),
              ]),
        ),
        body: TabBarView(children: [
          ListView.builder(
              padding: const EdgeInsets.all(CSSizes.listViewSpacing),
              shrinkWrap: true,
              itemCount: controller.user.value.shortlists?.length,
              itemBuilder: (BuildContext context, int index) {
                return CSSectionHeading(
                  title: controller.user.value.shortlists?[index],
                  titleStyle: dark
                      ? CSTextTheme.darkTextTheme.titleLarge
                      : CSTextTheme.lightTextTheme.titleLarge,
                  showTextButton: false,
                  showActionWidget: true,
                  actionWidget: ElevatedButton(
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
              padding: const EdgeInsets.all(CSSizes.listViewSpacing),
              shrinkWrap: true,
              itemCount: controller.user.value.placedList?.length,
              itemBuilder: (BuildContext context, int index) {
                return CSSectionHeading(
                  title: controller.user.value.placedList?[index],
                  titleStyle: dark
                      ? CSTextTheme.darkTextTheme.titleLarge
                      : CSTextTheme.lightTextTheme.titleLarge,
                  showTextButton: false,
                  showActionWidget: true,
                  actionWidget: ElevatedButton(
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
              padding: const EdgeInsets.all(CSSizes.listViewSpacing),
              shrinkWrap: true,
              itemCount: controller.user.value.offerLetters?.length,
              itemBuilder: (BuildContext context, int index) {
                return CSSectionHeading(
                  title: controller.user.value.offerLetters?[index],
                  titleStyle: dark
                      ? CSTextTheme.darkTextTheme.titleLarge
                      : CSTextTheme.lightTextTheme.titleLarge,
                  showTextButton: false,
                  showActionWidget: true,
                  actionWidget: ElevatedButton(
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
        ]),
      ),
    ));
  }
}
