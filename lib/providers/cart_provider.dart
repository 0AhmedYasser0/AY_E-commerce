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
  String? get userId => _userId;
  
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _items.fold(0, (sum, item) => sum + item.total);

  void setUserId(String? userId) {
    debugPrint('🔑 CartProvider.setUserId called with: $userId');
    _userId = userId;
    if (userId != null) {
      debugPrint('🔑 CartProvider: Starting to listen to cart for user: $userId');
      _listenToCart();
    } else {
      debugPrint('🔑 CartProvider: userId is null, clearing items');
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
    debugPrint('🛒 CartProvider.addToCart called for product: ${product.title}');
    debugPrint('🛒 Current userId: $_userId');
    
    if (_userId == null) {
      debugPrint('❌ CartProvider: userId is NULL! Cannot add to cart.');
      return;
    }
    
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('🛒 Calling FirestoreService.addToCart...');
      await _firestoreService.addToCart(_userId!, product);
      debugPrint('✅ Successfully added to cart in Firestore');
    } catch (e) {
      debugPrint('❌ Error adding to cart: $e');
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> incrementQuantity(int productId) async {
    if (_userId == null) return;

    try {
      final item = _items.firstWhere((i) => i.product.id == productId);
      await _firestoreService.updateCartQuantity(_userId!, productId, item.quantity + 1);
    } catch (e) {
      debugPrint('Error incrementing quantity: $e');
    }
  }

  Future<void> decrementQuantity(int productId) async {
    if (_userId == null) return;

    try {
      final item = _items.firstWhere((i) => i.product.id == productId);
      if (item.quantity > 1) {
        await _firestoreService.updateCartQuantity(_userId!, productId, item.quantity - 1);
      } else {
        await removeItem(productId);
      }
    } catch (e) {
      debugPrint('Error decrementing quantity: $e');
    }
  }

  Future<void> removeItem(int productId) async {
    if (_userId == null) return;

    try {
      await _firestoreService.removeFromCart(_userId!, productId);
    } catch (e) {
      debugPrint('Error removing item: $e');
    }
  }

  Future<void> removeFromCart(int productId) async {
    await removeItem(productId);
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    if (_userId == null) return;

    try {
      await _firestoreService.updateCartQuantity(_userId!, productId, quantity);
    } catch (e) {
      debugPrint('Error updating quantity: $e');
    }
  }

  Future<bool> checkout() async {
    if (_userId == null || _items.isEmpty) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.createOrder(_userId!, _items, subtotal);
      await _firestoreService.clearCart(_userId!);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error during checkout: $e');
      _isLoading = false;
      notifyListeners();
      return false;
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
