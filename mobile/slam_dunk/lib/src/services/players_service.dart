import 'package:dio/dio.dart';

class PlayersService {
  final Dio _client = Dio();
  static const String _baseUrl = 'https://slamdunk.onrender.com/api/data';
  // static const String _baseUrl = 'http://localhost:5000/api/data';

  final options = Options(headers: {
    'Content-Type': 'application/json',
  });
  Future<dynamic> getPlayers(String api) async {
    String url = '$_baseUrl/$api';

    Response response = await _client.get(url, options: options);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<dynamic> getPlayer(String api) async {
    String url = '$_baseUrl/player/$api';

    Response response = await _client.get(url, options: options);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
