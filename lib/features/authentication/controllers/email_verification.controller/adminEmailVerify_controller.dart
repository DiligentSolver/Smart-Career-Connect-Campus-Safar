import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../dashboard/admin_dashboard/screens/widget/admin_navigation_menu.dart';
import '../../../dashboard/student_dashboard/screen/widget/student_navigation_menu.dart';
import '../../models/admin_model.dart';
import '../../screens/user_roles.dart';
import '../signup_controller/admin.signup_controller.dart';
import '../signup_controller/student.signup_controller.dart';

class AdminEmailVerification extends GetxController {
  static AdminEmailVerification get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    initializeData();
    super.onInit();
  }

  final adController = Get.put(AdminSignupController());
  final userController = Get.put(UserRepository());
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  late Map<String, dynamic> _data;

  Future<void> initializeData() async {
    // Assuming you have a 'users' collection in Firestore
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Temporary Data')
        .doc(_auth.currentUser?.uid)
        .get();

    if (userSnapshot.exists) {
      _data = userSnapshot.data() as Map<String, dynamic>;
    } else {
      _data = {};
    }
  }

  saveFromTemporaryData(Map<String, dynamic> valueToSave) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(_auth.currentUser?.uid)
          .set(valueToSave);
    } on FirebaseAuthException catch (e) {
      throw CSFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CSFormatException();
    } on PlatformException catch (e) {
      throw CSPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  sendEmailVerification() async {
    if (_auth.currentUser != null) {
      await _auth.currentUser?.sendEmailVerification();
    }
  }

  Future<void> adminEmailVerified() async {
    if (await isAdminIdExists(_data['Admin Id'])) {
      await _db
          .collection('Ad_id')
          .doc(_data['Admin Id'])
          .update({'isUsed': true, 'Uid': _auth.currentUser?.uid});
      userController
          .saveFromTemporaryData(_data, 'Admin')
          .then((value) => Get.offAll(() => const AdminNavigationMenu()));
    } else {
      FirebaseAuth.instance.currentUser?.delete();
      Get.offAll(() => const UserRoles());
    }
  }

  ///-- Checking Admin Email Verification --///
  adminCheckEmailVerificationStatus() async {
    await _auth.currentUser!.reload();
    if (_auth.currentUser!.emailVerified) {
      adminEmailVerified();
    } else {
      Get.snackbar("Email not Verified", "First verify email",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: CSColors.redShade,
          colorText: CSColors.firstColor);
    }
  }

  /// -- Checking Admin ID is existed or not --///
  Future<bool> checkAdminIdExists(String adminId) async {
    final firestore = FirebaseFirestore.instance;
    // Query the 'enrollments' collection for the given enrollment number
    final querySnapshot = await firestore
        .collection('Ad_id')
        .where('Admin Id', isEqualTo: adminId)
        .where('isUsed', isEqualTo: false)
        .get();

    // Check if there is at least one document with the given enrollment number
    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> isAdminIdExists(String adminId) async {
    bool isAdminIdExists = await checkAdminIdExists(adminId);
    if (isAdminIdExists) {
      Get.snackbar("Successfully Registered", "Valid Person",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: CSColors.greenShade,
          colorText: CSColors.firstColor);
    } else {
      Get.snackbar("Error", "You are not Valid Person",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: CSColors.redShade,
          colorText: CSColors.firstColor);
    }
    return isAdminIdExists;
  }
}
