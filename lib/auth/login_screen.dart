import 'package:flutter/material.dart';
import 'package:login_proj/controllers/auth_controller.dart';
import 'package:login_proj/screens/home_screen.dart';
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
      //     .then((_) {

      //   Navigator.of(context).pushReplacementNamed('/home');
      //   // Navigator.of(context).pushReplacementNamed('/home');
      //   // MaterialPageRoute(
      //   //   builder: (context) => const Homescreen(),
      //   //   settings: RouteSettings(
      //   //     arguments: [
      //   //       _emailController.text,
      //   //       _passController.text
      //   //     ],
      //   // ),
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
                  labelStyle: TextStyle(
                    color: buttonColor
                  ),
                  
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
                    : const Text("Login", style: TextStyle(fontSize: 18)),
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
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Need an Account?",
                      style: TextStyle(
                        fontSize: 17,
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
                        "Sign Up",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                onPressed: () async {
                  _authController.signinWithGoogle().then((_) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Homescreen(),
                        ));
                  });
                },
                // foregroundColor: null,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/google.png'),
                // shape:
              )
            ],
          )
          // ]),
          ),
    )
        // },
        // ),
        );
  }
}
