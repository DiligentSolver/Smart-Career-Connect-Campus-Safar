import 'dart:ui';
import 'package:campus_safar/features/authentication/controllers/signup_controller/recruiter.signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../forms/recruitersignupform2.dart';

class RecruiterSignup2 extends StatefulWidget {
  static bool isLoading = false;

  const RecruiterSignup2({super.key});
  @override
  State<RecruiterSignup2> createState() => _NewLoginState();
}

class _NewLoginState extends State<RecruiterSignup2> {
  final controller = Get.put(RecruiterSignupController());

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
                    RecruiterSignupForm2(
                      formKey: controller.recruiterSignup2FormKey,
                      companyController: controller.companyController,
                      locationController: controller.locationController,
                      designationController: controller.designationController,
                      websiteController: controller.websiteController,
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        controller.signup();
                      },
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
