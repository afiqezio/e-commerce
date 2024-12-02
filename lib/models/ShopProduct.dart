class ShopProduct {
  final String shopProductId;
  final String shopId;
  final String productId;
  final int quantity;

  ShopProduct({
    required this.shopProductId,
    required this.shopId,
    required this.productId,
    required this.quantity,
  });

  // Factory method to create Product from JSON
  factory ShopProduct.fromJson(Map<String, dynamic> json) {
    return ShopProduct(
      shopProductId: json['shopproductId'],
      shopId: json['shopId'],
      productId: json['productId'],
      quantity: json['quantity']
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'shopproductId': shopProductId,
      'shopId': shopId,
      'productId': productId,
      'quantity': quantity
    };
  }
}
