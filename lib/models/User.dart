class User {
  final String userID;
  final String fullName;
  final String email;
  final String? phone;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.userID,
    required this.fullName,
    required this.email,
    this.phone,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a User object from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
