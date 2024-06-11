import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_safar/common/widgets/Divider/divider.dart';
import 'package:campus_safar/common/widgets/texts/section_heading.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/edit_profile_photo.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/educations_screen.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/projects_screen.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/add_project_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/edit_about_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/edu_details_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/personal_details_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/skills_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/profile_menu_tile.dart';
import 'package:campus_safar/utils/constants/sizes.dart';
import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:see_more/see_more_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/images/editable_profile_image.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/elevated_button_theme.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/controllers/user controller/student_controller.dart';

class StudProfile extends StatefulWidget {
  const StudProfile({
    super.key,
    required this.title,
  });

  final String title;

  static handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }



  @override
  State<StudProfile> createState() => _StudProfileState();
}

class _StudProfileState extends State<StudProfile> {

  final controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        appBar: CSAppBar(
          title: Text(
            widget.title,
            style: dark
                ? CSTextTheme.darkTextTheme.headlineLarge
                : CSTextTheme.lightTextTheme.headlineLarge,
          ),
          actions: [
            PopupMenuButton(
              onSelected: (item) => StudProfile.handleClick(item),
              icon: const Icon(FontAwesomeIcons.ellipsisVertical),
              iconColor: dark ? CSColors.white : CSColors.black,
              iconSize: CSSizes.iconMd,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      value: 0,
                      onTap: () {},
                      child: Text(
                        "Settings",
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      )),
                  PopupMenuItem(
                      value: 1,
                      onTap: () async {
                        AuthenticationRepository.instance.logOut();
                      },
                      child: Text(
                        "LogOut",
                        style: dark
                            ? CSTextTheme.darkTextTheme.titleMedium
                            : CSTextTheme.lightTextTheme.titleMedium,
                      ))
                ];
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: CSSizes.sm,
                  bottom: CSSizes.sm,
                  right: CSSizes.sm,
                  left: CSSizes.sm),
              decoration: BoxDecoration(
                  color:
                      dark ? CSColors.white.withOpacity(0.1) : CSColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => StuEditProfileImg(image: controller.user.value.profileImg ?? CSImages.user1,)),
                          child: CSEditableProfileImg(
                            width: 80,
                            height: 80,
                            image: 'gs://smartcareerconnect-c8269.appspot.com/Profile Images/XJebmJDfk5RHKDsEqmnaS9OSzy72/001.jpg',
                            icon: CupertinoIcons.camera_circle_fill,
                            iconColor: dark
                                ? CSColors.thirdColor
                                : CSColors.secondColor,
                            iconBackgroundColor: dark
                                ? CSColors.white.withOpacity(0.1)
                                : CSColors.white,
                          ),
                        ),
                        Hor(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                controller.user.value.fullName ?? '',
                                style: dark
                                    ? CSTextTheme.darkTextTheme.displayMedium
                                    : CSTextTheme.lightTextTheme.displayMedium,
                              ),
                            ),
                            Obx(
                              () => Text(
                                controller.user.value.enrollmentNo ?? '',
                                style: dark
                                    ? CSTextTheme.darkTextTheme.bodyLarge
                                    : CSTextTheme.lightTextTheme.bodyLarge,
                              ),
                            ),
                            Obx(
                              () => Text(
                                controller.user.value.heading ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: dark
                                    ? CSTextTheme.darkTextTheme.titleLarge
                                    : CSTextTheme.lightTextTheme.titleLarge,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      right: 1,
                      child: IconButton(
                          onPressed: () =>
                              Get.to(() => const CSEditPersonalDetailForm()),
                          iconSize: CSSizes.iconMd,
                          icon: const Icon(CupertinoIcons.pencil)),
                    )
                  ]),
                  CSAppBar(
                    leading: const Icon(
                      CupertinoIcons.mail_solid,
                      size: CSSizes.iconSm,
                    ),
                    centerTitle: false,
                    title: Obx(
                      () => Text(
                        controller.user.value.email ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
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
                    title: Obx(
                      () => Text(
                        controller.user.value.mobileNumber ?? '',
                      ),
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
                    title: Obx(
                      () => Text(
                        controller.user.value.address ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    titleTextStyle: dark
                        ? CSTextTheme.darkTextTheme.bodyLarge
                        : CSTextTheme.lightTextTheme.bodyLarge,
                    toolbarHeight: CSSizes.iconMd,
                    leadingWidth: CSSizes.defaultSpace,
                    borderColor: CSColors.transparent,
                  ),
                  const CSDividerBold(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: CSDeviceUtils.getScreenHeight() * 0.04,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const CSEditPersonalDetailForm());
                          },
                          style: dark
                              ? CSElevatedButtonTheme
                                  .lightSmallElevatedButtonTheme.style
                              : CSElevatedButtonTheme
                                  .lightSmallElevatedButtonTheme.style,
                          child: AutoSizeText(
                            "Upload Resume",
                            style: CSTextTheme.darkTextTheme.bodyLarge,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: CSDeviceUtils.getScreenHeight() * 0.04,
                        child: ElevatedButton(
                          onPressed: () => Get.to(
                            () => const WebView(
                              gestureNavigationEnabled: true,
                              initialUrl:
                                  'https://www.livecareer.com/resume/check',
                              javascriptMode: JavascriptMode.unrestricted,
                              allowsInlineMediaPlayback: true,
                            ),
                          ),
                          style: dark
                              ? CSElevatedButtonTheme
                                  .lightSmallElevatedButtonTheme.style
                              : CSElevatedButtonTheme
                                  .lightSmallElevatedButtonTheme.style,
                          child: AutoSizeText(
                            "Resume Review",
                            style: CSTextTheme.darkTextTheme.bodyLarge,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const CSDividerBold(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: CSSizes.sm,right: CSSizes.sm),
                child: Column(
                  children: [
                    Obx(
                      () => StudProfileMenus(
                          seeMoreWidget: true,
                          title: "About",
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.headlineMedium
                              : CSTextTheme.lightTextTheme.headlineMedium,
                          onPressed: () =>
                              Get.to(() => const CSEditAboutForm()),
                          seeMoreContent: controller.user.value.about),
                    ),
                    const CSDividerBold(),
                    StudProfileMenus(
                        title: "Education",
                        titleStyle: dark
                            ? CSTextTheme.darkTextTheme.headlineMedium
                            : CSTextTheme.lightTextTheme.headlineMedium,
                        addActionButton: true,
                        actionButton: IconButton(
                            onPressed: () =>
                                Get.to(() => const CSEditEduDetailForm()),
                            iconSize: CSSizes.iconMd,
                            icon: const Icon(CupertinoIcons.add)),
                        onPressed: () =>
                            Get.to(() => const CSEducationScreen()),
                        showChildWidget: true,
                        seeMoreWidget: false,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.user.value.education?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.user.value.education?[index]
                                      ['Institute']??'',
                                  style: dark
                                      ? CSTextTheme.darkTextTheme.titleLarge
                                      : CSTextTheme.lightTextTheme.titleLarge,
                                ),
                                Text(
                                  controller.user.value.education?[index]
                                      ['Degree']??'',
                                  style: dark
                                      ? CSTextTheme.darkTextTheme.bodyLarge
                                      : CSTextTheme.lightTextTheme.bodyLarge,
                                ),
                                Text(
                                  controller.user.value.education?[index]
                                      ['Course']??'',
                                  style: dark
                                      ? CSTextTheme.darkTextTheme.bodyLarge
                                      : CSTextTheme.lightTextTheme.bodyLarge,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.user.value.education?[index]
                                          ['Start Date']??'',
                                      style: dark
                                          ? CSTextTheme.darkTextTheme.bodyLarge
                                          : CSTextTheme
                                              .lightTextTheme.bodyLarge,
                                    ),
                                    Text(
                                      " - ",
                                      style: dark
                                          ? CSTextTheme.darkTextTheme.bodyLarge
                                          : CSTextTheme
                                              .lightTextTheme.bodyLarge,
                                    ),
                                    Text(
                                      controller.user.value.education?[index]
                                          ['End Date']??'',
                                      style: dark
                                          ? CSTextTheme.darkTextTheme.bodyLarge
                                          : CSTextTheme
                                              .lightTextTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Grade: ",
                                      style: dark
                                          ? CSTextTheme.darkTextTheme.bodyLarge
                                          : CSTextTheme
                                              .lightTextTheme.bodyLarge,
                                    ),
                                    Text(
                                      controller.user.value.education?[index]
                                          ['Grade']??'',
                                      style: dark
                                          ? CSTextTheme.darkTextTheme.bodyLarge
                                          : CSTextTheme
                                              .lightTextTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                                const CSDivider(),
                              ],
                            );
                          },
                        )),
                    const CSDividerBold(),
                    StudProfileMenus(
                        title: "Skills",
                        titleStyle: dark
                            ? CSTextTheme.darkTextTheme.headlineMedium
                            : CSTextTheme.lightTextTheme.headlineMedium,
                        showChildWidget: true,
                        changeActionButton: IconButton(
                            onPressed: () =>
                                Get.to(() => const CSEditSkillsForm()),
                            iconSize: CSSizes.iconMd,
                            icon: const Icon(CupertinoIcons.add)),
                        seeMoreWidget: false,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.user.value.skills?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AutoSizeText(
                                controller.user.value.skills?[index],
                                style: dark
                                    ? CSTextTheme.darkTextTheme.titleLarge
                                    : CSTextTheme.lightTextTheme.titleLarge,
                                textAlign: TextAlign.left,
                              );
                          },
                        )),
                    const CSDividerBold(),
                    StudProfileMenus(
                        title: "Projects",
                        titleStyle: dark
                            ? CSTextTheme.darkTextTheme.headlineMedium
                            : CSTextTheme.lightTextTheme.headlineMedium,
                        addActionButton: true,
                        actionButton: IconButton(
                            onPressed: () =>
                                Get.to(() => const CSEditProjectForm()),
                            iconSize: CSSizes.iconMd,
                            icon: const Icon(CupertinoIcons.add)),
                        onPressed: () => Get.to(() => const CSProjectsScreen()),
                        seeMoreWidget: false,
                        showChildWidget: true,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.user.value.projects?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CSSectionHeading(
                                  title: controller.user.value.projects?[index]
                                      ['Project Title']??'',
                                  titleStyle: dark
                                      ? CSTextTheme.darkTextTheme.titleLarge
                                      : CSTextTheme.lightTextTheme.titleLarge,
                                  showTextButton: false,
                                ),
                                SeeMoreWidget(
                                  controller.user.value.projects?[index]
                                      ['Project Description']??'',
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
                                  "Technologies Used: ",
                                  style: dark
                                      ? CSTextTheme.darkTextTheme.bodyLarge
                                      : CSTextTheme
                                      .lightTextTheme.bodyLarge,
                                ),
                                Text(
                                  controller.user.value.projects?[index]
                                      ['Technology Used']??'',
                                  style: dark
                                      ? CSTextTheme.darkTextTheme.bodyLarge
                                      : CSTextTheme.lightTextTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Time Period: ",
                                      style: dark
                                          ? CSTextTheme.darkTextTheme.bodyLarge
                                          : CSTextTheme
                                          .lightTextTheme.bodyLarge,
                                    ),
                                    Text(
                                      controller.user.value.projects?[index]
                                          ['Start Date']??'',
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
                                      controller.user.value.projects?[index]
                                      ['End Date'] ??
                                          '',
                                      style: dark
                                          ? CSTextTheme.darkTextTheme.bodyLarge
                                          : CSTextTheme.lightTextTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                                const CSDivider(),
                              ],
                            );
                          },
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
