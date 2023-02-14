import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slam_dunk/src/model/thread_model.dart';
import 'package:slam_dunk/src/provider/forum_comments_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:slam_dunk/src/controller/forum_thread.dart';
import 'package:slam_dunk/src/provider/forum_provider.dart';
import 'package:slam_dunk/src/provider/user_provider.dart';
import 'package:slam_dunk/src/style/colors.dart';

class ForumThread extends ConsumerStatefulWidget {
  const ForumThread({super.key});

  @override
  ConsumerState<ForumThread> createState() => _ForumThreadState();
}

class _ForumThreadState extends ConsumerState<ForumThread> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController _comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forumId = ref.watch(forumIdProvider);
    final userInfo = ref.watch(userProvider);
    final forumComments = ref.watch(forumCommentsProvider);

    isMod() => userInfo[1] == 'MODERATOR';

    directionToDelete() {
      return isMod() ? DismissDirection.endToStart : DismissDirection.none;
    }

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
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.orange.shade600.withOpacity(0.8),
                    child: Text(
                      '${forumId[1]}',
                      textAlign: TextAlign.center,
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
                          controller: _comment,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            onPressed: () {
                              if (_comment.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Oops! you must have forgot to add your comment.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                              FetchForumThread()
                                  .onComment(
                                      userInfo[0], _comment.text, forumId[0])
                                  .then((_) {
                                // IO.Socket socket = IO.io('http://localhost:5003');
                                IO.Socket socket = IO.io('https://slamdunkforum.onrender.com');
                                Map<String, Object> newComment = {
                                  "body": {
                                    "author": userInfo[0],
                                    "content": _comment.text
                                  },
                                  "withDeleted": false
                                };
                                socket.emit('thread', {forumId[0], newComment});
                                ref
                                    .read(forumCommentsProvider.notifier)
                                    .setForumComments([
                                  ...forumComments,
                                  Body.fromJson(newComment)
                                ]);
                                _comment.text = '';
                              }).catchError((err) {
                                Fluttertoast.showToast(
                                    msg: "$err",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              });
                            },
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
                            // IO.Socket socket = IO.io('http://localhost:5003');
                            IO.Socket socket = IO.io('https://slamdunkforum.onrender.com');
                            socket.emit('join-thread', forumId[0]);

                            socket.on('new-comment', (newComment) {
                              bool withDeleted = newComment['withDeleted'];
                              Body addComment;
                              if (withDeleted == true) {
                                addComment = Body.fromJson(newComment);
                              } else {
                                addComment = Body.fromJson(newComment["body"]);
                              }

                              if (mounted) {
                                setState(
                                    () => snapshot.data!.body?.add(addComment));
                              }
                            });

                            return ListView.builder(
                              itemCount: snapshot.data!.body!.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: Key(
                                      snapshot.data?.body![index]?.id! ?? ''),
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
                                  onDismissed: (direction) {
                                    FetchForumThread()
                                        .onDelete(
                                            forumId[0],
                                            snapshot.data?.body![index]?.id! ??
                                                '')
                                        .then((_) {
                                      // IO.Socket socket = IO.io('http://localhost:5003');
                                      IO.Socket socket = IO.io('https://slamdunkforum.onrender.com');
                                      List<Body?>? newComments = snapshot
                                          .data?.body!
                                          .where((element) =>
                                              element!.id !=
                                              snapshot.data?.body![index]?.id!)
                                          .toList();
                                      var newThread = {
                                        "body": newComments,
                                        "withDeleted": true
                                      };
                                      socket.emit(
                                          'thread', {forumId[0], newThread});
                                      ref
                                          .read(forumCommentsProvider.notifier)
                                          .setForumComments(newComments);
                                      Fluttertoast.showToast(
                                          msg: "Deleted comment",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      return;
                                    }).catchError((err) {
                                      Fluttertoast.showToast(
                                          msg: "$err",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      return;
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
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(top: 10),
                                    color:
                                        Colors.amber.shade100.withOpacity(0.8),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                '${snapshot.data?.body![index]?.author}'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              '${snapshot.data?.body![index]?.content}'),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
