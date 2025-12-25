import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/firestore_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Product> _favorites = [];
  bool _isLoading = false;
  String? _userId;

  List<Product> get favorites => _favorites;
  bool get isLoading => _isLoading;
  bool get isEmpty => _favorites.isEmpty;

  void setUserId(String? userId) {
    _userId = userId;
    if (userId != null) {
      _listenToFavorites();
    } else {
      _favorites = [];
      notifyListeners();
    }
  }

  void _listenToFavorites() {
    if (_userId == null) return;
    
    _firestoreService.getFavorites(_userId!).listen((favorites) {
      _favorites = favorites;
      notifyListeners();
    });
  }

  bool isFavorite(int productId) {
    return _favorites.any((p) => p.id == productId);
  }

  Future<void> toggleFavorite(Product product) async {
    if (_userId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      if (isFavorite(product.id)) {
        await _firestoreService.removeFromFavorites(_userId!, product.id);
      } else {
        await _firestoreService.addToFavorites(_userId!, product);
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> removeFromFavorites(int productId) async {
    if (_userId == null) return;

    try {
      await _firestoreService.removeFromFavorites(_userId!, productId);
    } catch (e) {
      debugPrint('Error removing from favorites: $e');
    }
  }
}
