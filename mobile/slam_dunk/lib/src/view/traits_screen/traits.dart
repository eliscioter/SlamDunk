import 'package:flutter/material.dart';
import 'package:slam_dunk/src/view/traits_screen/components/defense.dart';
import 'package:slam_dunk/src/view/traits_screen/components/offense.dart';
import 'package:slam_dunk/src/view/traits_screen/components/tricks.dart';

class Traits extends StatefulWidget {
  const Traits({super.key});

  @override
  State<Traits> createState() => _TraitsState();
}

class _TraitsState extends State<Traits> {
  int offenseColor = 0xffFFFFFF;
  int defenseColor = 0x00FFFFFF;
  int tricksColor = 0x00FFFFFF;
  Widget currentCategory = const Offense_Screen();
  @override
  void initState() {
    super.initState();
    setState(() {
      offenseColor = 0xffFFBF00;
      currentCategory = const Offense_Screen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          offenseColor = 0xffFFBF00;
                          defenseColor = 0xffFFFFFF;
                          tricksColor = 0xffFFFFFF;
                          currentCategory = const Offense_Screen();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Color(offenseColor),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        width: 80.0,
                        child: const Text(
                          'Offense',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          offenseColor = 0xffFFFFFF;
                          tricksColor = 0xffFFFFFF;
                          defenseColor = 0xffFFBF00;
                          currentCategory = const Defense_Screen();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Color(defenseColor),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        width: 80.0,
                        child: const Text(
                          'Defense',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          defenseColor = 0xffFFFFFF;
                          offenseColor = 0xffFFFFFF;
                          tricksColor = 0xffFFBF00;
                          currentCategory = const Tricks_Screen();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Color(tricksColor),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        width: 80.0,
                        child: const Text(
                          'Tricks',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          currentCategory
        ],
      ),
    );
  }
}
