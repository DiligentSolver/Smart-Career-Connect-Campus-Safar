import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/authentication_repository.dart';

class AdminLoginController extends GetxController {
  static AdminLoginController get instance => Get.find();

  final adLoginPasswordController = TextEditingController();
  final adLoginEmailController = TextEditingController();

  Rx<bool> isLoading = false.obs;
  GlobalKey<FormState> adminLoginFormKey = GlobalKey<FormState>();
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    isLoading = false.obs;
  }

  void onDispose(){
    super.dispose();
    _timer?.cancel();
  }

  login() {
    if (!isLoading.value) {
      if (adminLoginFormKey.currentState!.validate()) {
        isLoading = true.obs;
        AuthenticationRepository.instance
            .adminLogIn(adLoginEmailController.text, adLoginPasswordController.text);
        _timer = Timer(const Duration(seconds: 6), () {
          isLoading = false.obs;
        });
        adminLoginFormKey.currentState?.reset();
      }
    }
  }
}
