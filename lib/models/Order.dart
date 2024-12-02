class Order {
  final int orderId;
  final DateTime orderDate;
  final double totalAmount;
  final String userId;

  Order({
    required this.orderId,
    required this.orderDate,
    required this.totalAmount,
    required this.userId,
  });

  // Factory method to create Product from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      orderDate: json['orderDate'],
      totalAmount: json['totalAmount'],
      userId: json['userId'],
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderDate': orderDate,
      'totalAmount': totalAmount,
      'userId': userId,
    };
  }
}
