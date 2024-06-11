import 'dart:async';
import 'package:campus_safar/features/authentication/controllers/user%20controller/recruiter_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../models/recruiter_model.dart';
import '../../screens/forms/recruitersignupform.dart';

class RecruiterSignupController extends GetxController {
  static RecruiterSignupController get instance => Get.find();

  final recController = TextEditingController();
  final recNameController = TextEditingController();
  final recEmailController = TextEditingController();
  final recPasswordController = TextEditingController();
  final recIdController = TextEditingController();
  final recNumberController = TextEditingController();
  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final websiteController = TextEditingController();
  final locationController = TextEditingController();
  final recLoginEmailController = TextEditingController();
  final recLoginPasswordController = TextEditingController();
  final authController =
      Get.put(AuthenticationRepository(FirebaseAuth.instance));
  final userRepo = Get.put(UserRepository());
  final controller = Get.put(RecruiterController());
  Rx<bool> isLoading = false.obs;
  GlobalKey<FormState> recruiterSignupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> recruiterSignup2FormKey = GlobalKey<FormState>();
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
      if (recruiterSignup2FormKey.currentState!.validate()) {
        isLoading = true.obs;
        authController
            .registerRecruiterWithEmailAndPassword(
                recEmailController.text, recPasswordController.text)
            .then((value) async {
          final newUser = RecruiterModel(
              user: 'Recruiter',
              id: authController.authUser!.uid,
              fullName: recNameController.text,
              email: recEmailController.text,
              mobileNumber:
                  '${RecruiterSignupForm.selectedCode}${recNumberController.text}',
              recruiterId: recController.text,
              companyName: companyController.text,
              designation: designationController.text,
              location: locationController.text,
              website: websiteController.text, applied: [], shortlisted: [], placed: [], offered: []);
          controller.user.value = newUser;
        }).then((value) async => await userRepo
                .saveTemporary(controller.user.value.recruiterToJson()));
        _timer = Timer(const Duration(seconds: 6), () {
          isLoading = false.obs;
        });
        recruiterSignup2FormKey.currentState?.reset();
      }
    }
  }
}
