import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForumsService {
  final Dio _client = Dio();
  static const _baseUrl = 'https://slamdunkforum.onrender.com/api/data';
  final _storage = const FlutterSecureStorage();
  // static const _baseUrl = 'http://localhost:5003/api/data';

  Future<dynamic> getForums(String api) async {
    String url = '$_baseUrl/$api';
    final options = Options(headers: {
      'Content-Type': 'application/json',
    });
    Response response = await _client.get(url, options: options);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  createForum(Map<String, dynamic> form) async {
    String? accessToken = await _storage.read(key: 'accessToken');
    String? refreshToken = await _storage.read(key: 'refreshToken');
    try {
      return await _sendForum(accessToken!, form);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        Response response = await _client.post(
            'https://slamdunkusers.onrender.com/api/user/token',
            data: {'token': refreshToken});
        if (response.statusCode == 201) {
          await _storage.write(key: 'token', value: response.data);
          String? token = await _storage.read(key: 'token');
          return await _sendForum(token!, form);
        }
      }
    }
  }

  _sendForum(String token, Map<String, dynamic> form) async {
    final options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    Response response =
        await _client.post('$_baseUrl/store', options: options, data: form);
    if (response.statusCode == 201) {
      return response.data;
    } else {
      return null;
    }
  }
}
