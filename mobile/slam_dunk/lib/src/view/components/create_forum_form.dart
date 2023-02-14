import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slam_dunk/src/model/forum_model.dart';
import 'package:slam_dunk/src/provider/forum_data.dart';
import 'package:slam_dunk/src/provider/new_forum.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:slam_dunk/src/controller/forum_controller.dart';
import 'package:slam_dunk/src/provider/forum_provider.dart';
import 'package:slam_dunk/src/provider/user_provider.dart';
import 'package:slam_dunk/src/view/thread.dart';

class ForumForm extends ConsumerStatefulWidget {
  const ForumForm({super.key});

  @override
  ConsumerState<ForumForm> createState() => _ForumFormState();
}

class _ForumFormState extends ConsumerState<ForumForm> {
  TextEditingController title = TextEditingController(),
      content = TextEditingController();
  final FocusNode focusNode = FocusNode(), focusNode2 = FocusNode();
  late int maxLines;

  checkFocus() {
    if (focusNode2.hasFocus) {
      return maxLines = 5;
    }
    return 1;
  }

  Future<List?> forumDetails(Map<String, dynamic> form) async {
    List? forum = await FetchForums().onCreateForum(form);
    ref
        .read(forumIdProvider.notifier)
        .setForumId('${forum![0]}', '${forum[1]}');

    return forum;
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userProvider);
    final forum = ref.watch(forumsDataProvider);
    final newForumId = ref.watch(newForumIdProvider);

    Future<bool> sendForum() async {
      Map<String, dynamic> form = {
        "title": title.text,
        "primary_author": userInfo[0],
        "body": [
          {
            "author": userInfo[0],
            "content": content.text,
          }
        ]
      };
      List<dynamic>? forumRes = await forumDetails(form);

      if (forumRes == null) {
        Fluttertoast.showToast(
            msg: "Error.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }

      // IO.Socket socket = IO.io('http://localhost:5003');
      IO.Socket socket = IO.io('https://slamdunkforum.onrender.com');
      socket.emit('forum', {form, forumRes[0], false});
      final dateTime = DateTime.now().toIso8601String();

      ref.read(forumsDataProvider.notifier).setForum([
        ...?forum,
        Forums.fromJson(
            {...form, '_id': newForumId, 'createdAt': dateTime, 'updatedAt': dateTime})
      ]);
      return true;
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Create forum'),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.close),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              controller: title,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextField(
                focusNode: focusNode2,
                cursorColor: Colors.orange,
                style: const TextStyle(color: Colors.black),
                maxLines: checkFocus(),
                decoration: const InputDecoration(
                  labelText: "Comment",
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                controller: content,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[900], // Background color
            ),
            onPressed: () async {
              if (await sendForum() == false) return;

              // TODO: investigate why try and catch has the same code
              try {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForumThread(),
                  ),
                );
                Fluttertoast.showToast(
                    msg: "Sucessfully created.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } catch (e) {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForumThread(),
                  ),
                );
                Fluttertoast.showToast(
                    msg: "Sucessfully created.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
