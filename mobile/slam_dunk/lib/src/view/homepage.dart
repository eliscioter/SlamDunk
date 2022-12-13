import 'package:flutter/material.dart';

import 'package:slam_dunk/src/style/colors.dart';
import 'package:slam_dunk/src/view/screens/players.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const routeName = 'Slam Dunk Wiki';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color(AppColor().backgroundColor),
      ),
      appBar: AppBar(
        title: const Text(routeName),
        backgroundColor: Color(AppColor().backgroundColor),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homepage_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/homepage_bg.png'),
            ),
            const Text('Scout the players!'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Players()));
              },
              child: const Text("Let's go"),
            ),
          ],
        ),
      ),
    );
  }
}
