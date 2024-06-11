import 'dart:async';
import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/repositories/authentication_repository.dart';
import 'features/authentication/controllers/signup_controller/admin.signup_controller.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';
import 'features/authentication/screens/user_roles.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

///-----Entry point of Flutter App
Future<void> main() async {
  /// GetX Local Storage
  await GetStorage.init();
  var deviceStorage = GetStorage();
  deviceStorage.writeIfNull('IsFirstTime', true);

  /// Widgets Binding
  if (!CSApp.isWeb) {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    /// Await Splash until either items load
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  /// --Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
          (value) => Get.put(AuthenticationRepository(FirebaseAuth.instance)));

  /// --Initialize Authentication
  CSDeviceUtils.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(CSApp(
    home: deviceStorage.read('IsFirstTime')
        ? const OnBoardingScreen()
        : const UserRoles(),
  ));
}
