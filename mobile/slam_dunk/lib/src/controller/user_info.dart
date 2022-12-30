import 'package:slam_dunk/src/model/member_model.dart';

class UserInfo {
  late String username;
  UserInfo(Member member) {
    username = member.username!;
  }
}
