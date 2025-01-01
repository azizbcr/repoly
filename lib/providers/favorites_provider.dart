import 'package:flutter/foundation.dart';
import '../models/polymer.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Polymer> _favorites = [];

  List<Polymer> get favorites => _favorites;

  bool isFavorite(Polymer polymer) {
    return _favorites.any((p) => p.name == polymer.name);
  }

  void addFavorite(Polymer polymer) {
    if (!isFavorite(polymer)) {
      _favorites.add(polymer);
      notifyListeners();
    }
  }

  void removeFavorite(Polymer polymer) {
    _favorites.removeWhere((p) => p.name == polymer.name);
    notifyListeners();
  }
}
