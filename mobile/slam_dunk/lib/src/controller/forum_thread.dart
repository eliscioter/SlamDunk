import 'dart:convert';

import 'package:slam_dunk/src/model/thread_model.dart';
import 'package:slam_dunk/src/services/forum_thread_service.dart';

class FetchForumThread {
  Future<Thread?> displayThread(String id) async {
    var response = await ForumThreadService()
        .getForum(id)
        .catchError((err) => throw Exception('error: $err'));
    if (response == null) return null;
    Thread? thread = threadFromJson(jsonEncode(response));
    return thread;
  }

  onComment(String author, String body, String id) async {
    var response = await ForumThreadService()
        .createComment(author, body, id)
        .catchError((err) => throw Exception('error: $err'));
    if (response == null) return null;
  }

  onDelete(String forumId, String messageId) async {
    var response = await ForumThreadService()
        .deleteComment(forumId, messageId)
        .catchError((err) => throw Exception('error: $err'));
    if (response == null) return null;
  }
}
