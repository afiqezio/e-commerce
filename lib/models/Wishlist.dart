class Wishlist {
  final String wishlistId;
  final String userId;
  final String productId;

  Wishlist({
    required this.wishlistId,
    required this.userId,
    required this.productId
  });

  // Factory method to create Product from JSON
  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      wishlistId: json['wishlistId'],
      userId: json['userId'],
      productId: json['productId']
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'wishlistId': wishlistId,
      'userId': userId,
      'productId': productId
    };
  }
}
