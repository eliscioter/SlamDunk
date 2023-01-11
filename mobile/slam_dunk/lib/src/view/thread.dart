import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slam_dunk/src/controller/forum_thread.dart';
import 'package:slam_dunk/src/model/forum_model.dart';
import 'package:slam_dunk/src/provider/forum_provider.dart';
import 'package:slam_dunk/src/style/colors.dart';

class Thread extends ConsumerWidget {
  final FocusNode focusNode = FocusNode();

  Thread({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forumId = ref.watch(forumIdProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thread'),
        backgroundColor: Color(AppColor().backgroundColor),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Haruko-Thread.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.orange.shade600.withOpacity(0.8),
                    child: Text(
                      '${forumId[1]}',
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.red.shade900.withOpacity(0.8),
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextField(
                          focusNode: focusNode,
                          cursorColor: Colors.orange,
                          style: const TextStyle(color: Colors.white),
                          maxLines: 1,
                          decoration: const InputDecoration(
                            labelText: "Comment",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            onPressed: () {},
                            child: const Text('Post'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.red.shade900.withOpacity(0.8),
                      child: FutureBuilder(
                        future: FetchForumThread().displayThread(forumId[0]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.body!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 10),
                                  color: Colors.amber.shade100.withOpacity(0.8),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                '${snapshot.data?.body![index]?.author}')),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '${snapshot.data?.body![index]?.content}'),
                                      )
                                    ],
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
