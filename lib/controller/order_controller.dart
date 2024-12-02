import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Order.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OrderService {
  final String _apiUrl = 'https://localhost:7100/api/Orders';
  final _storage = FlutterSecureStorage();

  // Fetch all Orders
  Future<List<Order>> getOrders() async {
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
        return data.map((OrderJson) => Order.fromJson(OrderJson)).toList();
      } else {
        throw Exception('Failed to load Orders');
      }
    } catch (e) {
      throw Exception('Error fetching Orders: $e');
    }
  }

  // Fetch a single Order by ID
  Future<Order> getOrderById(String OrderId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.get(
        Uri.parse('$_apiUrl/$OrderId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        return Order.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load Order');
      }
    } catch (e) {
      throw Exception('Error fetching Order: $e');
    }
  }

  // Create a new Order
  Future<Order> createOrder(Order order) async {
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
        body: jsonEncode(order.toJson()),
      );

      if (response.statusCode == 201) {
        return Order.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create Order');
      }
    } catch (e) {
      throw Exception('Error creating Order: $e');
    }
  }

  // Update an existing Order
  Future<Order> updateOrder(Order order) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.put(
        Uri.parse('$_apiUrl/${order.orderId}'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type': 'application/json',
        },
        body: jsonEncode(order.toJson()),
      );

      if (response.statusCode == 200) {
        return Order.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update Order');
      }
    } catch (e) {
      throw Exception('Error updating Order: $e');
    }
  }

  // Delete a Order by ID
  Future<void> deleteOrder(String OrderId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.delete(
        Uri.parse('$_apiUrl/$OrderId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete Order');
      }
    } catch (e) {
      throw Exception('Error deleting Order: $e');
    }
  }
}
