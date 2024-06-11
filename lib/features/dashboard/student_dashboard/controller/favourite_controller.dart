import 'dart:convert';
import 'package:get/get.dart';
import '../../../../data/repositories/company_repository.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/local_storage/local_storage.dart';
import '../../../authentication/models/company_model.dart';

class FavouritesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  static FavouritesController get instances => Get.find();

  /// variables
  final favorites = <String, bool>{}.obs;

// Method to initialise favorites by reading free storage

  void initFavorites() {
    final json = CSLocalStorage.instance().readData('favorites');

    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String companyName) {
    return favorites[companyName] ?? false;
  }

  void toggleFavoriteProduct(String companyName) {
    if (favorites.containsKey(companyName)) {
      favorites[companyName] = true;
      saveFavouritesToStorage();
      Loader.successSnackBar(title: "Saved");
    } else {
      CSLocalStorage.instance().removeData(companyName);
      favorites.remove(companyName);
      saveFavouritesToStorage();
      favorites.refresh();
      Loader.customToast(
          message: 'Company has been received from the saved list.');
    }
  }

  void saveFavouritesToStorage() {
    final encodeFavorites = json.encode(favorites);
    CSLocalStorage.instance().saveData('favourites', encodeFavorites);
  }

  // Future<List<CompanyModel>> favouriteCompanies() async {
  //   return await CompanyRepository.instance
  //       .getFavouriteCompanies(favorites.keys.toList());
  // }
}
