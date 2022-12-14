import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
                            color: const Color(0xffffeece).withOpacity(0.6),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Tooltip(
                                        message: snapshot
                                            .data.player.talents.talent1.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .data
                                              .player
                                              .talents
                                              .talent1
                                              .talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                      Tooltip(
                                        message: snapshot
                                            .data.player.talents.talent2.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .data
                                              .player
                                              .talents
                                              .talent2
                                              .talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                      Tooltip(
                                        message: snapshot
                                            .data.player.talents.talent3.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .data
                                              .player
                                              .talents
                                              .talent3
                                              .talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                      Tooltip(
                                        message: snapshot
                                            .data.player.talents.talent4.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .data
                                              .player
                                              .talents
                                              .talent4
                                              .talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 60.0,
                                          width: 60.0,
                                        ),
                                      ),
                                      Tooltip(
                                        message: snapshot
                                            .data.player.talents.talent5.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .data
                                              .player
                                              .talents
                                              .talent5
                                              .talentImageUrl),
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
                                        message: snapshot
                                            .data.player.talents.talent6.name,
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .data
                                              .player
                                              .talents
                                              .talent6
                                              .talentImageUrl),
                                          fit: BoxFit.contain,
                                          height: 80.0,
                                          width: 80.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          snapshot
                                              .data.player.talents.talent6.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xff1c1616).withOpacity(0.8),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 15.0),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'General Attribute',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Control',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .general
                                                      .control /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .general
                                                                .control /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.blue,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Strength',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .general
                                                      .strength /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .general
                                                                .strength /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.blue,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'RES',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .general
                                                      .res /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .general
                                                                .res /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.blue,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Jump',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .general
                                                      .jump /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .general
                                                                .jump /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.blue,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Run',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .general
                                                      .run /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .general
                                                                .run /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.blue,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Dribble',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .general
                                                      .dribble /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .general
                                                                .dribble /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.blue,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 15.0),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Offense Attribute',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Close',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .offense
                                                      .close /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .offense
                                                                .close /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.red,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Middle',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .offense
                                                      .middle /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .offense
                                                                .middle /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.red,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              '3PT',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .offense
                                                      .threePointer /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .offense
                                                                .threePointer /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.red,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Jump',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .offense
                                                      .dunk /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .offense
                                                                .dunk /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.red,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Run',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .offense
                                                      .layup /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .offense
                                                                .layup /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.red,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 15.0),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Defense Attribute',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'REB',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .defense
                                                      .reb /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .defense
                                                                .reb /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.cyan,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'BLK',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .defense
                                                      .blk /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .defense
                                                                .blk /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.cyan,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Jam',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .defense
                                                      .jam /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .defense
                                                                .jam /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.cyan,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'STL',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  120,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2500,
                                              percent: (snapshot
                                                      .data
                                                      .player
                                                      .attributes
                                                      .defense
                                                      .stl /
                                                  200),
                                              center: Text(
                                                ((snapshot
                                                                .data
                                                                .player
                                                                .attributes
                                                                .defense
                                                                .stl /
                                                            200) *
                                                        100)
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              barRadius:
                                                  const Radius.circular(5.0),
                                              progressColor: Colors.cyan,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
