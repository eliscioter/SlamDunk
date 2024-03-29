import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:slam_dunk/src/model/traits/defense_model.dart';
import 'package:slam_dunk/src/controller/traits_controller.dart';

class Defense_Screen extends StatefulWidget {
  const Defense_Screen({super.key});

  @override
  State<Defense_Screen> createState() => _Defense_ScreenState();
}

class _Defense_ScreenState extends State<Defense_Screen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Defense>?>(
          future: FetchTraits().displayDefense(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              // IO.Socket socket = IO.io('http://localhost:5000');
              IO.Socket socket = IO.io('https://slamdunk.onrender.com');
              socket.on('receive-traits', (trait) {
                List<dynamic> res = trait;
                Map<String, dynamic> firstElement = res[0];
                if (firstElement['tag'] == 'defense') {
                  Defense addTrait = Defense.fromJson(firstElement);
                  if (mounted) {
                    setState(() => snapshot.data!.add(addTrait));
                  }
                }
              });
              socket.on('receive-new-traits', (traits) {
                List<Defense> newTraits = defenseFromJson(jsonEncode(traits));
                if (mounted) {
                  setState(() {
                    snapshot.data!.clear();
                    snapshot.data!.addAll(newTraits);
                  });
                }
              });
              socket.on('receive-updated-traits', (trait) {
                Map<String, dynamic> firstElement = trait;
                Defense convertTrait = Defense.fromJson(firstElement);
                if (firstElement['tag'] == 'defense') {
                  int index = snapshot.data!
                      .indexWhere((item) => item.id == convertTrait.id);
                  if (index != -1) {
                    if (mounted) {
                      setState(() {
                        snapshot.data![index] = convertTrait;
                      });
                    }
                  }
                }
              });
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      color: Colors.amber[100],
                      child: Column(
                        children: [
                          Container(
                            color: Colors.red[900],
                            width: double.infinity,
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${snapshot.data![index].name}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                                '${snapshot.data![index].imageUrl}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${snapshot.data![index].description}',
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}
