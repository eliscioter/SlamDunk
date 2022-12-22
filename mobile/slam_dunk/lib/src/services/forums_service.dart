import 'package:http/http.dart' as http;

class ForumsService {
  final _client = http.Client();
  static const _baseUrl = 'https://slamdunkforum.onrender.com/api/data';

  Future<dynamic> getForums(String api) async {
    var url = Uri.parse('$_baseUrl/$api');
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await _client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('error in service');
    }
  }
}
