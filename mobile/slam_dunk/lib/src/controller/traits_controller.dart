import 'dart:convert';

import 'package:slam_dunk/src/model/traits/defense_model.dart';
import 'package:slam_dunk/src/model/traits/offense_model.dart';
import 'package:slam_dunk/src/model/traits/tricks.model.dart';
import 'package:slam_dunk/src/services/traits_service.dart';

class FetchTraits {
  Future<List<Offense>?> displayOffense() async {
    var response =
        await OffenseService().getOffense('offense').catchError((err) {
      throw Exception('error: $err');
    });
    if (response == null) return null;
    List<Offense> offense = offenseFromJson(jsonEncode(response));

    return offense;
  }

  Future<List<Defense>?> displayDefense() async {
    var response =
        await OffenseService().getDefense('defense').catchError((err) {
      throw Exception('error: $err');
    });
    if (response == null) return null;
    List<Defense> defense = defenseFromJson(jsonEncode(response));

    return defense;
  }

  Future<List<Tricks>?> displayTricks() async {
    var response = await OffenseService().getTricks('tricks').catchError((err) {
      throw Exception('error: $err');
    });
    if (response == null) return null;
    List<Tricks> tricks = tricksFromJson(jsonEncode(response));

    return tricks;
  }
}
