import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slam_dunk/src/provider/forum_data.dart';
import 'package:slam_dunk/src/provider/new_forum.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:slam_dunk/src/model/forum_model.dart';
import 'package:slam_dunk/src/provider/forum_provider.dart';
import 'package:slam_dunk/src/provider/user_provider.dart';
import 'package:slam_dunk/src/provider/user_status_provider.dart';
import 'package:slam_dunk/src/view/components/create_forum_form.dart';
import 'package:slam_dunk/src/view/thread.dart';
import 'package:slam_dunk/src/controller/forum_controller.dart';

class Forum extends ConsumerStatefulWidget {
  const Forum({super.key});

  @override
  ConsumerState<Forum> createState() => _ForumState();
}

class _ForumState extends ConsumerState<Forum> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final isSignedIn = ref.watch(isSignedInProvider);
    final userInfo = ref.watch(userProvider);
    // final forum = ref.watch(forumsDataProvider);

    isMod() => userInfo[1] == 'MODERATOR';

    directionToDelete() {
      return isMod() ? DismissDirection.endToStart : DismissDirection.none;
    }

    return Scaffold(
      floatingActionButton: Visibility(
        visible: isSignedIn,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => const ForumForm());
          },
          backgroundColor: Colors.orange.withOpacity(0.8),
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
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
                        // IO.Socket socket = IO.io('http://localhost:5003');
                        IO.Socket socket = IO.io('https://slamdunkforum.onrender.com');
                        socket.on('receive-forum', (forum) {
                          List<dynamic> res = forum;
                          Map<String, dynamic> firstElement = res[0];
                          String id = res[1];
                          ref
                              .read(newForumIdProvider.notifier)
                              .setNewForumId(id);
                          final dateTime = DateTime.now().toIso8601String();
                          Forums addForum = Forums.fromJson({
                            ...firstElement,
                            '_id': id,
                            'createdAt': dateTime,
                            'updatedAt': dateTime
                          });
                          if (mounted) {
                            setState(() => snapshot.data!.add(addForum));
                          }
                          
                        });
                        socket.on('receive-new-forums', (forum) {
                          List<Forums> newForums =
                              forumsFromJson(jsonEncode(forum));
                          if (mounted) {
                            setState(() {
                              snapshot.data!.clear();
                              snapshot.data!.addAll(newForums);
                            });
                          }
                        });
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(snapshot.data![index].id!),
                              direction: directionToDelete(),
                              confirmDismiss: (direction) async {
                                if (isMod()) {
                                  final bool res = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm"),
                                          content: const Text(
                                              "Are you sure you want to delete this item?"),
                                          actions: [
                                            TextButton(
                                              child: const Text("Cancel"),
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                            ),
                                            TextButton(
                                              child: const Text("Delete"),
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                            ),
                                          ],
                                        );
                                      });
                                  return res;
                                } else {
                                  return false;
                                }
                              },
                              onDismissed: (direction) async {
                                await FetchForums()
                                    .onDeleteForum(snapshot.data![index].id!)
                                    .then((_) {
                                  // IO.Socket socket = IO.io('http://localhost:5003');
                                  IO.Socket socket = IO.io('https://slamdunkforum.onrender.com');
                                  socket.emit('forum', {
                                    snapshot.data,
                                    snapshot.data![index].id!,
                                    true
                                  });
                                  ref
                                      .read(forumsDataProvider.notifier)
                                      .setForum(snapshot.data);

                                  Fluttertoast.showToast(
                                      msg:
                                          "Deleted ${snapshot.data![index].title}",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }).catchError((err) {
                                  Fluttertoast.showToast(
                                      msg: "$err",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                });
                              },
                              background: Container(
                                color: Colors.red,
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (!isSignedIn) {
                                    Fluttertoast.showToast(
                                        msg: "You need to sign in first",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    return;
                                  }
                                  ref.read(forumIdProvider.notifier).setForumId(
                                      '${snapshot.data![index].id}',
                                      '${snapshot.data![index].title}');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const ForumThread(),
                                    ),
                                  );
                                },
                                child: Container(
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
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          snapshot.data![index].primaryAuthor
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          snapshot.data![index].createdAt
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          reverse: true,
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
