import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slam_dunk/src/model/forum_model.dart';

class ForumData extends StateNotifier<List<Forums>?> {
  ForumData() : super([]);

  void setForum(List<Forums>? data) => state = data;
}

final forumsDataProvider =
    StateNotifierProvider<ForumData, List<Forums>?>((ref) => ForumData());
