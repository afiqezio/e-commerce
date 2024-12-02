import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/OrderDetail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OrderDetailService {
  final String _apiUrl = 'https://localhost:7100/api/OrderDetails';
  final _storage = FlutterSecureStorage();

  // Fetch all OrderDetails
  Future<List<OrderDetail>> getOrderDetails() async {
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
        return data.map((OrderDetailJson) => OrderDetail.fromJson(OrderDetailJson)).toList();
      } else {
        throw Exception('Failed to load OrderDetails');
      }
    } catch (e) {
      throw Exception('Error fetching OrderDetails: $e');
    }
  }

  // Fetch a single OrderDetail by ID
  Future<OrderDetail> getOrderDetailById(String OrderDetailId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.get(
        Uri.parse('$_apiUrl/$OrderDetailId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        return OrderDetail.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load OrderDetail');
      }
    } catch (e) {
      throw Exception('Error fetching OrderDetail: $e');
    }
  }

  // Create a new OrderDetail
  Future<OrderDetail> createOrderDetail(OrderDetail orderDetail) async {
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
        body: jsonEncode(orderDetail.toJson()),
      );

      if (response.statusCode == 201) {
        return OrderDetail.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create OrderDetail');
      }
    } catch (e) {
      throw Exception('Error creating OrderDetail: $e');
    }
  }

  // Update an existing OrderDetail
  Future<OrderDetail> updateOrderDetail(OrderDetail orderDetail) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.put(
        Uri.parse('$_apiUrl/${orderDetail.orderDetailId}'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderDetail.toJson()),
      );

      if (response.statusCode == 200) {
        return OrderDetail.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update OrderDetail');
      }
    } catch (e) {
      throw Exception('Error updating OrderDetail: $e');
    }
  }

  // Delete a OrderDetail by ID
  Future<void> deleteOrderDetail(String OrderDetailId) async {
    try {
      // Retrieve the JWT token from secure storage
      String? token = await _storage.read(key: 'jwt_token');
      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final response = await http.delete(
        Uri.parse('$_apiUrl/$OrderDetailId'),
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete OrderDetail');
      }
    } catch (e) {
      throw Exception('Error deleting OrderDetail: $e');
    }
  }
}
