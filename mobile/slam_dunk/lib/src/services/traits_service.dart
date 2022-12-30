import 'package:dio/dio.dart';

class OffenseService {
  final Dio _client = Dio();
  static const String _baseUrl =
      'https://slamdunk.onrender.com/api/data/category';
  final options = Options(headers: {
    'Content-Type': 'application/json',
  });
  Future<dynamic> getOffense(String api) async {
    String url = '$_baseUrl/$api';

    Response response = await _client.get(url, options: options);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(url);
    }
  }

  Future<dynamic> getDefense(String api) async {
    String url = '$_baseUrl/$api';

    Response response = await _client.get(url, options: options);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(url);
    }
  }

  Future<dynamic> getTricks(String api) async {
    String url = '$_baseUrl/$api';

    Response response = await _client.get(url, options: options);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(url);
    }
  }
}
