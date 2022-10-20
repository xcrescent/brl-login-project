import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

class AccountActivity extends StatelessWidget {
  const AccountActivity({super.key});

  @override
  Widget build(BuildContext context) {
    var todo = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(title: const Text("Your Account Details")),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text("Email: ${todo[0]}"),
            Text("Password: ${todo[1]}"),
          ])),
    );
  }
}
