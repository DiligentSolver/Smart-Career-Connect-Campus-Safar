import 'package:campus_safar/features/dashboard/admin_dashboard/screens/recruiter_section.dart';
import 'package:campus_safar/features/dashboard/admin_dashboard/screens/student_section.dart';
import 'package:campus_safar/features/dashboard/admin_dashboard/screens/account_screen.dart';
import 'package:campus_safar/utils/constants/text_strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../chat_screen.dart';

class AdminNavigationMenu extends StatefulWidget {
  const AdminNavigationMenu({super.key});

  @override
  State<AdminNavigationMenu> createState() => _AdminNavigationMenuState();
}

class _AdminNavigationMenuState extends State<AdminNavigationMenu> {
  @override
  Widget build(BuildContext context) {
    final darkMode = CSHelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());
    return SafeArea(
      child: Scaffold(
          backgroundColor: darkMode ? CSColors.darkThemeBg : CSColors.lightBg,
          bottomNavigationBar: Obx(
            () => NavigationBar(
                height: 80,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (index) =>
                    controller.selectedIndex.value = index,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(
                        FontAwesomeIcons.userGraduate,
                      ),
                      label: 'Student'),
                  NavigationDestination(
                      icon: Icon(FontAwesomeIcons.personCircleCheck),
                      label: 'Recruiter'),
                  NavigationDestination(
                      icon: Icon(Iconsax.message), label: CSTexts.aNavItem3),
                  NavigationDestination(
                      icon: Icon(Iconsax.user), label: CSTexts.aNavItem4),
                ]),
          ),
          body: Obx(
            () => controller.screens[controller.selectedIndex.value],
          )),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const StudentSectionScreen(),
    const RecruiterSectionScreen(),
    const AdmChatScreen(title: CSTexts.aNavItem3),
    const AdmAccount(),
  ];
}
