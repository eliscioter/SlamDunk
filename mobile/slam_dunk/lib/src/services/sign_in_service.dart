import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInService {
  final Dio _client = Dio();
  static const String _baseUrl = 'https://slamdunkusers.onrender.com/api/user';
  final options = Options(headers: {
    'Content-Type': 'application/json',
  });
  Future auth(String username, String password) async {
    print('$username, $password auth service');

    try {
      final response = await _client.post('$_baseUrl/login', data: {
        'username': username,
        'password': password,
      });
      print(response.statusCode);
      if (response.statusCode != 200) {
        return null;
      }
      print(response.data);
      return response.data;
    } catch (error) {
      throw Exception('Failed to sign in: $error');
    }
  }

}

