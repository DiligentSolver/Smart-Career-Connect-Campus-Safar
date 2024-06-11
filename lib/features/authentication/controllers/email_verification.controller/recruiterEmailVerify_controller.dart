import 'dart:async';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/widgets/recruiter_navigation_menu.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../dashboard/recruiter_dashboard/screens/recruiter_dashboard.dart';
import '../../screens/user_roles.dart';
import '../signup_controller/recruiter.signup_controller.dart';

class RecruiterEmailVerification extends GetxController {
  static RecruiterEmailVerification get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    initializeData();
    super.onInit();
  }

  final recController = Get.put(RecruiterSignupController());
  final userController = Get.put(UserRepository());
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  late Map<String, dynamic> _data;

  sendEmailVerification() async {
    if (_auth.currentUser != null) {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    }
  }

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

  Future<void> recruiterEmailVerified() async {
    if (await isRecIdExists(_data['Recruiter Id'])) {
      await _db
          .collection('Rec_id')
          .doc(_data['Recruiter Id'])
          .update({'isUsed': true, 'Uid': _auth.currentUser?.uid});
      userController
          .saveFromTemporaryData(_data, 'Recruiter')
          .then((value) => Get.offAll(() => const RecruiterNavigationMenu()));
    } else {
      FirebaseAuth.instance.currentUser?.delete();
      Get.offAll(() => const UserRoles());
    }
  }

  ///-- Checking Recruiter Email Verification --///
  recruiterCheckEmailVerificationStatus() async {
    await _auth.currentUser!.reload();
    if (_auth.currentUser!.emailVerified) {
      recruiterEmailVerified();
    } else {
      Get.snackbar("Email not Verified", "First verify email",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: CSColors.redShade,
          colorText: CSColors.firstColor);
    }
  }

  /// -- Checking Recruiter ID is existed or not --///
  Future<bool> checkRecIdExists(String recId) async {
    final firestore = FirebaseFirestore.instance;
    // Query the 'enrollments' collection for the given enrollment number
    final querySnapshot = await firestore
        .collection('Rec_id')
        .where('Recruiter Id', isEqualTo: recId)
        .where('isUsed', isEqualTo: false)
        .get();

    // Check if there is at least one document with the given enrollment number
    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> isRecIdExists(String recId) async {
    bool isRecIdExists = await checkRecIdExists(recId);
    if (isRecIdExists) {
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
    return isRecIdExists;
  }
}
