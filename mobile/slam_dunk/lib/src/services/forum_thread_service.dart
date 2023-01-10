import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForumThreadService {
  final Dio _client = Dio();
  final _storage = const FlutterSecureStorage();

  static const _baseUrl = 'https://slamdunkforum.onrender.com/api/data/forum';
  // static const _baseUrl = 'http://localhost:5003/api/data/forum';
  Future<dynamic> getForums(String api) async {
    String? accessToken = await _storage.read(key: 'accessToken');
    String? refreshToken = await _storage.read(key: 'refreshToken');

    try {
      return await _fetchedThread(accessToken!, api);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        Response response = await _client.post(
            'https://slamdunkusers.onrender.com/api/user/token',
            data: {'token': refreshToken});
        if (response.statusCode == 201) {
          await _storage.write(key: 'token', value: response.data);
          String? token = await _storage.read(key: 'token');
          return await _fetchedThread(token!, api);
        }
      }
    }
  }

  _fetchedThread(String token, String api) async {
    final options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    String url = '$_baseUrl/$api';

    Response response = await _client.get(url, options: options);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
