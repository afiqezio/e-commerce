class Product {
  final String productId;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final String categoryId;
  final String? category; // Add nullable category field

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.categoryId,
    this.category,
  });

  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productID'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String?,
      categoryId: json['categoryID'] as String,
      category: json['category'] as String?,
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
      'categoryID': categoryId,
      'category': category,
    };
  }
}
