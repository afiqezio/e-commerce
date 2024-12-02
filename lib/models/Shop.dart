class Shop {
  final int id;
  final String name;
  final String location; // You can use more precise types like LatLng if needed.
  final String contactNumber;

  Shop({
    required this.id,
    required this.name,
    required this.location,
    required this.contactNumber,
  });

  // Factory method to create Shop from JSON
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      contactNumber: json['contactNumber'],
    );
  }

  // Convert Shop to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'contactNumber': contactNumber,
    };
  }
}
