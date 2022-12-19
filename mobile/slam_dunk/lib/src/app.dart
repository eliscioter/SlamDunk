import 'package:flutter/material.dart';
import 'package:slam_dunk/src/style/colors.dart';

import 'package:slam_dunk/src/view/homepage.dart';
import 'package:slam_dunk/src/view/players_screen/players.dart';
import 'package:slam_dunk/src/view/traits_screen/traits.dart';
import 'package:slam_dunk/src/view/forum_screen/forum.dart';
import 'package:slam_dunk/src/view/about/about.dart';
import 'package:slam_dunk/src/view/contact/contact.dart';

class SlamDunk extends StatefulWidget {
  const SlamDunk({super.key});

  @override
  State<SlamDunk> createState() => _SlamDunkState();
}

class _SlamDunkState extends State<SlamDunk> {
  int index = 0;
  static const screens = [
    HomePage(),
    Players(),
    Traits(),
    Forum(),
  ];

  late String routeName;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      routeName = 'Home';
    } else if (index == 1) {
      routeName = 'Players';
    } else if (index == 2) {
      routeName = 'Traits';
    } else if (index == 3) {
      routeName = 'Forum';
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Builder(
          builder: (context) => Drawer(
            backgroundColor: Color(AppColor().backgroundColor),
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.redAccent[700],
                      ),
                      accountName: const Text("Marcelo Augusto Elias"),
                      accountEmail: const Text("marcelo@gmail.com"),
                      currentAccountPicture: const CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const About(),
                          ),
                        );
                      },
                      leading: const Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'About us',
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Contact(),
                          ),
                        );
                      },
                      leading: const Icon(
                        Icons.contact_support,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Contact us',
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(routeName),
          backgroundColor: Color(AppColor().backgroundColor),
        ),
        body: screens[index],
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState((() => this.index = index)),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.sports_handball_outlined), label: 'Players'),
              NavigationDestination(
                  icon: Icon(Icons.psychology_outlined), label: 'Traits'),
              NavigationDestination(
                  icon: Icon(Icons.forum_outlined), label: 'Forum'),
            ],
          ),
        ),
      ),
    );
  }
}
