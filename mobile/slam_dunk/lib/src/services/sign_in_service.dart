import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInService {
  final Dio _client = Dio();
  static const String _baseUrl = 'https://slamdunkusers.onrender.com/api/user';
  final _storage = const FlutterSecureStorage();

  // static const String _baseUrl = 'http://localhost:5002/api/user';

  final options = Options(headers: {
    'Content-Type': 'application/json',
  });
  Future auth(String username, String password) async {
    try {
      final response = await _client.post('$_baseUrl/login', data: {
        'username': username,
        'password': password,
      });
      if (response.statusCode != 200) {
        return null;
      }
      return response.data;
    } catch (error) {
      throw Exception('Failed to sign in: $error');
    }
  }

  Future<bool> signout() async {
    if (await _storage.containsKey(key: 'token')) {
      String? token = await _storage.read(key: 'token');
      Response response = await _client.delete('$_baseUrl/logout/$token');
      if (response.statusCode == 404 || response.statusCode == 400) {
        return false;
      }
      _storage.deleteAll();
      return true;
    } else {
      String? refreshToken = await _storage.read(key: 'refreshToken');
      Response response =
          await _client.delete('$_baseUrl/logout/$refreshToken');
      if (response.statusCode == 404 || response.statusCode == 400) {
        return false;
      }
      _storage.deleteAll();
      return true;
    }
  }
}
