class User {
  final String? userID;
  final String fullName;
  final String email;
  final String password;
  final String? phone;
  final String? address;
  final String? imageUrl;
  final int? role;

  User({
    this.userID,
    required this.fullName,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    this.imageUrl,
    this.role,
  });

  // Factory method to create a User object from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      fullName: json['fullName'],
      email: json['email'],
      password: json['passwordHash'],
      phone: json['phone'],
      address: json['address'],
      imageUrl: json['imageUrl'],
      role: json['role']
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'fullName': fullName,
      'email': email,
      'passwordHash': password,
      'phone': phone,
      'address': address,
      'imageUrl': imageUrl,
      'role': 1
    };
  }
}
