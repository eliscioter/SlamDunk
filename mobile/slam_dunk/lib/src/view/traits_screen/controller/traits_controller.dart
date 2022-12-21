import 'package:slam_dunk/src/model/traits/defense_model.dart';
import 'package:slam_dunk/src/model/traits/offense_model.dart';
import 'package:slam_dunk/src/model/traits/tricks.model.dart';
import 'package:slam_dunk/src/services/traits_service.dart';

class FetchTraits {
  Future<List<Offense>?> displayOffense() async {
    var response =
        await OffenseService().getOffense('offense').catchError((err) {
      print(err);
    });
    if (response == null) return null;
    var offense = offenseFromJson(response);

    return offense;
  }

  Future<List<Defense>?> displayDefense() async {
    var response =
        await OffenseService().getDefense('defense').catchError((err) {
      print(err);
    });
    if (response == null) return null;
    var defense = defenseFromJson(response);

    return defense;
  }

  Future<List<Tricks>?> displayTricks() async {
    var response = await OffenseService().getTricks('tricks').catchError((err) {
      print(err);
    });
    if (response == null) return null;
    var tricks = tricksFromJson(response);

    return tricks;
  }
}
