import 'package:campus_safar/features/authentication/screens/user_roles.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  ///Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;


  /// Update Current Index when Page Scroll
  //void updatePageIndicator(index) => currentPageIndex.value = index;

  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  /// Jump to the specific dot selected page.
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  ///Update Current Index & jump to next page
  void nextPage() async {
    // if (currentPageIndex.value == 2) {
    //   Get.to(const StudentDashBoard());
    // } else {
    //   int page = currentPageIndex.value + 1;
    //   pageController.jumpToPage(page);
    // }
    final storage = GetStorage();
    storage.write('IsFirstTime', false);
    Get.offAll(() => const UserRoles());
  }

  /// Update Current Index & jump to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
