import 'package:get_storage/get_storage.dart';

class CSLocalStorage {

  var _storage = GetStorage();

  // Singleton instance
  static CSLocalStorage? _instance;

  CSLocalStorage._internal();

  factory CSLocalStorage.instance() {
    _instance ??= CSLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = CSLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  //Generic method to save data
  Future<void> saveData<CS>(String key, CS value) async {
    await _storage.write(key, value);
  }

  //Generic method to read data
  CS? readData<CS>(String key) {
    return _storage.read<CS>(key);
  }

  //Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  //Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
