import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ShopProduct.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShopProductService {
  final String _apiUrl = 'https://localhost:7100/api/ShopProducts';
  final _storage = FlutterSecureStorage();

  // Fetch all ShopProducts
  Future<List<ShopProduct>> getShopProducts() async {
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
        return data.map((ShopProductJson) => ShopProduct.fromJson(ShopProductJson)).toList();
      } else {
        throw Exception('Failed to load ShopProducts');
      }
    } catch (e) {
      throw Exception('Error fetching ShopProducts: $e');
    }
  }

  // Fetch a single ShopProduct by ID
  Future<ShopProduct> getShopProductById(String ShopProductId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.get(
        Uri.parse('$_apiUrl/$ShopProductId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        return ShopProduct.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load ShopProduct');
      }
    } catch (e) {
      throw Exception('Error fetching ShopProduct: $e');
    }
  }

  // Create a new ShopProduct
  Future<ShopProduct> createShopProduct(ShopProduct shopProduct) async {
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
        body: jsonEncode(shopProduct.toJson()),
      );

      if (response.statusCode == 201) {
        return ShopProduct.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create ShopProduct');
      }
    } catch (e) {
      throw Exception('Error creating ShopProduct: $e');
    }
  }

  // Update an existing ShopProduct
  Future<ShopProduct> updateShopProduct(ShopProduct shopProduct) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.put(
        Uri.parse('$_apiUrl/${shopProduct.shopProductId}'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type': 'application/json',
        },
        body: jsonEncode(shopProduct.toJson()),
      );

      if (response.statusCode == 200) {
        return ShopProduct.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update ShopProduct');
      }
    } catch (e) {
      throw Exception('Error updating ShopProduct: $e');
    }
  }

  // Delete a ShopProduct by ID
  Future<void> deleteShopProduct(String ShopProductId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.delete(
        Uri.parse('$_apiUrl/$ShopProductId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete ShopProduct');
      }
    } catch (e) {
      throw Exception('Error deleting ShopProduct: $e');
    }
  }
}
