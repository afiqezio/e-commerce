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
    required this.imageUrl,
  });

  // Factory method to create Shop from JSON
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shopId'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
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
