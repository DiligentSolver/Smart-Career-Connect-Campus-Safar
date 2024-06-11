import 'dart:ui';
import 'package:campus_safar/features/authentication/controllers/login_controller/recruiter.login_controller.dart';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app.dart';
import '../../forms/recruiterloginform.dart';

class RecruiterLogin extends StatefulWidget {
  const RecruiterLogin({super.key});

  @override
  State<RecruiterLogin> createState() => _RecruiterLoginState();
}

class _RecruiterLoginState extends State<RecruiterLogin> {
  final controller = Get.put(RecruiterLoginController());

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
                  RecruiterLoginForm(
                    formKey: controller.recruiterLoginFormKey,
                    emailController: controller.recLoginEmailController,
                    passwordController: controller.recLoginPasswordController,
                    onPressed: () {
                      controller.login();
                    },
                    isLoading: controller.isLoading.value,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
