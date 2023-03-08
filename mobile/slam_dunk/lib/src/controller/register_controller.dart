import 'package:slam_dunk/src/controller/sign_in_controller.dart';
import 'package:slam_dunk/src/services/register_service.dart';

class RegisterController {
  signUp(Map<String, String> credentials) async {
    bool isAuthenticated = await RegisterService().onSignUp(credentials);
    if (isAuthenticated) {
      Authentication()
          .signIn(credentials['username']!, credentials['password']!);
      return true;
    }
    return false;
  }
}
