import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfo extends StateNotifier<List> {
  UserInfo() : super(['','']);

  void setUserInfo(String username, String role) => state = [username, role];

  @override
  void dispose() {
    super.dispose();
  }
}

final userProvider = StateNotifierProvider<UserInfo, List>((ref) => UserInfo());
