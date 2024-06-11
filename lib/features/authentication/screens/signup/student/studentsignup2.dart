import 'dart:async';
import 'dart:ui';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app.dart';
import '../../../controllers/signup_controller/student.signup_controller.dart';
import '../../forms/studentsignupform2.dart';

class StudentSignup2 extends StatefulWidget {
  const StudentSignup2({super.key});
  @override
  State<StudentSignup2> createState() => _StudentSignup2State();
}

class _StudentSignup2State extends State<StudentSignup2> {

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
                    StudentSignupForm2(
                      formKey: controller.studentSignup2FormKey,
                      onPressed: () {
                        controller.signup();
                      },
                      instituteController:
                          controller.instituteController,
                      courseController:
                          controller.courseController,
                      branchController:
                          controller.branchController,
                      passingyearController:
                          controller.passingYearController, isLoading: controller.isLoading.value,
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
