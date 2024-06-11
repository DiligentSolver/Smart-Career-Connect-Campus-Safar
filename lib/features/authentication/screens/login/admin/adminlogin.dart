import 'dart:ui';
import 'package:campus_safar/features/authentication/controllers/login_controller/admin.login_controller.dart';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../app.dart';
import '../../forms/adminloginform.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  static bool isLoading = false;

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  final controller = Get.put(AdminLoginController());


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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdminLoginForm(
                        formKey: controller.adminLoginFormKey,
                        emailController: controller
                            .adLoginEmailController,
                        passwordController: controller
                            .adLoginPasswordController,
                        onPressed: () {
                          controller.login();
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
