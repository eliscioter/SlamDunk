import 'package:flutter/material.dart';

import 'package:slam_dunk/src/style/colors.dart';
import 'package:slam_dunk/src/services/players_service.dart';
import 'package:slam_dunk/src/model/player_model.dart';
import 'package:slam_dunk/src/view/screens/player_info.dart';

class Players extends StatefulWidget {
  const Players({super.key});

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  static const routeName = "Players";

  @override
  void initState() {
    super.initState();
    _displayPlayers();
  }

  Future<List<Player>?> _displayPlayers() async {
    var response =
        await PlayersService().getPlayers('players').catchError((err) {
      print(err);
    });

    if (response == null) return null;

    var player = playerFromJson(response);
    return player;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(routeName),
        backgroundColor: Color(AppColor().backgroundColor),
      ),
      body: FutureBuilder<List<Player>?>(
          future: _displayPlayers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String playerName =
                        '${snapshot.data![index].player!.profile!.playerName?.firstName} ${snapshot.data![index].player!.profile!.playerName?.lastName}';
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PlayerInfo(
                                  playerName: playerName,
                                  playerId: snapshot.data![index].id ?? '',
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Card(
                            elevation: 8.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                Image.network(snapshot.data![index].player!
                                        .profile?.imageUrl ??
                                    ''),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(playerName),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
