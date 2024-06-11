import 'package:campus_safar/data/repositories/user_repository.dart';
import 'package:get/get.dart';
import '../../models/admin_model.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  Map<String, dynamic>? userInfo;
  final userRepo = Get.put(UserRepository());
  final Rx<AdminModel> user = AdminModel.empty().obs;

  @override
  void onInit() {
    fetchAdminRecord();
    super.onInit();
  }

  Future<void> fetchAdminRecord() async {
    try {
      final user = await userRepo.fetchAdminDetails();
      this.user(user);
    } catch (e) {
      user(AdminModel.empty());
    }
  }
}
