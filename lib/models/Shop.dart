class Shop {
  final String shopId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? imageUrl;

  Shop({
    required this.shopId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
  });

  // Factory method to create Shop from JSON with null safety
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shopId'] ?? '',
      name: json['name'] ?? 'Unnamed Shop',
      address: json['address'] ?? 'No Address',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      imageUrl: json['imageUrl'],
    );
  }

  // Convert Shop to JSON
  Map<String, dynamic> toJson() {
    return {
      'shopId': shopId,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
    };
  }
}
