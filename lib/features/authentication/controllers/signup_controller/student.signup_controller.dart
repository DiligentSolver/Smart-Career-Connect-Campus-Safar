import 'dart:async';
import 'package:campus_safar/features/authentication/controllers/user%20controller/student_controller.dart';
import 'package:campus_safar/features/authentication/screens/forms/studentsignupform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../models/student_model.dart';

class StudentSignupController extends GetxController {
  static StudentSignupController get instance => Get.find();

  final stuNameController = TextEditingController();
  final stuEmailController = TextEditingController();
  final stuPasswordController = TextEditingController();
  final stuNumberController = TextEditingController();
  final enrollmentController = TextEditingController();
  final instituteController = TextEditingController();
  final courseController = TextEditingController();
  final branchController = TextEditingController();
  final passingYearController = TextEditingController();
  final stuLoginEmailController = TextEditingController();
  final stuLoginPasswordController = TextEditingController();
  final authController =
      Get.put(AuthenticationRepository(FirebaseAuth.instance));
  final userRepo = Get.put(UserRepository());
  final controller = Get.put(StudentController());
  Rx<bool> isLoading = false.obs;
  GlobalKey<FormState> studentSignupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> studentSignup2FormKey = GlobalKey<FormState>();
  Timer? _timer;

  void onDispose() {
    super.dispose();
    _timer?.cancel();
  }

  signup() {
    if (!isLoading.value) {
      if (studentSignup2FormKey.currentState!.validate()) {
        isLoading = true.obs;
        authController
            .registerStudentWithEmailAndPassword(
                stuEmailController.text, stuPasswordController.text)
            .then((value) async {
          final newUser = StudentModel(
            user: 'Student',
            id: FirebaseAuth.instance.currentUser?.uid,
            fullName: stuNameController.text,
            enrollmentNo: enrollmentController.text,
            email: stuEmailController.text,
            mobileNumber:
                '${StudentSignupForm.selectedCode}${stuNumberController.text}',
            instituteName: instituteController.text,
            course: courseController.text,
            branch: branchController.text,
            passingYear: passingYearController.text,
          );
          controller.user.value = newUser;
        }).then((value) async => await userRepo
                .saveTemporary(controller.user.value.studentToJson()));

        _timer = Timer(const Duration(seconds: 6), () {
          isLoading = false.obs;
        });

        studentSignup2FormKey.currentState?.reset();
      }
    }
  }
}
