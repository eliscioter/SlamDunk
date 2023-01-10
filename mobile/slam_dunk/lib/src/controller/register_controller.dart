import 'package:slam_dunk/src/controller/sign_in_controller.dart';
import 'package:slam_dunk/src/services/register_service.dart';
import 'package:slam_dunk/src/services/sign_in_service.dart';

class RegisterController {
  signUp(Map<String, String> credentials) async {
    if (await RegisterService().onSignUp(credentials)) {
      Authentication()
          .signIn(credentials['username']!, credentials['password']!);
          
      return true;
    }
    return false;
  }
}
