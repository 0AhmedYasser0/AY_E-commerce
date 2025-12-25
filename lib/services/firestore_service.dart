import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== CART ====================

  CollectionReference _cartCollection(String userId) {
    return _firestore.collection('carts').doc(userId).collection('items');
  }

  Future<void> addToCart(String userId, Product product) async {
    final docRef = _cartCollection(userId).doc(product.id.toString());
    final doc = await docRef.get();

    if (doc.exists) {
      // Update quantity
      await docRef.update({'quantity': FieldValue.increment(1)});
    } else {
      // Add new item
      await docRef.set(CartItem(product: product).toJson());
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
    await _favoritesCollection(userId).doc(product.id.toString()).set({
      'productId': product.id,
      'title': product.title,
      'price': product.price,
      'image': product.image,
      'addedAt': FieldValue.serverTimestamp(),
    });
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
}
