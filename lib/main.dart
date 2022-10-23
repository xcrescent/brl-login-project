import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login_proj/auth/signup_screen.dart';
import 'package:login_proj/controllers/auth_controller.dart';
import 'package:login_proj/screens/home_screen.dart';
import 'auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Future<void>  main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Project',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const Homescreen(),
        '/signup': (BuildContext context) => const SignUpActivity(),
        '/login': (BuildContext context) => const LoginActivity(),
      },
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: backgroundColor,
      // ),
      home: StreamBuilder(
          stream: AuthController().authChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed('/home');
              });
            }
            return const MyHomePage(title: 'BRL Login Project');
          }),
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
  // final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 44, vertical: 22),
                child: Image.asset('assets/images/brl_logo.png'),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: buttonColor,
                      minimumSize: const Size(double.maxFinite, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("/login");
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const LoginActivity())),
                    },
                    child: const Text(
                      "Login",
                    )),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 30,
              //   ),
              //   child: CustomButton(
              //       text: "Register",
              //       onPressed: () => {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) =>
              //                         const SignUpActivity())),
              //           }),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 30,
              //   ),
              //   child: CustomButton(
              //       text: "Google Sign In",
              //       onPressed: () async {
              //         await _authController.signinWithGoogle().then((){
              //           Navigator.of(
              //             context).pushReplacementNamed('/home');
              //         });

              // if(!(await _authController.authChanges.isEmpty)){
              //   await
              // }
              //       }),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
