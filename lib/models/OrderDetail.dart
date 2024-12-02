class OrderDetail {
  final String orderDetailId;
  final String orderId;
  final String productId;
  final int quantity;
  final double price;

  OrderDetail({
    required this.orderDetailId,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  // Factory method to create Product from JSON
  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      orderDetailId: json['orderDetailId'],
      orderId: json['orderId'],
      productId: json['productId'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderDetailId': orderDetailId,
      'orderId': orderId,
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}
