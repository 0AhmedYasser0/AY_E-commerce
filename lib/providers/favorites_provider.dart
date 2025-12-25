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
    debugPrint('🔑 FavoritesProvider.setUserId called with: $userId');
    _userId = userId;
    if (userId != null) {
      debugPrint('🔑 FavoritesProvider: Starting to listen to favorites for user: $userId');
      _listenToFavorites();
    } else {
      debugPrint('🔑 FavoritesProvider: userId is null, clearing favorites');
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
    debugPrint('❤️ FavoritesProvider.toggleFavorite called for product: ${product.title}');
    debugPrint('❤️ Current userId: $_userId');
    
    if (_userId == null) {
      debugPrint('❌ FavoritesProvider: userId is NULL! Cannot toggle favorite.');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final wasFavorite = isFavorite(product.id);
      debugPrint('❤️ Product is currently favorite: $wasFavorite');
      
      if (wasFavorite) {
        debugPrint('❤️ Removing from favorites...');
        await _firestoreService.removeFromFavorites(_userId!, product.id);
        debugPrint('✅ Successfully removed from favorites');
      } else {
        debugPrint('❤️ Adding to favorites...');
        await _firestoreService.addToFavorites(_userId!, product);
        debugPrint('✅ Successfully added to favorites');
      }
    } catch (e) {
      debugPrint('❌ Error toggling favorite: $e');
      rethrow;
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
