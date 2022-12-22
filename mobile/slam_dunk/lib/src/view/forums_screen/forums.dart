import 'package:flutter/material.dart';
import 'package:slam_dunk/src/model/forum_model.dart';
import 'package:slam_dunk/src/view/forums_screen/controller/forum_controller.dart';

class Forum extends StatelessWidget {
  const Forum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: -500,
              child: Image.asset('assets/images/forum_bg.jpg'),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.red.shade900.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Forums>?>(
                    future: FetchForums().displayForums(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              margin: const EdgeInsets.only(top: 20.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      '${snapshot.data![index].title}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      snapshot.data![index].primaryAuthor
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      snapshot.data![index].createdAt
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
