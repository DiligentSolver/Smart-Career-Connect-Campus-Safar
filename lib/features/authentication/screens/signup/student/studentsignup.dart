import 'dart:ui';
import 'package:campus_safar/features/authentication/screens/signup/student/studentsignup2.dart';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app.dart';
import '../../../controllers/signup_controller/student.signup_controller.dart';
import '../../forms/studentsignupform.dart';

class StudentSignup extends StatefulWidget {
  const StudentSignup({super.key});

  @override
  State<StudentSignup> createState() => _NewLoginState();
}

class _NewLoginState extends State<StudentSignup> {
  final controller = Get.put(StudentSignupController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CSApp.isWeb
                      ? const AssetImage(CSImages.credentialWebBg)
                      : const AssetImage(CSImages.credentialBg),
                  fit: BoxFit.cover)),
          width: size.width,
          height: size.height,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StudentSignupForm(
                      formKey: controller.studentSignupFormKey,
                      nameController:
                          controller.stuNameController,
                      passwordController: controller
                          .stuPasswordController,
                      emailController:
                          controller.stuEmailController,
                      numberController:
                          controller.stuNumberController,
                      enrollmentController:
                          controller.enrollmentController,
                      onPressed: () {
                        if (controller.studentSignupFormKey.currentState!.validate()) {
                          Get.to(() => const StudentSignup2());
                        }
                      }, isLoading: controller.isLoading.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
