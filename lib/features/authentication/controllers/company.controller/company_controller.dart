import 'dart:io';
import 'package:campus_safar/data/repositories/company_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/company_model.dart';

class CompanyController extends GetxController {
  static CompanyController get instance => Get.find();
  final companyRepo = Get.put(CompanyRepository());
  final Rx<CompanyModel> company = CompanyModel.empty().obs;
  final isLoading = false.obs;
  final companyRepository = Get.put(CompanyRepository());
  List<Map<String,dynamic>> companyList = [];


  getCompanyList() async {
    var tempList = await companyRepo.fetchCompanyDetails();
    return tempList;
  }


  Future<void> fetchCompanyRecord(int index) async {
    try {
      final company = await companyRepo.fetchCompanyFields(index);
      this.company(company);
    } catch (e) {
      company(CompanyModel.empty());
    }
  }

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
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
