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
  int index = 0, indexes = 0;
  static const screens = [
    HomePage(),
    Players(),
    Traits(),
    Forum(),
    About(),
    Contact(),
  ];

  late String routeName;

  Widget _screen() {
    Widget current;
    if (indexes > 3) {
      current = screens[indexes];
    }
    indexes = 0;
    current = screens[index];
    return current;
  }

  int _highlight() {
    if (routeName == 'About' || routeName == 'Contact') {
      return 0xffFFFFFF;
    }
    return 0xff8B0000;
  }

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      routeName = 'Slam Dunk Wiki';
    } else if (index == 1) {
      routeName = 'Players';
    } else if (index == 2) {
      routeName = 'Traits';
    } else if (index == 3) {
      routeName = 'Forum';
    }
    if (indexes == 4) {
      routeName = 'About';
    } else if (indexes == 5) {
      routeName = 'Contact';
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(routeName),
          backgroundColor: Color(AppColor().backgroundColor),
        ),
        body: _screen(),
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
                        Navigator.pop(context);
                        setState(() {
                          indexes = 4;
                        });
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
                        Navigator.pop(context);
                        setState(() {
                          indexes = 5;
                        });
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
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (index) => setState((() => this.index = index)),
            selectedItemColor: Color(_highlight()),
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_handball_outlined),
                label: 'Players',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.psychology_outlined),
                label: 'Traits',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.forum_outlined),
                label: 'Forum',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
