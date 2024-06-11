import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication_repository.dart';

class StudentLoginController extends GetxController{
  static StudentLoginController get instance=> Get.find();

  final stuLoginEmailController = TextEditingController();
  final stuLoginPasswordController = TextEditingController();

  Rx<bool> isLoading = false.obs;
  GlobalKey<FormState> studentLoginFormKey = GlobalKey<FormState>();
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    isLoading= false.obs;
  }

  void onDispose(){
    super.dispose();
    _timer?.cancel();
  }


  login(){
    if (!isLoading.value) {
      isLoading.value = true;
      if (studentLoginFormKey.currentState!.validate()) {
        AuthenticationRepository.instance
            .studentLogIn(stuLoginEmailController.text, stuLoginPasswordController.text);
        _timer = Timer(const Duration(seconds: 6), () {
          isLoading.value = false;
        });
          studentLoginFormKey.currentState?.reset();
      }
    }
  }
}