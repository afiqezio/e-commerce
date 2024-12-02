import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final String _apiUrl = 'https://localhost:7100/api/login/login'; // Update with your API URL

  Future<String?> login(String email, String password) async {
    final jsonS = json.encode({
      'email': email,
      'password': password,
    });
    final uri = Uri.parse(_apiUrl);

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
        final token = data['token'];
        final userId = data['userID'];

        // Save the token and userId securely
        await _secureStorage.write(key: 'jwt_token', value: token);
        await _secureStorage.write(key: 'userId', value: userId);

        return token; // Return the token for further use
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
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
