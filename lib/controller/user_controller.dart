import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final String _apiUrl = 'https://localhost:7100/api/Users';
  final _storage = FlutterSecureStorage();

  // Fetch all Users
  Future<List<User>> getUsers() async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.get(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((UserJson) => User.fromJson(UserJson)).toList();
      } else {
        throw Exception('Failed to load Users');
      }
    } catch (e) {
      throw Exception('Error fetching Users: $e');
    }
  }

  // Fetch a single User by ID
  Future<User> getUserById(String UserId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.get(
        Uri.parse('$_apiUrl/$UserId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load User');
      }
    } catch (e) {
      throw Exception('Error fetching User: $e');
    }
  }

  // Create a new User
  Future<User> createUser(User user) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create User');
      }
    } catch (e) {
      throw Exception('Error creating User: $e');
    }
  }

  // Update an existing User
  Future<User> updateUser(User user) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.put(
        Uri.parse('$_apiUrl/${user.userID}'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update User');
      }
    } catch (e) {
      throw Exception('Error updating User: $e');
    }
  }

  // Delete a User by ID
  Future<void> deleteUser(String UserId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.delete(
        Uri.parse('$_apiUrl/$UserId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete User');
      }
    } catch (e) {
      throw Exception('Error deleting User: $e');
    }
  }
}
