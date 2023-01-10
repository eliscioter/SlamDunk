import 'package:dio/dio.dart';

class OffenseService {
  final Dio _client = Dio();
  static const String _baseUrl =
      'https://slamdunk.onrender.com/api/data/category';
  // static const String _baseUrl = 'http://localhost:5000/api/data/category';

  final options = Options(headers: {
    'Content-Type': 'application/json',
  });
  Future<dynamic> getOffense(String api) async {
    String url = '$_baseUrl/$api';

    Response response = await _client.get(url, options: options);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getDefense(String api) async {
    String url = '$_baseUrl/$api';

    Response response = await _client.get(url, options: options);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getTricks(String api) async {
    String url = '$_baseUrl/$api';

    Response response = await _client.get(url, options: options);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
