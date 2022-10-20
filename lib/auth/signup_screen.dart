import 'package:flutter/material.dart';
import 'package:login_proj/auth/accounts.dart';
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
  final _passController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Size> _heightAnimation;
  // late List<Credentials> cred;
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Error!!'),
              content: Text(message),
              actions: <Widget>[
                FloatingActionButton(onPressed: () {
                  Navigator.of(context).pop();
                })
              ],
            ));
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _emailController.addListener(_printLatestValue);
    _passController.addListener(_printLatestValue);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
    );
    _heightAnimation = Tween<Size>(
            begin: const Size(double.infinity, 260),
            end: const Size(double.infinity, 320))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
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
      // _showErrorDialog("Invalid Email Address");
    } else if (_passController.text == "") {
      // _showErrorDialog("Invalid Password Value");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 88, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter email address',
                  ),
                  controller: _emailController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 88, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter password',
                  ),
                  controller: _passController,
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () => {
                  if (_emailController.text != '' && _passController.text != '')
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountActivity(),
                            settings: RouteSettings(
                              arguments: [
                                _emailController.text,
                                _passController.text
                              ],
                            ),
                          ))
                    }
                  else
                    {
                      const AlertDialog(
                        title: Text("Empty"),
                      )
                    }
                },
                tooltip: "Login",
                label: const Text("Login"),
              ),
            ])));
  }
}
