import 'package:campus_safar/common/widgets/appbar/app_bar.dart';
import 'package:campus_safar/features/authentication/controllers/user%20controller/admin_controller.dart';
import 'package:campus_safar/utils/theme/custom_themes/text_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../../../../common/widgets/Divider/divider.dart';
import '../../../../common/widgets/custom_shapes/cards/horizontal_card.dart';
import '../../../../common/widgets/custom_shapes/cards/vertical_card.dart';
import '../../../../common/widgets/custom_shapes/container/header_container.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/layouts/list_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../authentication/controllers/company.controller/company_controller.dart';
import '../../../authentication/controllers/user controller/student_controller.dart';
import '../../recruiter_dashboard/screens/posting_screen.dart';
import '../../recruiter_dashboard/screens/student_details_screen.dart';
import '../../recruiter_dashboard/screens/students_screen.dart';
import '../../student_dashboard/screen/company_screen.dart';
import '../../student_dashboard/screen/upcoming_companies_page.dart';
import 'admin_modules/showrecruitersid.dart';
import 'admin_modules/showrecruitersinfo.dart';
import 'notifications_screen.dart';

class RecruiterSectionScreen extends StatefulWidget {
  const RecruiterSectionScreen({super.key});

  @override
  State<RecruiterSectionScreen> createState() => _RecruiterSectionScreenState();
}

class _RecruiterSectionScreenState extends State<RecruiterSectionScreen> {
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
    final controller = Get.put(AdminController());
    final dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
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
                        assetImage: AssetImage(CSImages.lightAppLogo),
                        //networkImage: Image.file(controller.pickedImage!),
                      ),
                      centerTitle: false,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.user.value.fullName??'',
                              style: CSTextTheme.darkTextTheme.headlineMedium,
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.user.value.adminId??'',
                              style: CSTextTheme.darkTextTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        IconButton(
                          onPressed: () => Get.to(() => const AdmNotifications(
                              title: CSTexts.notification)),
                          icon: const Icon(Icons.notifications_rounded),
                          iconSize: CSSizes.iconLg,
                          color: CSColors.white,
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
                  GestureDetector(
                      onTap: () {
                        Get.to(() => const ShowRecruiterIds());
                      },
                      child: Container(
                          padding: const EdgeInsets.all(CSSizes.sm),
                          decoration: BoxDecoration(
                              color: dark
                                  ? CSColors.white.withOpacity(0.1)
                                  : CSColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: Row(children: [
                            Text(
                              'Recruiter IDs',
                              style: dark
                                  ? CSTextTheme.darkTextTheme.titleLarge
                                  : CSTextTheme.lightTextTheme.titleLarge,
                            )
                          ]))),
                  const CSDividerBold(),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => const ShowRecruitersInfo());
                      },
                      child: Container(
                          padding: const EdgeInsets.all(CSSizes.sm),
                          decoration: BoxDecoration(
                              color: dark
                                  ? CSColors.white.withOpacity(0.1)
                                  : CSColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: Row(children: [
                            Text(
                              'Recruiter Information',
                              style: dark
                                  ? CSTextTheme.darkTextTheme.titleLarge
                                  : CSTextTheme.lightTextTheme.titleLarge,
                            )
                          ]))),
                  Ver(15),
                  Divider(
                    height: CSSizes.dividerHeight,
                    color: dark ? CSColors.darkerGrey : CSColors.grey,
                  ),
                  Ver(10),
                  CSSectionHeading(
                    title: CSTexts.dashboardSubTitle,
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.headlineSmall
                        : CSTextTheme.lightTextTheme.headlineSmall,
                    onPressed: () => Get.to(() => const StudCompaniesPage(
                          initialIndex: 0,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        backgroundBlendMode: BlendMode.hue,
                        color: dark
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
                                    color: dark
                                        ? CSColors.white
                                        : CSColors.firstColor)),
                          ),
                  )
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
