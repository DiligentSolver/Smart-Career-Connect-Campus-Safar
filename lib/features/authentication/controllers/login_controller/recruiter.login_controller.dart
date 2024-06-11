import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/authentication_repository.dart';

class RecruiterLoginController extends GetxController {
  static RecruiterLoginController get instance => Get.find();

  final recLoginEmailController = TextEditingController();
  final recLoginPasswordController = TextEditingController();

  Rx<bool> isLoading = false.obs;
  GlobalKey<FormState> recruiterLoginFormKey = GlobalKey<FormState>();
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    isLoading = false.obs;
  }

  void onDispose() {
    super.dispose();
    _timer?.cancel();
  }

  login() {
    if (!isLoading.value) {
      if (recruiterLoginFormKey.currentState!.validate()) {
        isLoading = true.obs;
        AuthenticationRepository.instance.recruiterLogIn(
            recLoginEmailController.text, recLoginPasswordController.text);
        _timer = Timer(const Duration(seconds: 6), () {
          isLoading = false.obs;
        });
        recruiterLoginFormKey.currentState?.reset();
      }
    }
  }
}
