import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slam_dunk/src/provider/route_name_provider.dart';
import 'package:slam_dunk/src/provider/screen_provider.dart';
import 'package:slam_dunk/src/provider/user_provider.dart';
import 'package:slam_dunk/src/provider/user_status_provider.dart';
import 'package:slam_dunk/src/services/sign_in_service.dart';
import 'package:slam_dunk/src/style/colors.dart';
import 'package:slam_dunk/src/view/about.dart';
import 'package:slam_dunk/src/view/components/sign_in.dart';
import 'package:slam_dunk/src/view/contact.dart';
import 'package:slam_dunk/src/view/forums.dart';
import 'package:slam_dunk/src/view/homepage.dart';
import 'package:slam_dunk/src/view/players.dart';
import 'package:slam_dunk/src/view/traits.dart';

class SlamDunk extends ConsumerStatefulWidget {
  const SlamDunk({super.key});

  @override
  ConsumerState<SlamDunk> createState() => _SlamDunkState();
}

class _SlamDunkState extends ConsumerState<SlamDunk> {
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    const storage = FlutterSecureStorage();
    if (await storage.containsKey(key: 'accessToken')) {
      String username = (await storage.read(key: 'username'))!;
      String role = (await storage.read(key: 'role'))!;
      ref.read(userProvider.notifier).setUserInfo([username, role]);
      ref.read(isSignedInProvider.notifier).isSignedIn(true);
    } else {
      ref.read(userProvider.notifier).setUserInfo(['', '']);
      ref.read(isSignedInProvider.notifier).isSignedIn(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeName = ref.watch(routeNameProvider);
    final isSignedIn = ref.watch(isSignedInProvider);
    final index = ref.watch(screenProvider);
    final userInfo = ref.watch(userProvider);
    const screens = [
      HomePage(),
      Players(),
      Traits(),
      Forum(),
      About(),
      Contact(),
    ];

    int highlight() {
      if (routeName == 'About' || routeName == 'Contact') {
        return 0xffFFFFFF;
      }
      return 0xff8B0000;
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
                                accountName: Text(
                                  userInfo[0].toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                accountEmail: null,
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
                                  onPressed: () async {
                                    if (!await SignInService().signout()) {
                                      Fluttertoast.showToast(
                                          msg: "Error. Can't Sign Out.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      ref
                                          .read(isSignedInProvider.notifier)
                                          .isSignedIn(false);
                                      ref
                                          .read(userProvider.notifier)
                                          .setUserInfo(['', '']);
                                      Fluttertoast.showToast(
                                          msg: '${userInfo[0]} signed out',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
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
                        ref.read(screenProvider.notifier).setScreenIndex(4);

                        ref
                            .read(routeNameProvider.notifier)
                            .setRouteName('About');
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
                        ref.read(screenProvider.notifier).setScreenIndex(5);
                        ref
                            .read(routeNameProvider.notifier)
                            .setRouteName('Contact');
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
        body: screens[index],
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            currentIndex: index > 3 ? 0 : index,
            onTap: (index) {
              ref.read(screenProvider.notifier).setScreenIndex(index);
              if (index == 0) {
                ref
                    .read(routeNameProvider.notifier)
                    .setRouteName('Slam Dunk Wiki');
              } else if (index == 1) {
                ref.read(routeNameProvider.notifier).setRouteName('Players');
              } else if (index == 2) {
                ref.read(routeNameProvider.notifier).setRouteName('Traits');
              } else if (index == 3) {
                ref.read(routeNameProvider.notifier).setRouteName('Forums');
              }
            },
            selectedItemColor: Color(highlight()),
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
