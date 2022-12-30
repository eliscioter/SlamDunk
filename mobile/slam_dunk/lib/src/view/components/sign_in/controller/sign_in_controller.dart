import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slam_dunk/src/model/member_model.dart';
import 'package:slam_dunk/src/provider/user_provider.dart';
import 'package:slam_dunk/src/services/sign_in_service.dart';

class Authentication extends StateNotifier<Member> {
  Authentication() : super(Member());

  testMethod(String username, password) async {
    var response =
        await SignInService().auth(username, password).catchError((err) {
      print(err);
    });

    Member user = memberFromJson(jsonEncode(response));
    return user;
  }
@override
  void dispose() {
    super.dispose();
  }
  
}

final userController =
    StateNotifierProvider<Authentication, Member>((ref) => Authentication());
