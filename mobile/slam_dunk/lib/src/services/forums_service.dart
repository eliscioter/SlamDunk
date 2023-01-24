import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForumsService {
  final Dio _client = Dio();
  static const _baseUrl = 'https://slamdunkforum.onrender.com/api/data';
  final _storage = const FlutterSecureStorage();
  // static const _baseUrl = 'http://localhost:5003/api/data';

  Future<List> _getTokens() async {
    String? accessToken = await _storage.read(key: 'accessToken');
    String? refreshToken = await _storage.read(key: 'refreshToken');
    return [accessToken, refreshToken];
  }

  Future<String> getRefreshToken() async {
    String? token = await _storage.read(key: 'token');
    return token!;
  }

  _retryAccess(DioError e) async {
    String url = 'https://slamdunkusers.onrender.com/api/user/token';
    // String url = 'http://localhost:5002/api/user/token';
    List? token = await _getTokens();
    if (e.response?.statusCode == 403) {
      Response response = await _client.post(url, data: {'token': token[1]});
      if (response.statusCode == 201) {
        await _storage.write(key: 'token', value: response.data);
      }
    }
  }

  Future<dynamic> getForums(String api) async {
    String url = '$_baseUrl/$api';
    final options = Options(headers: {
      'Content-Type': 'application/json',
    });
    Response response = await _client.get(url, options: options);
    return response.statusCode == 200 ? response.data : null;
  }

  createForum(Map<String, dynamic> forum) async {
    try {
      List? token = await _getTokens();
      return await _sendForum(token[0], forum);
    } on DioError catch (e) {
      return _retryAccess(e).then((_) async {
        return await _sendForum(await getRefreshToken(), forum);
      }).catchError((err) => throw Exception('error: $err'));
    }
  }

  deleteForum(String forumId) async {
    try {
      List? token = await _getTokens();
      return await _removeForum(token[0], forumId);
    } on DioError catch (e) {
      return await _retryAccess(e).then((_) async {
        return await _removeForum(await getRefreshToken(), forumId);
      }).catchError((err) => throw Exception('error: $err'));
    }
  }

  _sendForum(String token, Map<String, dynamic> forum) async {
    final options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    Response response =
        await _client.post('$_baseUrl/store', options: options, data: forum);
    return response.statusCode == 201 ? response.data : null;
  }

  _removeForum(String token, String id) async {
    final options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    Response response =
        await _client.delete('$_baseUrl/forum/delete/$id', options: options);
    return response.statusCode == 200 ? response.data : null;
  }
}
