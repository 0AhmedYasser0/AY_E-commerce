import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== CART ====================

  CollectionReference _cartCollection(String userId) {
    return _firestore.collection('carts').doc(userId).collection('items');
  }

  Future<void> addToCart(String userId, Product product) async {
    debugPrint('🔥 FirestoreService.addToCart - userId: $userId, productId: ${product.id}');
    final docRef = _cartCollection(userId).doc(product.id.toString());
    debugPrint('🔥 Cart path: carts/$userId/items/${product.id}');
    
    final doc = await docRef.get();
    debugPrint('🔥 Document exists: ${doc.exists}');

    if (doc.exists) {
      debugPrint('🔥 Updating quantity...');
      await docRef.update({'quantity': FieldValue.increment(1)});
      debugPrint('✅ Quantity updated');
    } else {
      debugPrint('🔥 Creating new cart item...');
      final cartItemData = CartItem(product: product).toJson();
      debugPrint('🔥 Cart item data: $cartItemData');
      await docRef.set(cartItemData);
      debugPrint('✅ New cart item created');
    }
  }

  Future<void> removeFromCart(String userId, int productId) async {
    await _cartCollection(userId).doc(productId.toString()).delete();
  }

  Future<void> updateCartQuantity(String userId, int productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(userId, productId);
    } else {
      await _cartCollection(userId).doc(productId.toString()).update({
        'quantity': quantity,
      });
    }
  }

  Stream<List<CartItem>> getCartItems(String userId) {
    return _cartCollection(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CartItem.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> clearCart(String userId) async {
    final batch = _firestore.batch();
    final items = await _cartCollection(userId).get();
    for (var doc in items.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  // ==================== FAVORITES ====================

  CollectionReference _favoritesCollection(String userId) {
    return _firestore.collection('favorites').doc(userId).collection('items');
  }

  Future<void> addToFavorites(String userId, Product product) async {
    debugPrint('🔥 FirestoreService.addToFavorites - userId: $userId, productId: ${product.id}');
    final docRef = _favoritesCollection(userId).doc(product.id.toString());
    debugPrint('🔥 Favorites path: favorites/$userId/items/${product.id}');
    
    final data = {
      'productId': product.id,
      'title': product.title,
      'price': product.price,
      'image': product.image,
      'addedAt': FieldValue.serverTimestamp(),
    };
    debugPrint('🔥 Favorites data: $data');
    
    await docRef.set(data);
    debugPrint('✅ Successfully added to favorites in Firestore');
  }

  Future<void> removeFromFavorites(String userId, int productId) async {
    await _favoritesCollection(userId).doc(productId.toString()).delete();
  }

  Stream<List<Product>> getFavorites(String userId) {
    return _favoritesCollection(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Product(
          id: data['productId'] ?? 0,
          title: data['title'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          description: '',
          image: data['image'] ?? '',
        );
      }).toList();
    });
  }

  Future<bool> isFavorite(String userId, int productId) async {
    final doc = await _favoritesCollection(userId).doc(productId.toString()).get();
    return doc.exists;
  }

  // ==================== ORDERS ====================

  Future<void> createOrder(String userId, List<CartItem> items, double total) async {
    final orderRef = _firestore.collection('users').doc(userId).collection('orders').doc();
    
    final orderItems = items.map((item) => {
      'productId': item.product.id,
      'title': item.product.title,
      'price': item.product.price,
      'image': item.product.image,
      'quantity': item.quantity,
      'total': item.total,
    }).toList();

    await orderRef.set({
      'orderId': orderRef.id,
      'items': orderItems,
      'subtotal': total,
      'status': 'completed',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
