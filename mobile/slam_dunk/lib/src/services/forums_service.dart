import 'package:dio/dio.dart';

class ForumsService {
  final Dio _client = Dio();
  static const _baseUrl = 'https://slamdunkforum.onrender.com/api/data';
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
}
