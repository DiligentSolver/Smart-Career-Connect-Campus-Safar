import 'dart:ui';
import 'package:campus_safar/features/authentication/controllers/signup_controller/recruiter.signup_controller.dart';
import 'package:campus_safar/features/authentication/screens/signup/recruiter/recruitersignup2.dart';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app.dart';
import '../../forms/recruitersignupform.dart';

class RecruiterSignup extends StatefulWidget {
  const RecruiterSignup({super.key});

  @override
  State<RecruiterSignup> createState() => _NewLoginState();
}

class _NewLoginState extends State<RecruiterSignup> {
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
                    RecruiterSignupForm(
                      formKey: controller.recruiterSignupFormKey,
                      nameController: controller.recNameController,
                      passwordController: controller.recPasswordController,
                      emailController: controller.recEmailController,
                      numberController: controller.recNumberController,
                      recController: controller.recController,
                      onPressed: () {
                        if (controller.recruiterSignupFormKey.currentState!
                            .validate()) {
                          Get.to(() => const RecruiterSignup2());
                        }
                      },
                      isLoading: controller.isLoading.value,
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
