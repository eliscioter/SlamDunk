import 'package:slam_dunk/src/model/player_model.dart';
import 'package:slam_dunk/src/services/players_service.dart';

class FetchedPlayer {
  Future<List<Player>?> displayPlayers() async {
    var response =
        await PlayersService().getPlayers('players').catchError((err) {
      print(err);
    });

    if (response == null) return null;
    var player = playerFromJson(response);
    return player;
  }
}
