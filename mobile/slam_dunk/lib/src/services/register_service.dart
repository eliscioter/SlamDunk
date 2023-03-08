import 'package:dio/dio.dart';

class RegisterService {
  final Dio _client = Dio();
  static const String _baseUrl = 'https://slamdunkusers.onrender.com/api/user';
  // static const String _baseUrl = 'http://localhost:5002/api/user';

  onSignUp(Map<String, String> userInfo) async {
    try {
      final Response response =
          await _client.post('$_baseUrl/store', data: userInfo);
      if (response.statusCode != 201) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
