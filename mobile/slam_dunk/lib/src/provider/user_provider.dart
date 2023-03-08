import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfo extends StateNotifier<List<String>> {
  UserInfo() : super(['','']);

  void setUserInfo(List<String> userDetails) => state = [userDetails[0], userDetails[1]];

  @override
  void dispose() {
    super.dispose();
  }
}

final userProvider = StateNotifierProvider<UserInfo, List<String>>((ref) => UserInfo());
