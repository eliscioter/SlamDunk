import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfo extends StateNotifier<String> {
  UserInfo() : super('');

  void setUserInfo(String user) => state = user;
   @override
  void dispose() {
    super.dispose();
  }
}

final userProvider =
    StateNotifierProvider<UserInfo, String>((ref) => UserInfo());
