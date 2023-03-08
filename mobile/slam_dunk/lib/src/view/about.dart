import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homepage_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'This website is created to be an informative guide or wiki about the mobile game Slam Dunk from TV Animation.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: const Text(
                  'The Team',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/riv.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              const Text(
                                'Riv Avila',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  child: Image.asset(
                                    'assets/images/gabriel.png',
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                              const Text(
                                'Gabriel Sabater',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                ClipOval(
                                  child: Container(
                                    color: Colors.white,
                                    child: Image.asset(
                                      'assets/images/johnrod.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Johnrod Jardeleza',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                ClipOval(
                                  child: Container(
                                    color: Colors.white,
                                    child: Image.asset(
                                      'assets/images/cj.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'CJ Mondoñedo',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/images/jana.jpg',
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                const Text(
                                  'Jana Yac',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                ClipOval(
                                  child: Container(
                                      color: Colors.white,
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 50.0,
                                        child: Icon(
                                          Icons.person,
                                          size: 100,
                                        ),
                                      )),
                                ),
                                const Text(
                                  'Allisandra Bendijo',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
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
      ),
    ));
  }
}
