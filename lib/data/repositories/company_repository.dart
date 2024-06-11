
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../features/authentication/models/company_model.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class CompanyRepository extends GetxController {
  static CompanyRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveCompanyDetails(
      CompanyModel companyModel, String companyName) async {
    await _db
        .collection('UpcomingCompanies')
        .doc(companyName)
        .set(companyModel.companyDetailsToJson());
  }

  Future<List<Map<String, dynamic>>> fetchCompanyDetails() async {
    try {
      final List<Map<String,dynamic>> detailsList = [];
      final documentSnapshot = await _db.collection('Upcoming Companies').get();
      for (var doc in documentSnapshot.docs) {
        detailsList.add(doc.data());
      }
      return detailsList;
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

  Future<CompanyModel?> fetchCompanyFields(int index) async {
    final List<Map<String,dynamic>> fieldsList = [];
    try {
      final documentSnapshot =
          await _db.collection('Upcoming Companies').get();
      for (var element in documentSnapshot.docs) {
        fieldsList.add(element.data());
      }
      if (documentSnapshot.docs.isNotEmpty) {
        return CompanyModel.fromSnapshot(fieldsList.elementAt(index));
      } else {
        return CompanyModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw CSFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CSFormatException();
    } on PlatformException catch (e) {
      throw CSPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<List<CompanyModel>> getFavouriteCompanies(
  //     List<String> companyIds) async {
  //   try {
  //     final documentSnapshot = await _db
  //         .collection('Upcoming Companies')
  //         .where(FieldPath.documentId, whereIn: companyIds)
  //         .get();
  //     return documentSnapshot.docs
  //         .map((e) => CompanyModel.fromSnapshot(e))
  //         .toList();
  //   } on FirebaseAuthException catch (e) {
  //     throw CSFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const CSFormatException();
  //   } on PlatformException catch (e) {
  //     throw CSPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }
}
