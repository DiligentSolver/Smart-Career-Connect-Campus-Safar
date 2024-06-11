
import 'package:campus_safar/common/widgets/appbar/app_bar.dart';
import 'package:campus_safar/common/widgets/images/circular_image.dart';
import 'package:campus_safar/common/widgets/texts/section_heading.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/company_screen.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/upcoming_companies_page.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/two_cards_row.dart';
import 'package:campus_safar/utils/constants/enums.dart';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:campus_safar/utils/constants/text_strings.dart';
import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../../../../common/widgets/custom_shapes/cards/vertical_card.dart';
import '../../../../common/widgets/custom_shapes/container/header_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/controllers/company.controller/company_controller.dart';
import '../../../authentication/controllers/user controller/student_controller.dart';
import 'chat_screen.dart';
import 'notifications_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoaded = false;
  final stuController = Get.put(StudentController());
  final companyController = Get.put(CompanyController());

  List<Map<String,dynamic>>companyList = [];

  _getCompanyDetails() async {
    final List<Map<String,dynamic>> tempList = [];
    final companyCollection = FirebaseFirestore.instance.collection('Upcoming Companies');
    final data = await companyCollection.get();
    for(var doc in data.docs){
      tempList.add(doc.data());
    }
    setState(() {
      companyList = tempList;
      if(companyList.isNotEmpty){
        isLoaded = true;
      }
      else{
        isLoaded = false;
      }
    });
  }

  @override
  void initState() {
    _getCompanyDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeaderContainer(
                containerColor: CSColors.firstColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CSAppBar(
                        borderColor: Colors.transparent,
                        leading: const CSCircularImage(
                          height: 64,
                          width: 64,
                          assetImage: AssetImage(CSImages.user1),
                         // networkImage: Image.file(stuController.pickedImage!),
                        ),
                        centerTitle: false,
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              CSTexts.dashboardTitle,
                              style: darkMode
                                  ? CSTextTheme.darkTextTheme.displaySmall
                                  : CSTextTheme.darkTextTheme.displaySmall,
                            ),
                           Text(
                                stuController.user.value.fullName ??
                                    'Student Name',
                                style: darkMode
                                    ? CSTextTheme.darkTextTheme.headlineMedium
                                    : CSTextTheme.darkTextTheme.headlineMedium,
                              ),
                          ],
                        ),
                        actions: [
                          IconButton(
                            onPressed: () =>
                                Get.to(() => const StudNotifications()),
                            icon: const Icon(Icons.notifications_rounded),
                            iconSize: CSSizes.iconLg,
                            color: darkMode ? CSColors.white : CSColors.white,
                          ),
                        ],
                      ),
                      Ver(CSSizes.spaceBtwSections),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Ver(20),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        CustomCardsRow(
                          text1Style: CSTextTheme.darkTextTheme.displaySmall,
                          text2Style: CSTextTheme.darkTextTheme.headlineSmall,
                          cardColor1: CSColors.card1,
                          cardColor2: CSColors.card2,
                          card1text1: "${companyNames.length}",
                          card1text2: "Applied",
                          card2text1: "${companyNames.length}",
                          card2text2: "Shortlisted",
                          onTap1: () => Get.to(
                              () => const StudCompaniesPage(initialIndex: 1)),
                          onTap2: () => Get.to(
                              () => const StudCompaniesPage(initialIndex: 2)),
                        ),
                        Ver(15),
                        CustomCardsRow(
                          text1Style: CSTextTheme.darkTextTheme.displaySmall,
                          text2Style: CSTextTheme.darkTextTheme.headlineSmall,
                          cardColor1: CSColors.card3,
                          cardColor2: CSColors.card4,
                          card1text1: "${companyNames.length}",
                          card1text2: "Placed",
                          card2text1: "${companyNames.length}",
                          card2text2: "Offered",
                          onTap1: () => Get.to(
                              () => const StudCompaniesPage(initialIndex: 3)),
                          onTap2: () => Get.to(
                              () => const StudCompaniesPage(initialIndex: 4)),
                        ),
                        Ver(15),
                        Divider(
                          height: CSSizes.dividerHeight,
                          color: darkMode ? CSColors.darkerGrey : CSColors.grey,
                        ),
                        Ver(10),
                        CSSectionHeading(
                          title: CSTexts.dashboardSubTitle,
                          titleStyle: darkMode
                              ? CSTextTheme.darkTextTheme.headlineSmall
                              : CSTextTheme.lightTextTheme.headlineSmall,
                          onPressed: () => Get.to(() => const StudCompaniesPage(
                                initialIndex: 0,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        backgroundBlendMode: BlendMode.hue,
                        color: darkMode
                            ? CSColors.darkBg.withOpacity(0.2)
                            : CSColors.lightBg.withOpacity(0.2)),
                    height: CSDeviceUtils.getScreenHeight() / 2 * 0.60,
                    child: isLoaded
                        ? ScrollSnapList(
                            initialIndex: 1,
                            shrinkWrap: true,
                            onItemFocus: (index) {},
                            dynamicItemSize: true,
                            itemSize: CSDeviceUtils.getScreenWidth() * 0.45,
                            itemCount: companyList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              companyController.fetchCompanyRecord(index);
                              return CSVerticalCard(
                                title1: companyController.company.value.companyName,
                                title2: companyController.company.value.campusDate,
                                image: companyController.company.value.logo,
                                onTap: () => Get.to(() => UpcomingCompanyPage(
                                      title: companyController.company.value.companyName,
                                      image: companyController.company.value.logo,
                                      date: companyController.company.value.lastDate,
                                      aboutCompany: companyController.company.value.about,
                                      location: companyController.company.value.headQuarter,
                                      lastDate: companyController.company.value.lastDate,
                                      jobProfile: companyController.company.value.jobProfile,
                                      industryType: companyController.company.value.industryType,
                                      qualification: companyController.company.value.qualification,
                                      salaryBenefits: companyController.company.value.salaryBenefits,
                                      cutOff: companyController.company.value.cutOff,
                                      responsibilities:
                                      companyController.company.value.responsibilities,
                                      skillsRequired: companyController.company.value.skillsRequired,
                                      probationPeriod: companyController.company.value.probationPeriod,
                                      serviceAgreement: companyController.company.value.serviceAgreement,
                                      driveMode: companyController.company.value.driveMode,
                                      joiningLocation: companyController.company.value.joiningLocation,
                                      joiningPeriod: companyController.company.value.joiningPeriod,
                                      selectionProcess:
                                      companyController.company.value.selectionProcess,
                                      otherConditions:companyController.company.value.otherConditions
                                    )),
                                imgContainerHeight:
                                    CSDeviceUtils.getScreenHeight() * 0.190,
                              );
                            },
                          )
                        : Center(
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                    color: darkMode
                                        ? CSColors.white
                                        : CSColors.firstColor)),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => const ChatScreenPage()),
          backgroundColor: darkMode ? CSColors.white : CSColors.firstColor,
          foregroundColor: darkMode ? CSColors.firstColor : CSColors.white,
          shape: const CircleBorder(),
          elevation: 10,
          hoverElevation: 20,
          child: const Icon(
            Icons.support_agent,
            size: 40,
          ),
        ),
      ),
    );
  }
}
