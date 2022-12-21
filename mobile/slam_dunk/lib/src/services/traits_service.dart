import 'package:http/http.dart' as http;

class OffenseService {
  final _client = http.Client();
  static const String _baseUrl =
      'https://slamdunk.onrender.com/api/data/category';

  Future<dynamic> getOffense(String api) async {
    var url = Uri.parse('$_baseUrl/$api');
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await _client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(url);
    }
  }
  Future<dynamic> getDefense(String api) async {
    var url = Uri.parse('$_baseUrl/$api');
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await _client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(url);
    }
  }
  Future<dynamic> getTricks(String api) async {
    var url = Uri.parse('$_baseUrl/$api');
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await _client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(url);
    }
  }
}
