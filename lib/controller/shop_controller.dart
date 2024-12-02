import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Shop.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShopService {
  final String _apiUrl = 'https://localhost:7100/api/Shops';
  final _storage = FlutterSecureStorage();

  // Fetch all Shops
  Future<List<Shop>> getShops() async {
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
        return data.map((ShopJson) => Shop.fromJson(ShopJson)).toList();
      } else {
        throw Exception('Failed to load Shops');
      }
    } catch (e) {
      throw Exception('Error fetching Shops: $e');
    }
  }

  // Fetch a single Shop by ID
  Future<Shop> getShopById(String ShopId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.get(
        Uri.parse('$_apiUrl/$ShopId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        return Shop.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load Shop');
      }
    } catch (e) {
      throw Exception('Error fetching Shop: $e');
    }
  }

  // Create a new Shop
  Future<Shop> createShop(Shop shop) async {
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
        body: jsonEncode(shop.toJson()),
      );

      if (response.statusCode == 201) {
        return Shop.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create Shop');
      }
    } catch (e) {
      throw Exception('Error creating Shop: $e');
    }
  }

  // Update an existing Shop
  Future<Shop> updateShop(Shop shop) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.put(
        Uri.parse('$_apiUrl/${shop.shopId}'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type': 'application/json',
        },
        body: jsonEncode(shop.toJson()),
      );

      if (response.statusCode == 200) {
        return Shop.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update Shop');
      }
    } catch (e) {
      throw Exception('Error updating Shop: $e');
    }
  }

  // Delete a Shop by ID
  Future<void> deleteShop(String ShopId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.delete(
        Uri.parse('$_apiUrl/$ShopId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete Shop');
      }
    } catch (e) {
      throw Exception('Error deleting Shop: $e');
    }
  }
}
