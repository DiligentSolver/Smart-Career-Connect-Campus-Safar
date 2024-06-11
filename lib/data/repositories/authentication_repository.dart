import 'dart:async';
import 'dart:io';
import 'package:campus_safar/features/authentication/screens/onboarding/onboarding.dart';
import 'package:campus_safar/features/dashboard/admin_dashboard/screens/widget/admin_navigation_menu.dart';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/widgets/recruiter_navigation_menu.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/student_navigation_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app.dart';
import '../../features/authentication/screens/user_roles.dart';
import '../../features/authentication/screens/verify_email/adminverifyemail.dart';
import '../../features/authentication/screens/verify_email/recruiterverifyemail.dart';
import '../../features/authentication/screens/verify_email/studentverifyemail.dart';
import '../../features/dashboard/recruiter_dashboard/screens/recruiter_dashboard.dart';
import '../../utils/helpers/loaders.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  AuthenticationRepository(this._auth);
  final FirebaseAuth _auth;
  final User? authUser = FirebaseAuth.instance.currentUser;
  final String? email = FirebaseAuth.instance.currentUser?.email;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final deviceStorage = GetStorage();
  String? _role;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    ever(firebaseUser, (callback) {
      firebaseUser.bindStream(_auth.authStateChanges());
      if (callback == null) {
        _auth.signOut();
      }
    });
    relaunchedApp();
    if (!CSApp.isWeb) {
      Timer(const Duration(seconds: 5), () {
        FlutterNativeSplash.remove();
      });
    }
  }

  relaunchedApp() async {
    try {
      if (_auth.currentUser != null && _auth.currentUser!.emailVerified) {
        _checkAdminModified();
        _checkRecruiterModified();
        _checkStudentModified();
      } else {
        _checkAdminTemporary();
        _checkRecruiterTemporary();
        _checkStudentTemporary();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Loader.warningSnackBar(
              title: "Sorry", message: "Invalid email address");
          break;
        case 'user-not-found':
          Loader.warningSnackBar(
              title: "Sorry", message: "No user found for that email");
          break;
        case 'wrong-password':
          Loader.warningSnackBar(
              title: "Sorry", message: "Wrong password provided for that user");
          break;
        case 'user-disabled':
          Loader.warningSnackBar(
              title: "Sorry", message: "The user account has been disabled");
          break;
        case 'too-many-requests':
          Loader.warningSnackBar(
              title: "Sorry",
              message: "Too many login attempts, Please try again later");
          break;
        case 'operation-not-allowed':
          Loader.warningSnackBar(
              title: "Sorry", message: "Email/password log-in is not enable");
          break;
        // Handle other FirebaseAuthException cases as needed
        default:
          Loader.errorSnackBar(
              title: "Oops!", message: "Erorr during log-in ${e.message}");
          break;
      }
    } on SocketException catch (e) {
      Loader.errorSnackBar(title: "Oh no!", message: e.toString());
    }
  }

  _checkStudent() async {
    try {
      if (_auth.currentUser != null) {
        final DocumentSnapshot value = await _fireStore
            .collection('Users')
            .doc('UserRoles')
            .collection('Student')
            .doc(_auth.currentUser?.uid)
            .get();
        // Assuming you have a 'role' field in your Firestore document
        _role = value.get('User');
        if (_role == 'Student') {
          if (_auth.currentUser!.emailVerified) {
            // if he user email is verified, navigate to the main navigation menu
            Get.offAll(() => const StudentNavigationMenu());
          } else {
            Get.offAll(() => const StudentVerifyEmail());
          }
        }
      }
      return _role;
    } catch (e) {
      if (!(_auth.currentUser!.emailVerified)) {
        _checkStudentTemporary();
        Loader.warningSnackBar(
            title: 'Please register first',
            message: 'User not completed full registration process');
      } else {
        _auth.signOut();
        Loader.errorSnackBar(title: 'Sorry', message: 'User not registered');
      }
    }
  }

  _checkRecruiter() async {
    try {
      if (_auth.currentUser != null) {
        final DocumentSnapshot value = await _fireStore
            .collection('Users')
            .doc('UserRoles')
            .collection('Recruiter')
            .doc(_auth.currentUser?.uid)
            .get();
        // Assuming you have a 'role' field in your Firestore document
        _role = value.get('User');
        if (_role == 'Recruiter') {
          _auth.currentUser!.emailVerified
              ? Get.offAll(() => const RecruiterNavigationMenu())
              : Get.offAll(() => const RecruiterVerifyEmail());
        }
      }
    } catch (e) {
      if (!(_auth.currentUser!.emailVerified)) {
        _auth.currentUser!.delete();
        Loader.warningSnackBar(
            title: 'Please register first',
            message: 'User not completed full registration process');
      } else {
        _auth.signOut();
        Loader.errorSnackBar(title: 'Sorry', message: 'User not registered');
      }
    }
  }

  _checkAdmin() async {
    try {
      if (_auth.currentUser != null) {
        final DocumentSnapshot value = await _fireStore
            .collection('Users')
            .doc('UserRoles')
            .collection('Admin')
            .doc(_auth.currentUser?.uid)
            .get();
        // Assuming you have a 'role' field in your Firestore document
        _role = value.get('User');
        if (_role == 'Admin') {
          _auth.currentUser!.emailVerified
              ? Get.offAll(() => const AdminNavigationMenu())
              : Get.offAll(() => const AdminVerifyEmail());
        }
      }
    } catch (e) {
      if (!(_auth.currentUser!.emailVerified)) {
        _auth.currentUser!.delete();
        Loader.warningSnackBar(
            title: 'Please register first',
            message: 'User have not completed full registration process');
      } else {
        _auth.signOut();
        Loader.errorSnackBar(title: 'Sorry', message: 'User not registered');
      }
    }
  }

  _checkAdminTemporary() async {
    if (_auth.currentUser != null) {
      final DocumentSnapshot value = await _fireStore
          .collection('Temporary Data')
          .doc(_auth.currentUser?.uid)
          .get();
      // Assuming you have a 'role' field in your Firestore document
      _role = value.get('User');
      if (_role == 'Admin') {
        _auth.currentUser!.emailVerified
            ? Get.offAll(() => const AdminNavigationMenu())
            : Get.offAll(() => const AdminVerifyEmail());
      }
    }
  }

  _checkRecruiterTemporary() async {
    if (_auth.currentUser != null) {
      final DocumentSnapshot value = await _fireStore
          .collection('Temporary Data')
          .doc(_auth.currentUser?.uid)
          .get();
      // Assuming you have a 'role' field in your Firestore document
      _role = value.get('User');
      if (_role == 'Recruiter') {
        _auth.currentUser!.emailVerified
            ? Get.offAll(() => const RecruiterNavigationMenu())
            : Get.offAll(() => const RecruiterVerifyEmail());
      }
    }
  }

  _checkStudentTemporary() async {
    if (_auth.currentUser != null) {
      final DocumentSnapshot value = await _fireStore
          .collection('Temporary Data')
          .doc(_auth.currentUser?.uid)
          .get();
      // Assuming you have a 'role' field in your Firestore document
      _role = value.get('User');
      if (_role == 'Student') {
        _auth.currentUser!.emailVerified
            ? Get.offAll(() => const StudentNavigationMenu())
            : Get.offAll(() => const StudentVerifyEmail());
      }
    }
  }

  _checkAdminModified() async {
    if (_auth.currentUser != null) {
      final DocumentSnapshot value = await _fireStore
          .collection('Users')
          .doc('UserRoles')
          .collection('Admin')
          .doc(_auth.currentUser?.uid)
          .get();
      // Assuming you have a 'role' field in your Firestore document
      _role = value.get('User');
      if (_role == 'Admin') {
        _auth.currentUser!.emailVerified
            ? Get.offAll(() => const AdminNavigationMenu())
            : Get.offAll(() => const AdminVerifyEmail());
      }
    } else {
      CSApp.isWeb || !deviceStorage.read('IsFirstTime')
          ? Get.offAll(const UserRoles())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  _checkRecruiterModified() async {
    if (_auth.currentUser != null) {
      final DocumentSnapshot value = await _fireStore
          .collection('Users')
          .doc('UserRoles')
          .collection('Recruiter')
          .doc(_auth.currentUser?.uid)
          .get();
      // Assuming you have a 'role' field in your Firestore document
      _role = value.get('User');
      if (_role == 'Recruiter') {
        _auth.currentUser!.emailVerified
            ? Get.offAll(() => const RecruiterNavigationMenu())
            : Get.offAll(() => const RecruiterVerifyEmail());
      }
    } else {
      CSApp.isWeb || !deviceStorage.read('IsFirstTime')
          ? Get.offAll(const UserRoles())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  _checkStudentModified() async {
    if (_auth.currentUser != null) {
      final DocumentSnapshot value = await _fireStore
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(_auth.currentUser?.uid)
          .get();
      // Assuming you have a 'role' field in your Firestore document
      _role = value.get('User');
      if (_role == 'Student') {
        _auth.currentUser!.emailVerified
            ? Get.offAll(() => const StudentNavigationMenu())
            : Get.offAll(() => const StudentVerifyEmail());
      }
    } else {
      CSApp.isWeb || !deviceStorage.read('IsFirstTime')
          ? Get.offAll(const UserRoles())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  _studentScreenRedirect() async {
    if (_auth.currentUser != null) {
      if (_auth.currentUser!.emailVerified) {
        Get.offAll(() => const StudentNavigationMenu());
      } else {
        Get.offAll(() => const StudentVerifyEmail());
      }
    }
  }

  _recruiterScreenRedirect() async {
    if (_auth.currentUser != null) {
      if (_auth.currentUser!.emailVerified) {
        Get.offAll(() => const RecruiterNavigationMenu());
      } else {
        Get.offAll(() => const RecruiterVerifyEmail());
      }
    }
  }

  _adminScreenRedirect() async {
    if (_auth.currentUser != null) {
      if (_auth.currentUser!.emailVerified) {
        Get.offAll(() => const AdminNavigationMenu());
      } else {
        Get.offAll(() => const AdminVerifyEmail());
      }
    }
  }

  Future<void> registerStudentWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _studentScreenRedirect();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Loader.warningSnackBar(
              title: "Sorry", message: "Invalid email address");
          break;
        case 'email-already-in-use':
          Loader.warningSnackBar(
              title: "Sorry", message: "Email is already in use");
          break;
        case 'weak-password':
          Loader.warningSnackBar(
              title: "Sorry", message: "Password is too weak");
          break;
        // Handle other FirebaseAuthException cases as needed
        default:
          Loader.errorSnackBar(
              title: "Oops!", message: "Sign-up failed: ${e.message}");
          break;
      }
    }
  }

  Future<void> registerRecruiterWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => _recruiterScreenRedirect());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Loader.warningSnackBar(
              title: "Sorry", message: "Invalid email address");
          break;
        case 'email-already-in-use':
          Loader.warningSnackBar(
              title: "Sorry", message: "Email is already in use");
          break;
        case 'weak-password':
          Loader.warningSnackBar(
              title: "Sorry", message: "Password is too weak");
          break;
        // Handle other FirebaseAuthException cases as needed
        default:
          Loader.errorSnackBar(
              title: "Oops!", message: "Sign-up failed: ${e.message}");
          break;
      }
    } catch (e) {
      Loader.warningSnackBar(
          title: "Oops!", message: "Unexpected error during sign-up: $e");
    }
  }

  Future<void> registerAdminWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _adminScreenRedirect();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Loader.warningSnackBar(
              title: "Sorry", message: "Invalid email address");
          break;
        case 'email-already-in-use':
          Loader.warningSnackBar(
              title: "Sorry", message: "Email is already in use");
          break;
        case 'weak-password':
          Loader.warningSnackBar(
              title: "Sorry", message: "Password is too weak");
          break;
        // Handle other FirebaseAuthException cases as needed
        default:
          Loader.errorSnackBar(
              title: "Oops!", message: "Sign-up failed: ${e.message}");
          break;
      }
    } catch (e) {
      Loader.warningSnackBar(
          title: "Oops!", message: "Unexpected error during sign-up: $e");
    }
  }

  Future<void> sendPasswordLink(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Loader.successSnackBar(
          title: "Success",
          message: "Password reset link sent on registered email");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Loader.warningSnackBar(
              title: "Sorry", message: "Invalid email address");
          break;
        case 'user-not-found':
          Loader.warningSnackBar(
              title: "Sorry", message: "No user found for that mail");
          break;
        default:
          Loader.errorSnackBar(
              title: "Oops!",
              message: "Error sending password reset email: ${e.message}");
          break;
      }
    } catch (e) {
      Loader.errorSnackBar(
          title: "Oops!",
          message: "Unexpected error sending password reset email: $e");
    }
  }

  Future<void> studentLogIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => _checkStudent());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Loader.warningSnackBar(
              title: "Sorry", message: "Invalid email address");
          break;
        case 'user-not-found':
          Loader.warningSnackBar(
              title: "Sorry", message: "No user found for that email");
          break;
        case 'wrong-password':
          Loader.warningSnackBar(
              title: "Sorry", message: "Wrong password provided for that user");
          break;
        case 'user-disabled':
          Loader.warningSnackBar(
              title: "Sorry", message: "The user account has been disabled");
          break;
        case 'too-many-requests':
          Loader.warningSnackBar(
              title: "Sorry",
              message: "Too many login attempts, Please try again later");
          break;
        case 'operation-not-allowed':
          Loader.warningSnackBar(
              title: "Sorry", message: "Email/password log-in is not enable");
          break;
        // Handle other FirebaseAuthException cases as needed
        default:
          Loader.errorSnackBar(
              title: "Oops!", message: "Erorr during log-in ${e.message}");
          break;
      }
    } on SocketException catch (e) {
      Loader.errorSnackBar(title: "Oh no!", message: e.toString());
    }
  }

  Future<void> recruiterLogIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => _checkRecruiter());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Loader.warningSnackBar(
              title: "Sorry", message: "Invalid email address");
          break;
        case 'user-not-found':
          Loader.warningSnackBar(
              title: "Sorry", message: "No user found for that email");
          break;
        case 'wrong-password':
          Loader.warningSnackBar(
              title: "Sorry", message: "Wrong password provided for that user");
          break;
        case 'user-disabled':
          Loader.warningSnackBar(
              title: "Sorry", message: "The user account has been disabled");
          break;
        case 'too-many-requests':
          Loader.warningSnackBar(
              title: "Sorry",
              message: "Too many login attempts, Please try again later");
          break;
        case 'operation-not-allowed':
          Loader.warningSnackBar(
              title: "Sorry", message: "Email/password log-in is not enable");
          break;
        // Handle other FirebaseAuthException cases as needed
        default:
          Loader.errorSnackBar(
              title: "Oops!", message: "Erorr during log-in ${e.message}");
          break;
      }
    } on SocketException catch (e) {
      Loader.errorSnackBar(title: "Oh no!", message: e.toString());
    }
  }

  Future<void> adminLogIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => _checkAdmin());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Loader.warningSnackBar(
              title: "Sorry", message: "Invalid email address");
          break;
        case 'user-not-found':
          Loader.warningSnackBar(
              title: "Sorry", message: "No user found for that email");
          break;
        case 'wrong-password':
          Loader.warningSnackBar(
              title: "Sorry", message: "Wrong password provided for that user");
          break;
        case 'user-disabled':
          Loader.warningSnackBar(
              title: "Sorry", message: "The user account has been disabled");
          break;
        case 'too-many-requests':
          Loader.warningSnackBar(
              title: "Sorry",
              message: "Too many login attempts, Please try again later");
          break;
        case 'operation-not-allowed':
          Loader.warningSnackBar(
              title: "Sorry", message: "Email/password log-in is not enable");
          break;
        // Handle other FirebaseAuthException cases as needed
        default:
          Loader.errorSnackBar(
              title: "Oops!", message: "Erorr during log-in ${e.message}");
        //break;
      }
    } on SocketException catch (e) {
      Loader.errorSnackBar(title: "Oh no!", message: e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const UserRoles());
    } catch (e) {
      Loader.errorSnackBar(
          title: "Oops!", message: "Error during sign out: $e");
    }
  }
}
