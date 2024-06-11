import 'package:campus_safar/features/authentication/models/admin_model.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/saved_companies_screen.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/constants/text_strings.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../account_screen.dart';
import '../home_screen.dart';
import '../learning_screen.dart';

class StudentNavigationMenu extends StatefulWidget {
  const StudentNavigationMenu({super.key});

  @override
  State<StudentNavigationMenu> createState() => _StudentNavigationMenuState();
}

class _StudentNavigationMenuState extends State<StudentNavigationMenu> {
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
            Home(),
            StudLearning(
              title: CSTexts.sNavItem2,
            ),
            StudSavedScreen(
              title: CSTexts.sNavItem3,
            ),
            StudProfile(title: CSTexts.sNavItem4)
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
              icon: const Icon(Icons.assignment),
              title: (CSTexts.sNavItem2),
              activeColorPrimary:
                  darkMode ? CSColors.shadow : CSColors.secondColor,
              activeColorSecondary:
                  darkMode ? CSColors.white : CSColors.firstColor,
              inactiveColorPrimary:
                  darkMode ? CSColors.thirdColor : CSColors.firstColor,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.bookmark_add),
              title: (CSTexts.sNavItem3),
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
        ),
      ),
    );
  }
}
