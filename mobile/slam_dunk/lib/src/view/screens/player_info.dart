import 'package:flutter/material.dart';
import 'package:slam_dunk/src/style/colors.dart';

class PlayerInfo extends StatelessWidget {

  final String playerName, playerId;

  const PlayerInfo({super.key, required this.playerName, required this.playerId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playerName),
        backgroundColor: Color(AppColor().backgroundColor),
      ),
      body: Text('hello')
    );
  }
}
