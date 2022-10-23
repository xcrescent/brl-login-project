import 'package:flutter/material.dart';
import 'package:login_proj/controllers/auth_controller.dart';
import 'package:login_proj/screens/home_screen.dart';
import 'package:login_proj/utils/colors.dart';

import '../widgets/custom_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class Credentials {
//   final String email;
//   final String password;

//   const Credentials(this.email, this.password);
// }

class SignUpActivity extends StatefulWidget {
  const SignUpActivity({super.key});

  @override
  State<SignUpActivity> createState() => _SignUpActivity();
}

class _SignUpActivity extends State<SignUpActivity>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _fnameController = TextEditingController();
  final _unameController = TextEditingController();
  final _passController = TextEditingController();
  final _cpassController = TextEditingController();
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

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _emailController.addListener(_printLatestValue);
    _passController.addListener(_printLatestValue);

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

  void _printLatestValue() {
    if (_emailController.text == "") {
      // _emailController.
    } else if (_passController.text == "") {
      // _showErrorDialog("Invalid Password Value");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Sign Up"),
          ),
          elevation: 0,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Stack(
                    children: const [
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage('profilePic'),
                      ),
                      Positioned(
                          right: 5, bottom: 10, child: Icon(Icons.add_a_photo)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                        ),
                      ),
                      labelText: 'Enter full name',
                    ),
                    controller: _fnameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                        ),
                      ),
                      labelText: 'Enter your username',
                    ),
                    controller: _unameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                        ),
                      ),
                      labelText: 'Enter email address',
                    ),
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                        ),
                      ),
                      labelText: 'Enter password',
                    ),
                    controller: _passController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 88, vertical: 16),
                  // child:
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: buttonColor,
                      )),
                      labelText: 'Re-enter password',
                    ),
                    controller: _cpassController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width -40,
                  //   height: 50,
                  //   child: const Center(
                  //     child: Text(
                  //     'Register',
                  //     style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 24,
                  //     ),),),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_emailController.text != '' &&
                          _passController.text != ''&& _fnameController.text !='' &&
                          _unameController.text!='' && _passController.text == _cpassController.text) {
                        await _authController.authCreateWithEmailAndPassword(
                          _emailController.text,
                          _passController.text,
                          _fnameController.text,
                          _unameController.text,
                        ).then((_) {
                          // print("object");
                          Navigator.of(context).pushReplacementNamed("/home");
                        });

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const Homescreen(),
                        //       settings: RouteSettings(
                        //         arguments: [
                        //           _emailController.text,
                        //           _passController.text
                        //         ],
                        //       ),
                        //     ))
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          30,
                        ))),
                    child: const Text("Signup",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(
                      fontSize: 24,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    text: "Login",
                  ),
                ]))));
  }
}
