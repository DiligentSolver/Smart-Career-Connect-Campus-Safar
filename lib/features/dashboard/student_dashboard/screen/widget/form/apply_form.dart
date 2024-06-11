import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/edu_details_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/personal_details_form.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/skills_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:see_more/see_more_widget.dart';
import '../../../../../../common/widgets/Divider/divider.dart';
import '../../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../../../authentication/controllers/user controller/recruiter_controller.dart';
import '../../../../../authentication/controllers/user controller/student_controller.dart';
import '../../register_face_view.dart';
import 'add_project_form.dart';
import 'edit_about_form.dart';

class CSApplyForm extends StatelessWidget {
  const CSApplyForm({super.key, this.hintStyle});

  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    final recController = Get.put(RecruiterController());
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: dark ? CSColors.darkThemeBg : CSColors.white,
        appBar: CSAppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.close,
              size: CSSizes.iconMd,
            ),
            color: dark ? CSColors.white : CSColors.black,
          ),
          title: Text(
            "Apply",
            style: dark
                ? CSTextTheme.darkTextTheme.headlineLarge
                : CSTextTheme.lightTextTheme.headlineLarge,
          ),
          borderColor: CSColors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
              left: CSSizes.listViewSpacing, right: CSSizes.listViewSpacing),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CSSectionHeading(
                    title: controller.user.value.fullName ?? '',
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.displayMedium
                        : CSTextTheme.lightTextTheme.displayMedium,
                    showTextButton: false,
                    showActionWidget: true,
                    actionWidget: IconButton(
                        onPressed: () =>
                            Get.to(() => const CSEditPersonalDetailForm()),
                        iconSize: CSSizes.iconMd,
                        icon: const Icon(CupertinoIcons.pencil)),
                  ),
                  Text(
                    controller.user.value.heading ?? 'Heading',
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
                      controller.user.value.email ?? 'Email',
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
                      controller.user.value.mobileNumber ?? 'Mobile Number',
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
                      controller.user.value.address ?? 'Address',
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
              recController.image != null
                  ? GestureDetector(
                      onTap: () {
                        recController.openFile(
                          url: controller.user.value.resume ?? 'Resume',
                        );
                      },
                      child: Container(
                        width: CSDeviceUtils.getScreenWidth() / 2,
                        height: CSDeviceUtils.getScreenHeight() * 0.20,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CSColors.white.withOpacity(0.1),
                        ),
                        child: recController.image,
                      ),
                    )
                  : Container(),
              const CSDividerBold(),
              OutlinedButton(
                onPressed: () {
                  recController.pickFile(FileType.custom, ['pdf']);
                },
                style: OutlinedButton.styleFrom(
                    disabledBackgroundColor: CSColors.grey,
                    side: const BorderSide(color: CSColors.secondColor),
                    fixedSize:
                        Size(CSDeviceUtils.getScreenWidth() * 0.80, 0.0)),
                child: Text(
                  "Upload Resume",
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
                showActionWidget: true,
                actionWidget: IconButton(
                    onPressed: () => Get.to(() => const CSEditAboutForm()),
                    icon: const Icon(CupertinoIcons.pencil)),
              ),
              SeeMoreWidget(
                controller.user.value.about ?? 'About',
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
                  showActionWidget: true,
                  actionWidget: IconButton(
                      onPressed: () =>
                          Get.to(() => const CSEditEduDetailForm()),
                      iconSize: CSSizes.iconMd,
                      icon: const Icon(Icons.add))),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.user.value.education?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CSSectionHeading(
                          title: controller.user.value.education?[index]
                              ['Institute'],
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.titleLarge
                              : CSTextTheme.lightTextTheme.titleLarge,
                          showTextButton: false,
                          showActionWidget: true,
                          actionWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      Get.to(() => const CSEditEduDetailForm()),
                                  iconSize: CSSizes.iconMd,
                                  icon: const Icon(CupertinoIcons.pencil)),
                              IconButton(
                                  onPressed: () => Get.delete(),
                                  iconSize: CSSizes.iconMd,
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                        Text(
                          controller.user.value.education?[index]['Degree'],
                          style: dark
                              ? CSTextTheme.darkTextTheme.titleMedium
                              : CSTextTheme.lightTextTheme.titleMedium,
                        ),
                        Text(
                          controller.user.value.education?[index]['Course'],
                          style: dark
                              ? CSTextTheme.darkTextTheme.titleSmall
                              : CSTextTheme.lightTextTheme.titleSmall,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              controller.user.value.education?[index]
                                  ['Start Date'],
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
                              controller.user.value.education?[index]
                                  ['End Date'],
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
                              "Grade: ",
                              style: dark
                                  ? CSTextTheme.darkTextTheme.bodyLarge
                                  : CSTextTheme.lightTextTheme.bodyLarge,
                            ),
                            Text(
                              controller.user.value.education?[index]['Grade'],
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
                  showActionWidget: true,
                  actionWidget: IconButton(
                      onPressed: () => Get.to(() => const CSEditSkillsForm()),
                      icon: const Icon(Icons.add))),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.user.value.skills?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      CSSectionHeading(
                        title: controller.user.value.skills?[index],
                        titleStyle: dark
                            ? CSTextTheme.darkTextTheme.titleLarge
                            : CSTextTheme.lightTextTheme.titleLarge,
                        showTextButton: false,
                        showActionWidget: true,
                        actionWidget: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete)),
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
                  showActionWidget: true,
                  actionWidget: IconButton(
                      onPressed: () => Get.to(() => const CSEditProjectForm()),
                      icon: const Icon(Icons.add))),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.user.value.projects?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CSSectionHeading(
                          title: controller.user.value.projects?[index]
                              ['Project Title'],
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.titleLarge
                              : CSTextTheme.lightTextTheme.titleLarge,
                          showTextButton: false,
                          showActionWidget: true,
                          actionWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      Get.to(() => const CSEditProjectForm()),
                                  iconSize: CSSizes.iconMd,
                                  icon: const Icon(CupertinoIcons.pencil)),
                              IconButton(
                                  onPressed: () => Get.delete(),
                                  iconSize: CSSizes.iconMd,
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                        SeeMoreWidget(
                          controller.user.value.projects?[index]
                              ['Project Description'],
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
                          controller.user.value.projects?[index]
                              ['Technologies Used'],
                          style: dark
                              ? CSTextTheme.darkTextTheme.bodyLarge
                              : CSTextTheme.lightTextTheme.bodyLarge,
                        ),
                        Text(
                          controller.user.value.projects?[index]['Start Date'],
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
                          controller.user.value.projects?[index]['End Date'] ??
                              '',
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
        floatingActionButton: SizedBox(
          width: 140,
          height: 40,
          child: FloatingActionButton(
            onPressed: () => Get.to(() => const RegisterFaceView()),
            backgroundColor: dark ? CSColors.white : CSColors.firstColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              "Next",
              style: dark
                  ? CSTextTheme.lightTextTheme.titleMedium
                  : CSTextTheme.darkTextTheme.titleMedium,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
