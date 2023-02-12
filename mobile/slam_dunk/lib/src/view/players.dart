import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:slam_dunk/src/controller/fetched_player.dart';
import 'package:slam_dunk/src/model/player_model.dart';
import 'package:slam_dunk/src/view/player_info.dart';

class Players extends StatefulWidget {
  const Players({super.key});

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Player>?>(
          future: FetchedPlayer().displayPlayers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              IO.Socket socket = IO.io('http://localhost:5000');
              // IO.Socket socket = IO.io('https://slamdunk.onrender.com');
              socket.on('receive-players', (trait) {
                List<dynamic> res = trait;
                Map<String, dynamic> firstElement = res[0];

                Player addPlayer = Player.fromJson(firstElement);
                if (mounted) {
                  setState(() => snapshot.data!.add(addPlayer));
                }
              });
              socket.on('receive-new-players', (players) {
                List<Player> newPlayers = playerFromJson(jsonEncode(players));
                if (mounted) {
                  setState(() {
                    snapshot.data!.clear();
                    snapshot.data!.addAll(newPlayers);
                  });
                }
              });
              socket.on('receive-updated-players', (player) {
                Map<String, dynamic> firstElement = player;
                Player convertPlayer = Player.fromJson(firstElement);
                int index = snapshot.data!
                    .indexWhere((item) => item.id == convertPlayer.id);
                if (index != -1) {
                  if (mounted) {
                    setState(() {
                      snapshot.data![index] = convertPlayer;
                    });
                  }
                }
              });
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
