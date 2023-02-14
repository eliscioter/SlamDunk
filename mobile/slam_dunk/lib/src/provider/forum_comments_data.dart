import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForumComments extends StateNotifier<List> {
  ForumComments() : super(['']);

  void setForumComments(data) => state = data;
  
}

final forumCommentsProvider = StateNotifierProvider<ForumComments, List<dynamic>>((ref) => ForumComments());
