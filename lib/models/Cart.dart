class Cart {
  final String cartId;
  final String userId;
  final String productId;
  final int quantity;

  Cart({
    required this.cartId,
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  // Factory method to create Product from JSON
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartId: json['cartId'],
      userId: json['userId'],
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
