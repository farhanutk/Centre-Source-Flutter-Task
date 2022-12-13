import 'package:centre_source_flutter_task/services/database_services.dart';
import 'package:flutter/cupertino.dart';

class ImagesProvider extends ChangeNotifier {
  List images = [];
  int page = 0;
  bool isLoading = false;

  fetchImages(String searchQuery, {required bool isNewSearch}) async {
    isLoading = true;
    notifyListeners();

    if (isNewSearch) {
      images = [];
      page = 0;
      notifyListeners();
    }

    images.addAll(await getImages(searchQuery, ++page));

    isLoading = false;
    notifyListeners();
  }
}
