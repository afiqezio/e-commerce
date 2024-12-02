class Product {
  final String productId;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final String? categoryId;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    this.categoryId,
  });

  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productID'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String?,
      categoryId: json['categoryId'] as String
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'productID': productId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
    };
  }
}
