import 'package:flutter/material.dart';
import './login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Login Project'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 88, vertical: 60),
              child: Text(
                'Click the button to Login:',
              ),
            ),
            FloatingActionButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginActivity())),
              },
              tooltip: 'Login',
              child: const Icon(Icons.login),
            ),
          ],
        ),
      ),
    );
  }
}
