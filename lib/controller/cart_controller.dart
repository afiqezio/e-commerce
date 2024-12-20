import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Cart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartService {
  final String _apiUrl = 'https://localhost:7100/api/Carts';
  final _storage = FlutterSecureStorage();

  // Fetch all Carts
  Future<List<Cart>> getCarts() async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.get(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((CartJson) => Cart.fromJson(CartJson)).toList();
      } else {
        throw Exception('Failed to load Carts');
      }
    } catch (e) {
      throw Exception('Error fetching Carts: $e');
    }
  }

  // Fetch a single Cart by ID
  Future<Cart> getCartById(String CartId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.get(
        Uri.parse('$_apiUrl/$CartId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load Cart');
      }
    } catch (e) {
      throw Exception('Error fetching Cart: $e');
    }
  }

  // Create a new Cart
  Future<Cart> createCart(Cart cart) async {
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
        body: jsonEncode(cart.toJson()),
      );

      if (response.statusCode == 201) {
        return Cart.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create Cart');
      }
    } catch (e) {
      throw Exception('Error creating Cart: $e');
    }
  }

  // Update an existing Cart
  Future<Cart> updateCart(Cart cart) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.put(
        Uri.parse('$_apiUrl/${cart.cartId}'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type': 'application/json',
        },
        body: jsonEncode(cart.toJson()),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update Cart');
      }
    } catch (e) {
      throw Exception('Error updating Cart: $e');
    }
  }

  // Delete a Cart by ID
  Future<void> deleteCart(String CartId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.delete(
        Uri.parse('$_apiUrl/$CartId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete Cart');
      }
    } catch (e) {
      throw Exception('Error deleting Cart: $e');
    }
  }
}
