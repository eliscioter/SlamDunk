import 'package:flutter/material.dart';
import 'package:slam_dunk/src/model/player_model.dart';
import 'package:slam_dunk/src/style/colors.dart';
import 'package:slam_dunk/src/view/player_info_screen/controller/fetched_player_info.dart';

class PlayerInfo extends StatefulWidget {
  final String playerName, playerId;

  const PlayerInfo(
      {super.key, required this.playerName, required this.playerId});
  @override
  State<PlayerInfo> createState() => _PlayerInfoState();
}

class _PlayerInfoState extends State<PlayerInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playerName),
        backgroundColor: Color(AppColor().backgroundColor),
      ),
      body: FutureBuilder<dynamic>(
        future: FetchedPlayerInfo().displayPlayerInfo(widget.playerId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(snapshot.data.player.profile.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 15.0),
                      decoration: BoxDecoration(
                        color: const Color(0xff832421).withOpacity(0.8),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${snapshot.data.player.profile.playerName.firstName} ${snapshot.data.player.profile.playerName.lastName}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${snapshot.data.player.profile.position.abbr} - ${snapshot.data.player.profile.position.fullVersion}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data.player.profile.school,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (snapshot.data.player.profile.height)
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (snapshot.data.player.profile.weight)
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data.player.profile.description,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            color: const Color(0xffffeece).withOpacity(0.8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Tooltip(
                                        message: snapshot.data.player.talents.talent1.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot.data.player
                                              .talents.talent1.talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                      Tooltip(
                                        message: snapshot.data.player.talents.talent2.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot.data.player
                                              .talents.talent2.talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                      Tooltip(
                                        message: snapshot.data.player.talents.talent3.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot.data.player
                                              .talents.talent3.talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                      Tooltip(
                                        message: snapshot.data.player.talents.talent4.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot.data.player
                                              .talents.talent4.talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                      Tooltip(
                                        message: snapshot.data.player.talents.talent5.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot.data.player
                                              .talents.talent5.talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Tooltip(
                                        message: snapshot.data.player.talents.talent6.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot.data.player
                                              .talents.talent6.talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 80.0,
                                          width: 80.0,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.player.talents.talent6.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
