import 'package:flutter/material.dart';
import 'package:login_proj/accounts.dart';

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

class _LoginActivity extends State<LoginActivity> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  // late List<Credentials> cred;
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    emailController.addListener(_printLatestValue);
    passController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    if (emailController.text == "") {
      const AlertDialog(
        title: Text("Email Not Valid"),
      );
    } else if (passController.text == "") {
      const AlertDialog(
        title: Text("Email Not Valid"),
      );
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
                  controller: emailController,
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
                  controller: passController,
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () => {
                  if (emailController.text != '' && passController.text != '')
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountActivity(),
                            settings: RouteSettings(
                              arguments: [
                                emailController.text,
                                passController.text
                              ],
                            ),
                          ))
                    } else {
                      const AlertDialog(title: Text("Empty"),)
                    }
                },
                tooltip: "Login",
                label: const Text("Login"),
              ),
            ])));
  }
}
