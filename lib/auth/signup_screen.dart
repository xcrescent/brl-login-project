import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_proj/controllers/auth_controller.dart';
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
  bool _isLoading = false;
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

  Uint8List? _image;
  selectImage() async {
    Uint8List im = await AuthController().pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authController.signUpUser(
        _emailController.text,
        _passController.text,
        _cpassController.text,
        _fnameController.text,
        _unameController.text,
        _image);

    if (res != 'success') {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      return showSnackBarr(res, context);

      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute<void>(
      //       builder: (BuildContext context) =>
      //           const Homescreen(),
      //     ));
      // }
      // });
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
    } else {
      if (!mounted) return;
      showSnackBarr(
          'Congratulations account has been created for you', context);
      return Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  // void _printLatestValue() {
  //   if (_emailController.text == "") {
  //     // _emailController.
  //   } else if (_passController.text == "") {
  //     // _showErrorDialog("Invalid Password Value");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Center(
        //     child: Text("Sign Up"),
        //   ),
        //   elevation: 0,
        // ),
        body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Stack(
                    children: <Widget>[
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.black,
                              backgroundImage: MemoryImage(_image!))
                          : const CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  AssetImage('assets/images/OIP.jpg'),
                              // NetworkImage(
                              //   'https://picsum.photos/250?image=9',
                              // ),
                              // NetworkImage('file://assets/images/google.png',),
                            ),
                      Positioned(
                        right: 5,
                        bottom: 10,
                        child: InkWell(
                          onTap: selectImage,
                          child: Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
 cursorColor: buttonColor,
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
                      labelStyle: TextStyle(color: buttonColor),
                      labelText: 'Enter full name',
                      prefixIcon: Icon(
                          Icons.person,
                          color: buttonColor,
                        )
                    ),
                    controller: _fnameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
 cursorColor: buttonColor,
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
                      labelStyle: TextStyle(color: buttonColor),
                      labelText: 'Enter your username',
                      prefixIcon: Icon(
                          Icons.person,
                          color: buttonColor,
                        )
                    ),
                    controller: _unameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
 cursorColor: buttonColor,
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
                      labelStyle: TextStyle(color: buttonColor),
                      labelText: 'Enter email address',
                      prefixIcon: Icon(
                          Icons.email,
                          color: buttonColor,
                        ),
                    ),
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
 cursorColor: buttonColor,
                    obscureText: true,
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
                      labelStyle: TextStyle(color: buttonColor),
                      labelText: 'Enter password',
                      prefixIcon: Icon(
                          Icons.lock,
                          color: buttonColor,
                        ),
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
 cursorColor: buttonColor,
                    obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: buttonColor,
                        
                      )),
                      labelStyle: TextStyle(color: buttonColor),
                      labelText: 'Re-enter password',
                      prefixIcon: Icon(
                          Icons.lock,
                          
                          color: buttonColor,
                        )
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
                    onPressed: () {
                      if (!(_authController
                          .validateEmail(_emailController.text))) {
                        showSnackBarr("Email not valid", context);
                      } else {
                        signUpUser();
                        // _fnameController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: buttonColor,
                    ),
                    
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Signup",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: 18
                                ),
                            ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Already have an Account?",
                          style: TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                        ),
                      ]),
                ]))));
  }
}
