import 'dart:convert';

import 'package:slam_dunk/src/model/player_info_model.dart';
import 'package:slam_dunk/src/services/players_service.dart';

class FetchedPlayerInfo {
  Future<Player?> displayPlayerInfo(String api) async {
    var response = await PlayersService().getPlayer(api).catchError((err) {
      print(err);
    });

    if (response == null) return null;

    Player player = playerFromJson(jsonEncode(response));
    
    return player;
  }
}
