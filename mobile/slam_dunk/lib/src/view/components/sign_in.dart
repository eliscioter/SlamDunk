import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slam_dunk/src/provider/user_provider.dart';
import 'package:slam_dunk/src/provider/user_status_provider.dart';
import 'package:slam_dunk/src/controller/sign_in_controller.dart';
import 'package:slam_dunk/src/view/register.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  TextEditingController name = TextEditingController(),
      password = TextEditingController();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
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
              controller: name,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                icon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              obscureText: !showPassword,
              controller: password,
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
                .signIn(name.text, password.text)
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
