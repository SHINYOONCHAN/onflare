import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<String> favorites = <String>[].obs;

  void toggleFavorite(String title) {
    if (favorites.contains(title)) {
      favorites.remove(title);
    } else {
      favorites.add(title);
    }
  }
}
