import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/recruiter_dashboard.dart';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/students_screen.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/chat_screen.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/constants/text_strings.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../rec_account.dart';

class RecruiterNavigationMenu extends StatelessWidget {
  const RecruiterNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: PersistentTabView(
        navBarStyle: NavBarStyle.style11,
        backgroundColor: darkMode ? CSColors.darkThemeBg : CSColors.lightBg,
        decoration: const NavBarDecoration(
            border: Border(top: BorderSide(color: CSColors.grey))),
        context,
        screens: const [
          RecDashboard(),
          StudentsPage(initialIndex: 0),
          ChatScreenPage(),
          RecAccount()
        ],
        itemAnimationProperties: const ItemAnimationProperties(
            curve: Curves.easeInOut, duration: Duration(milliseconds: 400)),
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: (CSTexts.sNavItem1),
            activeColorPrimary:
                darkMode ? CSColors.shadow : CSColors.secondColor,
            activeColorSecondary:
                darkMode ? CSColors.white : CSColors.firstColor,
            inactiveColorPrimary:
                darkMode ? CSColors.thirdColor : CSColors.firstColor,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(
              FontAwesomeIcons.userGraduate,
            ),
            title: "Students",
            activeColorPrimary:
                darkMode ? CSColors.shadow : CSColors.secondColor,
            activeColorSecondary:
                darkMode ? CSColors.white : CSColors.firstColor,
            inactiveColorPrimary:
                darkMode ? CSColors.thirdColor : CSColors.firstColor,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.chat_bubble),
            title: "Chat",
            activeColorPrimary:
                darkMode ? CSColors.shadow : CSColors.secondColor,
            activeColorSecondary:
                darkMode ? CSColors.white : CSColors.firstColor,
            inactiveColorPrimary:
                darkMode ? CSColors.thirdColor : CSColors.firstColor,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            title: (CSTexts.sNavItem4),
            activeColorPrimary:
                darkMode ? CSColors.shadow : CSColors.secondColor,
            activeColorSecondary:
                darkMode ? CSColors.white : CSColors.firstColor,
            inactiveColorPrimary:
                darkMode ? CSColors.thirdColor : CSColors.firstColor,
          ),
        ],
      )),
    );
  }
}
