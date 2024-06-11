import 'dart:io';
import 'package:campus_safar/data/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../models/recruiter_model.dart';

class RecruiterController extends GetxController {
  static RecruiterController get instance => Get.find();

  Map<String, dynamic>? userInfo;
  String? resultPath;
  Rx<bool> selected = false.obs;
  final userRepo = Get.put(UserRepository());
  final Rx<RecruiterModel> user = RecruiterModel.empty().obs;
  File pickedImage = File(''), pickedFile = File('');
  Widget? image;

  @override
  void onInit() {
    fetchRecruiterRecord();
    super.onInit();
  }

  Future<void> fetchRecruiterRecord() async {
    try {
      final user = await userRepo.fetchRecruiterDetails();
      this.user(user);
    } catch (e) {
      user(RecruiterModel.empty());
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

  Future pickExcelFile(
    FileType fileType,
    String? allowedExtension,
  ) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: [allowedExtension!],
      );
      if (result != null) {
        resultPath = result.files.single.path;
        selected = true.obs;
      } else {
        selected = false.obs;
      }
    } catch (error) {
      debugPrint(error.toString());
      Loader.errorSnackBar(title: "Sorry");
    }
  }

  Future pickFile(
    FileType fileType,
    List<String>? allowedExtension,
  ) async {
    try {
      FilePickerResult? file = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: allowedExtension!);
      try {
        if (file != null) {
          final thumbnail = await FilePreview.getThumbnail(
            file.files.first.path!,
          );
          resultPath = file.files.single.path;
          selected = true.obs;
          image = thumbnail;
        } else {
          selected = false.obs;
        }
      } catch (e) {
        image = Image.asset("");
      }
    } catch (error) {
      debugPrint(error.toString());
      Loader.errorSnackBar(title: "Sorry");
    }
  }

  Future openFile({required String url, String? fileExtension}) async {
    final file = await downloadFile(url, fileExtension);
    if (file == null) return;

    OpenFilex.open(file.path);
  }

  /// Download file into private folder not visible to user
  Future<File?> downloadFile(String url, String? name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: const Duration(minutes: 0),
      ),
    );
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    return file;
  }
}
