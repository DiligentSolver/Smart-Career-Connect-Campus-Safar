import 'dart:ui';
import 'package:campus_safar/features/authentication/controllers/login_controller/student.login_controller.dart';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app.dart';
import '../../forms/studentloginform.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  static bool isLoading = false;

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final controller = Get.put(StudentLoginController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StudentLoginForm(
                    formKey: controller.studentLoginFormKey,
                    emailController: controller.stuLoginEmailController,
                    passwordController: controller.stuLoginPasswordController,
                    onPressed: () {
                      controller.login();
                    },
                    isLoading: controller.isLoading.value,
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
