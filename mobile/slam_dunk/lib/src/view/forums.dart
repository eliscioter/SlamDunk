import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slam_dunk/src/model/forum_model.dart';
import 'package:slam_dunk/src/provider/forum_provider.dart';
import 'package:slam_dunk/src/provider/user_provider.dart';
import 'package:slam_dunk/src/provider/user_status_provider.dart';
import 'package:slam_dunk/src/view/components/create_forum_form.dart';
import 'package:slam_dunk/src/view/thread.dart';
import 'package:slam_dunk/src/controller/forum_controller.dart';

class Forum extends ConsumerWidget {
  const Forum({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSignedIn = ref.watch(isSignedInProvider);
    final userInfo = ref.watch(userProvider);

    isMod() => userInfo[1] == '[MODERATOR]';

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
                                  Fluttertoast.showToast(
                                      msg: "Deleted ${snapshot.data![index].title}",
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
                                      builder: (context) => Thread(),
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
