import 'dart:math';

import 'package:flutter/material.dart';

import 'package:slam_dunk/src/view/players.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getQuote() {
    const quotes = [
      {
        'quote':
            'It is not too late to change ourselves and have a meaningful life.',
        'author': 'Hanamichi Sakuragi'
      },
      {
        'quote': 'Basics are important. Isn’t that right, Gori?',
        'author': 'Hanamichi Sakuragi'
      },
      {
        'quote':
            'You guys common knowldege about basketball, does not work against me… Because I am just an amateur.',
        'author': 'Hanamichi Sakuragi'
      },
      {'quote': 'Even geniuses make mistakes.', 'author': 'Haruko'},
      {
        'quote':
            'No one can ever know how to do everything without learning it first.',
        'author': 'Haruko'
      },
      {
        'quote':
            "Keep practicing, never let somebody tell you you're too small or too slow.",
        'author': 'Ryota Miyagi'
      },
      {
        'quote': "If you give up, that's the end of the game.",
        'author': 'Coach Anzai'
      },
      {
        'quote':
            'For an inadequate person… The path to reach a higher level… He must admit his poorness which is the first step.',
        'author': 'Coach Anzai'
      },
    ];

    int index = Random().nextInt(7) + 1;
    return '${quotes[index]['quote']}\n\n-${quotes[index]['author']}';
  }

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homepage_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getQuote().toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Image(
                  image: AssetImage('assets/images/homepage_bg.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
