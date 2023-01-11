import 'dart:convert';

import 'package:slam_dunk/src/model/forum_model.dart';
import 'package:slam_dunk/src/model/thread_model.dart';
import 'package:slam_dunk/src/services/forums_service.dart';

class FetchForums {
  Future<List<Forums>?> displayForums() async {
    var response = await ForumsService().getForums('forums').catchError((err) {
      throw Exception('error: $err');
    });

    if (response == null) {
      return null;
    }
    List<Forums> forums = forumsFromJson(jsonEncode(response));
    return forums;
  }

  onCreateForum(Map<String, dynamic> form) async {
    var response = await ForumsService().createForum(form).catchError((err) {
      throw Exception('error: $err');
    });

    if (response == null) {
      return null;
    }
    Thread? thread = threadFromJson(jsonEncode(response));
    return [thread?.id, thread?.title];
  }
}
