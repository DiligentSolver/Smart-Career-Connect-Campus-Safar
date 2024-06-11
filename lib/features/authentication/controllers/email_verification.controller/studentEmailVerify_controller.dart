import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../dashboard/student_dashboard/screen/widget/student_navigation_menu.dart';
import '../../screens/user_roles.dart';
import '../user controller/student_controller.dart';

class StudentEmailVerification extends GetxController {
  static StudentEmailVerification get instance => Get.find();


  @override
  void onInit() {
    sendEmailVerification();
    initializeData();
    super.onInit();
  }


  final controller = Get.put(StudentController());
  final userController = Get.put(UserRepository());
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  late Map<String,dynamic> _data;

  sendEmailVerification() async {
    if (_auth.currentUser != null) {
      await _auth.currentUser?.sendEmailVerification();
    }
  }

  Future<void> initializeData() async {
    // Assuming you have a 'users' collection in Firestore
    final DocumentSnapshot userSnapshot =
    await FirebaseFirestore.instance.collection('Temporary Data').doc(_auth.currentUser?.uid).get();

    if (userSnapshot.exists) {
      _data = userSnapshot.data() as Map<String, dynamic>;
    } else {
      _data = {};
    }
  }

  saveFromTemporaryData(Map<String,dynamic> valueToSave) async {
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


  Future<void> studentEmailVerified() async {
    if (await isEnrollmentExists(_data['Enrollment Number'])) {
      await _db.collection('Enrollments')
          .doc(_data['Enrollment Number'])
          .update({'isUsed': true, 'Uid': _auth.currentUser?.uid});
      userController.saveFromTemporaryData(_data,'Student').then((value) =>
          Get.offAll(() => const StudentNavigationMenu()));
    } else {
      FirebaseAuth.instance.currentUser!.delete();
      Get.offAll(() => const UserRoles());
    }
  }


  ///-- Checking Student Email Verification --///
  studentCheckEmailVerificationStatus() async {
    await _auth.currentUser!.reload();
    if (_auth.currentUser!.emailVerified) {
      studentEmailVerified();
    }
    else {
      Get.snackbar("Email not Verified", "First verify email",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: CSColors.redShade,
          colorText: CSColors.firstColor);
    }
  }


  /// -- Checking Student ID is existed or not --///
  Future<bool> checkEnrollmentExists(String enrollmentNumber) async {
    final firestore = FirebaseFirestore.instance;
    // Query the 'enrollments' collection for the given enrollment number
    final querySnapshot = await firestore
        .collection('Enrollments')
        .where('Enrollment Number', isEqualTo: enrollmentNumber)
        .where('isUsed', isEqualTo: false)
        .get();

    // Check if there is at least one document with the given enrollment number
    return querySnapshot.docs.isNotEmpty;
  }


  Future<bool> isEnrollmentExists(String randomEnrollment) async {
    bool isEnrollmentExists = await checkEnrollmentExists(randomEnrollment);
    if (isEnrollmentExists) {
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
    return isEnrollmentExists;
  }
}