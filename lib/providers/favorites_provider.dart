import 'package:flutter/foundation.dart';
import '../models/polymer.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Polymer> _favorites = [];

  List<Polymer> get favorites => _favorites;

  void toggleFavorite(Polymer polymer) {
    final isExist = _favorites
        .any((element) => element.abbreviation == polymer.abbreviation);

    if (isExist) {
      _favorites.removeWhere(
          (element) => element.abbreviation == polymer.abbreviation);
      polymer.isFavorite = false;
    } else {
      _favorites.add(polymer);
      polymer.isFavorite = true;
    }
    notifyListeners();
  }

  bool isFavorite(Polymer polymer) {
    return _favorites
        .any((element) => element.abbreviation == polymer.abbreviation);
  }
}
