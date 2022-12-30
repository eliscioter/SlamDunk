import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slam_dunk/src/provider/user_provider.dart';
import 'package:slam_dunk/src/provider/user_status_provider.dart';
import 'package:slam_dunk/src/view/components/sign_in/controller/sign_in_controller.dart';
import 'package:slam_dunk/src/view/register/register.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  @override
  Widget build(BuildContext context) {
    late String name, password;

    closeDialogBox() async {
      await Future.delayed(const Duration(seconds: 2));
    }

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Sign in'),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
                icon: Icon(Icons.account_box_outlined),
              ),
              onChanged: (value) => name = value,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'No account?',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Register(),
              ),
            );
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[900], // Background color
          ),
          onPressed: () {
            ref
                .read(userController.notifier)
                .testMethod(name, password)
                .then((val) {
              ref.read(userProvider.notifier).setUserInfo(val.username);

              ref.read(isSignedInProvider.notifier).isSignedIn(true);
            });
            closeDialogBox().then((val) {
              CircularProgressIndicator;
              Navigator.of(context).pop();
            });
          },
          child: const Text('Sign in'),
        ),
      ],
    );
  }
}
