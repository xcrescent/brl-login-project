import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_proj/controllers/auth_controller.dart';
import 'package:login_proj/utils/const.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragment();
}

class _ProfileFragment extends State<ProfileFragment> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: users.doc(uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      data['userImage'] != ''
                          ? CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.blue,
                              backgroundImage:
                                  NetworkImage('${data['userImage']}'))
                          : const CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.blue,
                              backgroundImage:
                                  AssetImage('assets/images/OIP.jpg'),
                              // NetworkImage('file://assets/images/google.png',),
                            ),
                      // Image.network("", height: 200,width: 200,),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Name: ${data['fname']}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Username: ${data['username']}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Email: ${data['email']}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                );
                // Text("Full Name: ${data['full_name']} ${data['last_name']}");
              }
              return const Text("loading");
            },
          ),
          firebaseAuth.currentUser!.emailVerified
              ? const Text('')
              : InkWell(
                  child: const Text(
                    "Verify Email",
                    style: TextStyle(fontSize: 28, color: Colors.blue),
                  ),
                  onTap: () async {
                    await firebaseAuth.currentUser!.reload();
                    if (!(firebaseAuth.currentUser!.emailVerified)) {
                      await firebaseAuth.currentUser!
                          .sendEmailVerification()
                          .then((value) =>
                              showSnackBarr("Verification Email Sent", context))
                          .catchError((e) {
                        return showSnackBarr(e.toString(), context);
                      });
                    } else {
                      setState(() {});
                      if (!mounted) return;
                      return showSnackBarr("Already Verified", context);
                      
                    }
                  },
                ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await _authController.authSignOut().then((_) {
                  Navigator.pushReplacementNamed(context, "/login");
                });
                // });
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }
}
