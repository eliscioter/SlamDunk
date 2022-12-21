import 'package:flutter/material.dart';
import 'package:slam_dunk/src/model/traits/tricks.model.dart';
import 'package:slam_dunk/src/view/traits_screen/controller/traits_controller.dart';

class Tricks_Screen extends StatelessWidget {
  const Tricks_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Tricks>?>(
          future: FetchTraits().displayTricks(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
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
                            child: Image.network('${snapshot.data![index].imageUrl}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('${snapshot.data![index].description}', textAlign: TextAlign.center,),
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