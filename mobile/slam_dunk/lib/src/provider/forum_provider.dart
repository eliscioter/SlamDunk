import 'package:flutter_riverpod/flutter_riverpod.dart';

class Forum extends StateNotifier<List> {
  Forum() : super(['']);

  void setForumId(String id, String title) => state = [id, title];
}

final forumIdProvider = StateNotifierProvider<Forum, List>((ref) => Forum());
