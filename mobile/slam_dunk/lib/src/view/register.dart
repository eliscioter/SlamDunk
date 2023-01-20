import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slam_dunk/src/app.dart';
import 'package:slam_dunk/src/controller/register_controller.dart';
import 'package:slam_dunk/src/controller/sign_in_controller.dart';
import 'package:slam_dunk/src/provider/user_provider.dart';
import 'package:slam_dunk/src/provider/user_status_provider.dart';
import 'package:slam_dunk/src/style/colors.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  bool _showPassword = false, _showPasswordConfirm = false;
  TextEditingController email = TextEditingController(),
      name = TextEditingController(),
      password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Color(AppColor().backgroundColor),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SlamDunk(),
                ),
              );
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/homepage_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        icon: Icon(
                          Icons.account_box_outlined,
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: name),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(
                        Icons.mail_outlined,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: email,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: const Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: !_showPassword,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      icon: const Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPasswordConfirm
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPasswordConfirm = !_showPasswordConfirm;
                          });
                        },
                      ),
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: !_showPasswordConfirm,
                    controller: password,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[900], // Background color
                      ),
                      onPressed: () async {
                        Map<String, String> userInfo = {
                          'username': name.text,
                          'email': email.text,
                          'password': password.text,
                          'role': 'MEMBER'
                        };
                        if (await RegisterController().signUp(userInfo)) {
                          ref
                              .read(userController.notifier)
                              .signIn(name.text, password.text)
                              .then((val) {
                            ref
                                .read(userProvider.notifier)
                                .setUserInfo(val.username, val.role);

                            ref
                                .read(isSignedInProvider.notifier)
                                .isSignedIn(true);
                          });
                          Fluttertoast.showToast(
                              msg: "Registered successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SlamDunk(),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: "Register error.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
