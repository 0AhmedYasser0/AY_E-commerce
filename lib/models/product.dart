class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handle images array from Platzi API
    String imageUrl = '';
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      imageUrl = json['images'][0].toString();
      // Clean up the URL if it has extra characters
      imageUrl = imageUrl.replaceAll('[', '').replaceAll(']', '').replaceAll('"', '');
    }
    
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      image: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': image,
    };
  }
}
