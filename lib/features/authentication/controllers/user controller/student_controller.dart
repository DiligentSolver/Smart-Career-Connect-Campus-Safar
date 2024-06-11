import 'dart:io';
import 'package:campus_safar/data/repositories/user_repository.dart';
import 'package:campus_safar/features/authentication/models/company_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/repositories/company_repository.dart';
import '../../models/student_model.dart';


class StudentController extends GetxController {
  static StudentController get instance => Get.find();

  Map<String, dynamic>? userInfo;
  final userRepo = Get.put(UserRepository());
  final companyRepo = Get.put(CompanyRepository());
  final Rx<StudentModel> user = StudentModel.empty().obs;
  final Rx<CompanyModel> company = CompanyModel.empty().obs;
  List<Map<String,dynamic>> companyList = [];
  File? pickedImage;

  @override
   onInit() {
    _fetchStudentRecord();
    super.onInit();
  }

  Future<void> _fetchStudentRecord() async {
    try {
      final user = await userRepo.fetchStudentDetails();
      this.user(user);
    } catch (e) {
      user(StudentModel.empty());
    }
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);

      pickedImage = tempImage;

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
