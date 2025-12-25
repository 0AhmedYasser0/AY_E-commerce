import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get total => product.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'productId': product.id,
      'title': product.title,
      'price': product.price,
      'image': product.image,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product(
        id: json['productId'] ?? 0,
        title: json['title'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        description: '',
        image: json['image'] ?? '',
      ),
      quantity: json['quantity'] ?? 1,
    );
  }
}
