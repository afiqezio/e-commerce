class ProductDetail {
  final int id;
  final String name;
  final String description;
  final double price;
  final int shopId;

  ProductDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.shopId,
  });

  // Factory method to create Product from JSON
  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      shopId: json['shopId'],
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'shopId': shopId,
    };
  }
}
