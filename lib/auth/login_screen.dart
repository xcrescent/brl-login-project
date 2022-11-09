import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_proj/controllers/auth_controller.dart';
import 'package:login_proj/utils/colors.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Credentials {
//   final String email;
//   final String password;

//   const Credentials(this.email, this.password);
// }

class LoginActivity extends StatefulWidget {
  const LoginActivity({super.key});

  @override
  State<LoginActivity> createState() => _LoginActivity();
}

class _LoginActivity extends State<LoginActivity>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final AuthController _authController = AuthController();
  // late AnimationController _animationController;
  // late Animation<Size> _heightAnimation;
  // late List<Credentials> cred;
  // void _showErrorDialog(String message) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: const Text('Error!!'),
  //             content: Text(message),
  //             actions: <Widget>[
  //               FloatingActionButton(onPressed: () {
  //                 Navigator.of(context).pop();
  //               })
  //             ],
  //           ));
  // }

  bool activeConnection = false;
  String T = "";
  Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          activeConnection = true;
          // T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        activeConnection = false;
        T = "Turn On the data and repress again";
      });
    }
  }

  loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authController.loginUsers(
        _emailController.text, _passController.text);
    if (res != 'success') {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      return showSnackBarr(res, context);
    } else {
      if (!mounted) return;
      showSnackBarr(
          'Congratulations you have been successfully signed in..', context);
      return Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserConnection();
    // Start listening to changes.
    // _emailController.addListener(_printLatestValue);
    // _passController.addListener(_printLatestValue);
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(microseconds: 300),
    // );
    // _heightAnimation = Tween<Size>(
    //         begin: const Size(double.infinity, 260),
    //         end: const Size(double.infinity, 320))
    //     .animate(CurvedAnimation(
    //         parent: _animationController, curve: Curves.linear));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  // void _printLatestValue() {
  //   if (_authController.validateEmail(_emailController.text)) {
  //     showSnackBarr("valid", context);
  //     //     // _showErrorDialog("Invalid Email Address");
  //   } else {
  //     //     // _showErrorDialog("Invalid Password Value");
  //     showSnackBarr("content", context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Center(child:Text("Login")),),
        body:
            // StreamBuilder(
            //   stream: AuthController().authChanges,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     if (snapshot.hasData) {
            //       return const Homescreen();
            //     }
            //     return
            Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 88, vertical: 16),
              //   child:
              TextFormField(
                cursorColor: buttonColor,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Enter email address',
                  labelStyle: TextStyle(color: buttonColor),
                  prefixIcon: Icon(
                    Icons.email,
                    color: buttonColor,
                  ),
                ),
                controller: _emailController,
              ),
              const SizedBox(
                height: 25,
              ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
              //   child:
              TextFormField(
                obscureText: true,
                cursorColor: buttonColor,
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Enter password',
                  labelStyle: TextStyle(color: buttonColor),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: buttonColor,
                  ),
                ),
                controller: _passController,
              ),
              // ),
              const SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () {
                  loginUsers();
                  // } else {
                  //   const AlertDialog(
                  //     title: Text("Empty"),
                  //   );
                  // }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                      30,
                    ))),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text("Login", style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/forgotPass');
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "New User?",
                      style: TextStyle(
                        fontSize: 19,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/signup');
                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 40,
              ),
              FloatingActionButton(
                onPressed: () async {
                  signInWithGoogle();
                },
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/google.png'),
                // shape:
              ),
              const SizedBox(
                height: 100,
              ),
              Text(T),
              const Divider(),
            ],
          )
          // ]),
          ),
    )
        // },
        // ),
        );
  }

  signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authController.signinWithGoogle();
    if (res != 'success') {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      return showSnackBarr('Could not log you in!!\n Try again .....', context);
    } else {
      if (!mounted) return;
      showSnackBarr(
          'Congratulations you have been successfully signed in..', context);
      return Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
