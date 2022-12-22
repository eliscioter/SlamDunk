import 'package:slam_dunk/src/model/forum_model.dart';
import 'package:slam_dunk/src/services/forums_service.dart';

class FetchForums {
  Future<List<Forums>?> displayForums() async {
    var response = await ForumsService().getForums('forums').catchError((err) {
      print(err);
    });
    if (response == null) return null;
    var forums = forumsFromJson(response);
    return forums;
  }
}
