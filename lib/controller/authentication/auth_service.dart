import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/User.dart';

class AuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _apiUrl = 'https://localhost:7100/api'; // Update with your API URL

  Future<bool?> login(String email, String password) async {
    final jsonS = json.encode({
      'email': email,
      'password': password,
    });
    final uri = Uri.parse('$_apiUrl/login/login');

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonS,
      );

      if (response.statusCode == 200) {
        // Extract the token from the response
        final data = jsonDecode(response.body);

        // Save the token and userId securely
        await _secureStorage.write(key: 'jwt_token', value: data['token']);
        await _secureStorage.write(key: 'userId', value: data['userID']);

        return true;
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  Future<int> register(User user) async {
    final regUser = json.encode({
      'email': user.email,
      'password': user.password,
      'fullName': user.fullName,
      'phone': user.phone,
    });

    final uri = Uri.parse('$_apiUrl/register');

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: regUser,
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception('Cannot Register');
      }
    } catch (e) {
      throw Exception('Error registering: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: 'jwt_token');
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'jwt_token');
  }
}
