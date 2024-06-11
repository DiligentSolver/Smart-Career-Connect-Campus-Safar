import 'dart:async';
import 'package:campus_safar/features/authentication/controllers/user%20controller/admin_controller.dart';
import 'package:campus_safar/features/authentication/screens/forms/adminsignupform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../models/admin_model.dart';

class AdminSignupController extends GetxController {
  static AdminSignupController get instance => Get.find();

  final adminController = TextEditingController();
  final adNameController = TextEditingController();
  final adPasswordController = TextEditingController();
  final adLoginPasswordController = TextEditingController();
  final adEmailController = TextEditingController();
  final adLoginEmailController = TextEditingController();
  final adNumberController = TextEditingController();
  final fileNameController = TextEditingController();
  Rx<bool> isLoading = false.obs;
  GlobalKey<FormState> adminSignupFormKey = GlobalKey<FormState>();
  final authController =
      Get.put(AuthenticationRepository(FirebaseAuth.instance));
  final userRepo = Get.put(UserRepository());
  final controller = Get.put(AdminController());
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    isLoading = false.obs;
  }

  void onDispose() {
    super.dispose();
    _timer?.cancel();
  }

  signup() {
    if (!isLoading.value) {
      if (adminSignupFormKey.currentState!.validate()) {
        isLoading = true.obs;
        authController
            .registerAdminWithEmailAndPassword(
                adEmailController.text, adPasswordController.text)
            .then((value) async {
          final newUser = AdminModel(
              user: 'Admin',
              id: authController.authUser!.uid,
              fullName: adNameController.text,
              adminId: adminController.text,
              email: adEmailController.text,
              mobileNumber:
                  '${AdminSignupForm.selectedCode}${adNumberController.text}',
              applied: [],
              shortlisted: [],
              placed: [],
              offered: []);
          controller.user.value = newUser;
        }).then((value) async => await userRepo
                .saveTemporary(controller.user.value.adminToJson()));

        _timer = Timer(const Duration(seconds: 6), () {
          isLoading = false.obs;
        });
        adminSignupFormKey.currentState?.reset();
      }
    }
  }
}
