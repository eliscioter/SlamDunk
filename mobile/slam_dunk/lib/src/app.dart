import 'package:flutter/material.dart';

import 'package:slam_dunk/src/view/homepage.dart';

class SlamDunk extends StatelessWidget {
  const SlamDunk({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
