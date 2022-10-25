import 'package:flutter/material.dart';
import 'package:login_proj/controllers/auth_controller.dart';
import 'package:login_proj/utils/colors.dart';

class ForgotPassActivity extends StatefulWidget {
  const ForgotPassActivity({super.key});

  @override
  State<ForgotPassActivity> createState() => _ForgotPassActivity();
}

class _ForgotPassActivity extends State<ForgotPassActivity> {
  bool _isLoading = false;
  final AuthController _authController = AuthController();
  final _emailController = TextEditingController();

  forgotPassword() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authController.forgotPassword(_emailController.text);
    if (res != 'success') {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      return showSnackBarr(res, context);
    } else {
      if (!mounted) return;
      showSnackBarr(
          'Password Reset link has been sent to the email address', context);
      // return Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 130,
            ),
            const Text(
              "Forgot Password",
              style: TextStyle(fontSize: 28, color: Colors.blue),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonColor),
                ),
                labelText: 'Enter Email',
              ),
              controller: _emailController,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                forgotPassword();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
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
                  : const Text("Send Password Reset Link",
                      style: TextStyle(fontSize: 17)),
            ),
          ],
        ),
      ),
    );
  }
}
