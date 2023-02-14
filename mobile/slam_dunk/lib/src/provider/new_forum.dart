import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewForum extends StateNotifier<String> {
  NewForum() : super('');

  void setNewForumId(String id) => state = id;
}

final newForumIdProvider = StateNotifierProvider<NewForum, String>((ref) => NewForum());
