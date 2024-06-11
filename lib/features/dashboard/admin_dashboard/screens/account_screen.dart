import 'package:campus_safar/common/widgets/Divider/divider.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/custom_shapes/container/header_container.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/controllers/user controller/admin_controller.dart';
import '../../student_dashboard/screen/widget/profile_menu_tile.dart';
import 'admin_modules/showadminid.dart';
import 'admin_modules/showadmininfo.dart';
import 'documents_screen.dart';

class AdmAccount extends StatelessWidget {
  const AdmAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());
    final dark = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
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
                Column(
                  children: [
                    const CSCircularImage(
                      assetImage: AssetImage(CSImages.lightAppLogo),
                      height: 100,
                      width: 100,
                      //networkImage:Image.file(controller.pickedImage!),
                    ),
                    Hor(CSSizes.sm),
                    Text(
                      controller.user.value.fullName ?? '',
                      style: dark
                          ? CSTextTheme.darkTextTheme.displayMedium
                          : CSTextTheme.lightTextTheme.displayMedium,
                    ),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      controller.user.value.adminId ?? '',
                      style: dark
                          ? CSTextTheme.darkTextTheme.titleLarge
                          : CSTextTheme.lightTextTheme.titleLarge,
                    ),
                  ],
                ),
                Ver(CSSizes.spaceBtwSections),
              ],
            ),
          ),
          //Body
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: CSSizes.sm, right: CSSizes.sm),
              child: Column(
                children: [
                  const CSDividerBold(),
                  StudProfileMenus(
                    title: "Manage Accounts",
                    titleStyle: dark
                        ? CSTextTheme.darkTextTheme.headlineMedium
                        : CSTextTheme.lightTextTheme.headlineMedium,
                    showActionWidget: false,
                    seeMoreWidget: false,
                    showChildWidget: true,
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.to(() => const ShowAdminIds());
                            },
                            child: CSSectionHeading(
                              title: "Admin IDs",
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
                                onPressed: () =>
                                    Get.to(() => const AdminDocuments(
                                          initialIndex: 0,
                                        )),
                              ),
                            )),
                        const CSDividerBold(),
                        GestureDetector(
                            onTap: () {
                              Get.to(() => const ShowAdminInfo());
                            },
                            child: CSSectionHeading(
                              title: "Admin Information",
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
                                onPressed: () =>
                                    Get.to(() => const AdminDocuments(
                                          initialIndex: 0,
                                        )),
                              ),
                            )),
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
                          title: "Resumes",
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
                            onPressed: () => Get.to(() => const AdminDocuments(
                                  initialIndex: 0,
                                )),
                          ),
                        ),
                        const CSDividerBold(),
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
                            onPressed: () => Get.to(() => const AdminDocuments(
                                  initialIndex: 1,
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
                            onPressed: () => Get.to(() => const AdminDocuments(
                                  initialIndex: 2,
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
                            onPressed: () => Get.to(() => const AdminDocuments(
                                  initialIndex: 3,
                                )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
