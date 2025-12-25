import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../services/firestore_service.dart';

class CartProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<CartItem> _items = [];
  bool _isLoading = false;
  String? _userId;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  bool get isEmpty => _items.isEmpty;
  
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _items.fold(0, (sum, item) => sum + item.total);

  void setUserId(String? userId) {
    _userId = userId;
    if (userId != null) {
      _listenToCart();
    } else {
      _items = [];
      notifyListeners();
    }
  }

  void _listenToCart() {
    if (_userId == null) return;
    
    _firestoreService.getCartItems(_userId!).listen((items) {
      _items = items;
      notifyListeners();
    });
  }

  Future<void> addToCart(Product product) async {
    if (_userId == null) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.addToCart(_userId!, product);
    } catch (e) {
      debugPrint('Error adding to cart: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> removeFromCart(int productId) async {
    if (_userId == null) return;

    try {
      await _firestoreService.removeFromCart(_userId!, productId);
    } catch (e) {
      debugPrint('Error removing from cart: $e');
    }
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    if (_userId == null) return;

    try {
      await _firestoreService.updateCartQuantity(_userId!, productId, quantity);
    } catch (e) {
      debugPrint('Error updating quantity: $e');
    }
  }

  Future<void> clearCart() async {
    if (_userId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.clearCart(_userId!);
    } catch (e) {
      debugPrint('Error clearing cart: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
