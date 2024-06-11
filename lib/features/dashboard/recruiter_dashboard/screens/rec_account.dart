import 'package:campus_safar/common/widgets/Divider/divider.dart';
import 'package:campus_safar/common/widgets/images/circular_image.dart';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/rec_profile.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/profile_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/custom_shapes/container/header_container.dart';
import '../../../../common/widgets/list_tiles/profile_menu.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/controllers/user controller/recruiter_controller.dart';
import '../../student_dashboard/screen/account_screen.dart';
import 'documents_screen.dart';

class RecAccount extends StatefulWidget {
  const RecAccount({super.key});

  @override
  State<RecAccount> createState() => _RecAccountState();
}

class _RecAccountState extends State<RecAccount> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecruiterController());
    final dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: dark ? CSColors.darkThemeBg : CSColors.white,
        body: Column(children: [
          /// Header
          CustomHeaderContainer(
            containerColor: CSColors.firstColor,
            child: Column(
              children: [
                /// App Bar
                CSAppBar(
                  title: Text(
                    "Account",
                    style: dark
                        ? CSTextTheme.darkTextTheme.headlineLarge
                        : CSTextTheme.lightTextTheme.headlineLarge,
                  ),
                  borderColor: CSColors.transparent,
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

                /// User Profile Card
                Obx(
                  () => CSUserProfileTile(
                    leading: const CSCircularImage(
                      assetImage: AssetImage(CSImages.user1),
                      // networkImage: Image.file(controller.pickedImage),
                    ),
                    onPressed: () => Get.to(() => const RecProfile()),
                    title: controller.user.value.fullName ?? '',
                    subtitle: controller.user.value.recruiterId ?? '',
                    trailingColor: CSColors.white,
                  ),
                ),
                Ver(CSSizes.spaceBtwSections),
              ],
            ),
          ),

          /// Body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StudProfileMenus(
                    title: "Profile Information",
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.headlineMedium
                        : CSTextTheme.lightTextTheme.headlineMedium,
                    seeMoreWidget: false,
                    showChildWidget: true,
                    onPressed: () => Get.to(() => const RecProfile()),
                    child: Column(
                      children: [
                        CSProfileMenu(
                          title: 'E-mail:',
                          value: controller.user.value.email ?? '',
                          showIcon: false,
                        ),
                        const CSDividerBold(),
                        CSProfileMenu(
                          title: 'Mobile Number:',
                          value: controller.user.value.mobileNumber ?? '',
                          showIcon: false,
                        ),
                        const CSDividerBold(),
                        CSProfileMenu(
                          title: 'Organisation:',
                          value: controller.user.value.companyName ?? '',
                          showIcon: false,
                        ),
                        const CSDividerBold(),
                        CSProfileMenu(
                          title: 'Designation:',
                          value: controller.user.value.designation ?? '',
                          showIcon: false,
                        ),
                        const CSDividerBold(),
                        CSProfileMenu(
                          title: 'Location:',
                          value: controller.user.value.location ?? '',
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.titleLarge
                              : CSTextTheme.lightTextTheme.titleLarge,
                          valueStyle: dark
                              ? CSTextTheme.darkTextTheme.bodyLarge
                              : CSTextTheme.lightTextTheme.bodyLarge,
                          showIcon: false,
                        ),
                      ],
                    ),
                  ),
                  const CSDividerBold(),
                  StudProfileMenus(
                    title: "My Documents",
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.headlineMedium
                        : CSTextTheme.lightTextTheme.headlineMedium,
                    showActionWidget: false,
                    seeMoreWidget: false,
                    showChildWidget: true,
                    child: Column(
                      children: [
                        CSSectionHeading(
                          title: "Shortlists",
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.titleLarge
                              : CSTextTheme.lightTextTheme.titleLarge,
                          showTextButton: false,
                          showActionWidget: true,
                          actionWidget: IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: CSSizes.iconMd,
                            ),
                            onPressed: () => Get.to(() => const RecDocuments(
                                  initialIndex: 0,
                                )),
                          ),
                        ),
                        const CSDividerBold(),
                        CSSectionHeading(
                          title: "Placed Lists",
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.titleLarge
                              : CSTextTheme.lightTextTheme.titleLarge,
                          showTextButton: false,
                          showActionWidget: true,
                          actionWidget: IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: CSSizes.iconMd,
                            ),
                            onPressed: () => Get.to(() => const RecDocuments(
                                  initialIndex: 0,
                                )),
                          ),
                        ),
                        const CSDividerBold(),
                        CSSectionHeading(
                          title: "Offer Letters",
                          titleStyle: dark
                              ? CSTextTheme.darkTextTheme.titleLarge
                              : CSTextTheme.lightTextTheme.titleLarge,
                          showTextButton: false,
                          showActionWidget: true,
                          actionWidget: IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: CSSizes.iconMd,
                            ),
                            onPressed: () => Get.to(() => const RecDocuments(
                                  initialIndex: 1,
                                )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
