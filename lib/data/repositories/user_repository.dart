import 'dart:io';
import 'package:campus_safar/data/repositories/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../features/authentication/models/admin_model.dart';
import '../../features/authentication/models/recruiter_model.dart';
import '../../features/authentication/models/student_model.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> saveTemporary(user) async {
    try {
      await _db
          .collection('Temporary Data')
          .doc(_auth.currentUser?.uid)
          .set(user);
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

  saveFromTemporaryData(
      Map<String, dynamic> valueToSave, String userRole) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection(userRole)
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

  Future<void> saveStudent(StudentModel user) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(_auth.currentUser?.uid)
          .set(user.studentToJson());
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

  Future<void> saveRecruiter(RecruiterModel user) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Recruiter')
          .doc(_auth.currentUser?.uid)
          .set(user.recruiterToJson());
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

  Future<void> saveAdmin(AdminModel user) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Admin')
          .doc(_auth.currentUser?.uid)
          .set(user.adminToJson());
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

  Future<StudentModel?> fetchStudentDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return StudentModel.fromSnapshot(documentSnapshot);
      } else {
        return StudentModel.empty();
      }
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

  Future<RecruiterModel?> fetchRecruiterDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Recruiter')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return RecruiterModel.fromSnapshot(documentSnapshot);
      } else {
        return RecruiterModel.empty();
      }
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

  Future<AdminModel?> fetchAdminDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Admin')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return AdminModel.fromSnapshot(documentSnapshot);
      } else {
        return AdminModel.empty();
      }
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

  Future<void> updateStudentDetails(StudentModel updateStudent) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(updateStudent.studentPersonalDetailsToJson());
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

  Future<void> updateStuAboutDetails(StudentModel updateStudent) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(updateStudent.studentAboutToJson());
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

  Future<void> updateStuEduDetails(StudentModel updateStudent) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(updateStudent.studentEduToJson());
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

  Future<void> updateStuSkillsDetails(StudentModel updateStudent) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(updateStudent.studentSkillsToJson());
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

  Future<void> updateStuProfileImg(StudentModel updateStudent) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(updateStudent.studentSkillsToJson());
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

  Future<void> updateStuProjDetails(StudentModel updateStudent) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(updateStudent.studentProjectToJson());
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

  Future<void> updateRecruiterDetails(RecruiterModel updateRecruiter) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Recruiter')
          .doc(updateRecruiter.id)
          .update(updateRecruiter.recruiterToJson());
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

  Future<void> updateAdminDetails(AdminModel updateAdmin) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Admin')
          .doc(updateAdmin.id)
          .update(updateAdmin.adminToJson());
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

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Admin')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
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

  Future<void> removeStudentRecord(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Student')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .delete();
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

  Future<void> removeRecruiterRecord(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Recruiter')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .delete();
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

  Future<void> removeAdminRecord(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc('UserRoles')
          .collection('Admin')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .delete();
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

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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
}
