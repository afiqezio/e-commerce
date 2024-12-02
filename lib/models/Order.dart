class Order {
  final String orderId;
  final DateTime createdDate;
  final double totalAmount;
  final String userId;

  Order({
    required this.orderId,
    required this.createdDate,
    required this.totalAmount,
    required this.userId,
  });

  // Factory method to create Product from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      createdDate: json['orderDate'],
      totalAmount: json['totalAmount'],
      userId: json['userId'],
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderDate': createdDate,
      'totalAmount': totalAmount,
      'userId': userId,
    };
  }
}
