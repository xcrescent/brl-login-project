import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_proj/controllers/auth_controller.dart';

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
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                  height: 180,
                ),
                Image.network("${data['userImage']}"),
                const SizedBox(height: 20,),
                Text("Name: ${data['fname']}"),
                const SizedBox(height: 20,),
                Text("Username: ${data['username']}"),
                const SizedBox(height: 20,),
                Text("Email: ${data['email']}"),
                const SizedBox(height: 20,),
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
          // Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }
        return const Text("loading");
      },
    );
  }
}
