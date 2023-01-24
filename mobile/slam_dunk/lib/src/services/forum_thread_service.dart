import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForumThreadService {
  final Dio _client = Dio();
  final _storage = const FlutterSecureStorage();

  static const _baseUrl = 'https://slamdunkforum.onrender.com/api/data';
  // static const _baseUrl = 'http://localhost:5003/api/data';

  Future<List> _getToken() async {
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
    List? token = await _getToken();
    if (e.response?.statusCode == 403) {
      Response response = await _client.post(url, data: {'token': token[1]});
      if (response.statusCode == 201) {
        await _storage.write(key: 'token', value: response.data);
      }
    }
  }

  Future<dynamic> getForum(String api) async {
    try {
      List? token = await _getToken();
      return await _fetchedThread(token[0]!, api);
    } on DioError catch (e) {
      return await _retryAccess(e).then((_) async {
        return await _fetchedThread(await getRefreshToken(), api);
      }).catchError((err) => throw Exception('error: $err'));
    }
  }

  _fetchedThread(String token, String api) async {
    final options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    String url = '$_baseUrl/forum/$api';
    Response response = await _client.get(url, options: options);
    return response.statusCode == 200 ? response.data : null;
  }

  createComment(String author, String body, String id) async {
    try {
      List? token = await _getToken();
      final info = {
        'author': author,
        'body': body,
        'id': id,
        'token': token[0]
      };
      return await _onCreateComment(info);
    } on DioError catch (e) {
      return await _retryAccess(e).then((_) async {
        final info = {
          'author': author,
          'body': body,
          'id': id,
          'token': await getRefreshToken()
        };
        return await _onCreateComment(info);
      }).catchError((err) => throw Exception('error: $err'));
    }
  }

  deleteComment(String forumId, String messageId) async {
    try {
      List? token = await _getToken();
      final info = {
        "forum_id": forumId,
        "message_id": messageId,
        "token": token[0]
      };
      return await _onDeleteComment(info);
    } on DioError catch (e) {
      return await _retryAccess(e).then((_) async {
        final info = {
          "forum_id": forumId,
          "message_id": messageId,
          "token": await getRefreshToken()
        };
        return await _onDeleteComment(info);
      }).catchError((err) => throw Exception('error: $err'));
    }
  }

  _onCreateComment(Map<String, dynamic> info) async {
    final options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${info["token"]}'
    });
    Response response = await _client.put(
        '$_baseUrl/message/${info["id"]}',
        data: {
          "body": {"author": info["author"], "content": info["body"]}
        },
        options: options);
    return response.statusCode == 200 ? response.data : null;
  }

  _onDeleteComment(Map<String, dynamic> info) async {
    final options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${info["token"]}'
    });
    Response response = await _client.delete(
        '$_baseUrl/message/delete/${info["forum_id"]}/${info["message_id"]}',
        options: options);
    return response.statusCode == 200 ? response.data : null;
  }
}
