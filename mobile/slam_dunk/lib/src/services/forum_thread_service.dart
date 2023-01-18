import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForumThreadService {
  final Dio _client = Dio();
  final _storage = const FlutterSecureStorage();

  // static const _baseUrl = 'https://slamdunkforum.onrender.com/api/data/forum';
  static const _baseUrl = 'http://localhost:5003/api/data/forum';

  Future<List> _getToken() async {
    String? accessToken = await _storage.read(key: 'accessToken');
    String? refreshToken = await _storage.read(key: 'refreshToken');
    return [accessToken, refreshToken];
  }

  Future<String> getRefreshToken() async {
    String? token = await _storage.read(key: 'token');
    return token!;
  }

  Future<dynamic> getForum(String api) async {
    List? token = await _getToken();
    try {
      return await _fetchedThread(token[0]!, api);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        // Response response = await _client.post(
        //     'https://slamdunkusers.onrender.com/api/user/token',
        //     data: {'token': token[1]});
        Response response = await _client.post(
            'http://localhost:5002/api/user/token',
            data: {'token': token[1]});
        if (response.statusCode == 201) {
          await _storage.write(key: 'token', value: response.data);
          return await _fetchedThread(await getRefreshToken(), api);
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

  createComment(String author, String body, String id) async {
    List? token = await _getToken();
    try {
      final info = {
        'author': author,
        'body': body,
        'id': id,
        'token': token[0]
      };

      return await _onCreateComment(info);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        //  Response response = await _client.post(
        //     'https://slamdunkusers.onrender.com/api/user/token',
        //     data: {'token': token[1]});
        Response response = await _client.post(
            'http://localhost:5002/api/user/token',
            data: {'token': token[1]});
        if (response.statusCode == 201) {
          await _storage.write(key: 'token', value: response.data);
          final info = {
            'author': author,
            'body': body,
            'id': id,
            'token': await getRefreshToken()
          };

          return await _onCreateComment(info);
        }
      }
    }
  }

  _onCreateComment(Map<String, dynamic> info) async {
    final options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${info["token"]}'
    });
    Response response = await _client.put(
        'http://localhost:5003/api/data/message/${info["id"]}',
        data: {
          "body": {"author": info["author"], "content": info["body"]}
        },
        options: options);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
