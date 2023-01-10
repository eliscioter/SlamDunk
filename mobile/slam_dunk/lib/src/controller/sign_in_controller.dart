import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:slam_dunk/src/model/member_model.dart';
import 'package:slam_dunk/src/services/sign_in_service.dart';

class Authentication extends StateNotifier<Member> {
  final _storage = const FlutterSecureStorage();

  Authentication() : super(Member());

  signIn(String username, String password) async {
    var response =
        await SignInService().auth(username, password).catchError((err) {
      throw Exception('error: $err');
    });

    Member user = memberFromJson(jsonEncode(response));

    if (await _storage.containsKey(key: 'accessToken') ||
        await _storage.containsKey(key: 'refreshToken')) {
      _storage.deleteAll();
    }
    await _storage.write(key: 'accessToken', value: user.accessToken);
    await _storage.write(key: 'refreshToken', value: user.refreshToken);

    return user;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

final userController =
    StateNotifierProvider<Authentication, Member>((ref) => Authentication());
