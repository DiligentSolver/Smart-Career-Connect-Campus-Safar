import 'dart:ui';
import 'package:campus_safar/features/authentication/controllers/signup_controller/admin.signup_controller.dart';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app.dart';
import '../../forms/adminsignupform.dart';

class AdminSignup extends StatefulWidget {
  const AdminSignup({super.key});

  @override
  State<AdminSignup> createState() => _NewLoginState();
}

class _NewLoginState extends State<AdminSignup> {

  final controller = Get.put(AdminSignupController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
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
                  children: [
                    AdminSignupForm(
                      formKey: controller.adminSignupFormKey,
                      nameController:
                          controller.adNameController,
                      passwordController:
                          controller.adPasswordController,
                      emailController:
                          controller.adEmailController,
                      numberController:
                          controller.adNumberController,
                      adminController:
                          controller.adminController,
                      onPressed: () {
                        controller.signup();
                      }, isLoading: controller.isLoading.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
