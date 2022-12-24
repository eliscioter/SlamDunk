import 'package:flutter/material.dart';
import 'package:slam_dunk/src/style/colors.dart';
import 'package:slam_dunk/src/view/components/sign_in/controller/sign_in_controller.dart';
import 'package:slam_dunk/src/view/components/sign_in/sign_in.dart';

import 'package:slam_dunk/src/view/homepage.dart';
import 'package:slam_dunk/src/view/players_screen/players.dart';
import 'package:slam_dunk/src/view/traits_screen/traits.dart';
import 'package:slam_dunk/src/view/forums_screen/forums.dart';
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
    } else {
      indexes = 0;
      current = screens[index];
    }
    indexes = 0;
    return current;
  }

  int _highlight() {
    if (routeName == 'About' || routeName == 'Contact') {
      return 0xffFFFFFF;
    }
    return 0xff8B0000;
  }

  late bool a;

  /* Future<bool> isSignedIn() async {
    return await Authentication().isAuthenticated();
  } */

  bool isSignedIn = false;
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
        drawer: Builder(
          builder: (context) => Drawer(
            backgroundColor: Color(AppColor().backgroundColor),
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    isSignedIn
                        ? Stack(
                            children: [
                              UserAccountsDrawerHeader(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent[700],
                                ),
                                accountName: const Text(
                                  'marcelo',
                                ),
                                accountEmail: const Text('marcelo@gmail.com'),
                                currentAccountPicture: const CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isSignedIn = false;
                                    });
                                  },
                                  child: const Text(
                                    'Sign out',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ListTile(
                            onTap: () {
                              setState(() {
                                isSignedIn = true;
                              });
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      const SignIn());
                            },
                            leading: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            title: const Text(
                              'Sign in',
                              style: TextStyle(color: Colors.red),
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
        body: _screen(),
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
