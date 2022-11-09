import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_proj/utils/colors.dart';
import 'package:login_proj/utils/const.dart';
import 'package:path/path.dart';

class SupportFragment extends StatefulWidget {
  const SupportFragment({super.key});

  @override
  State<SupportFragment> createState() => _SupportFragment();
}

class _SupportFragment extends State<SupportFragment> {
  final TextEditingController _textController = TextEditingController();
  final uid = firebaseAuth.currentUser?.uid;
  final CollectionReference queries =
      firebaseFirestore.collection('query');
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column( 
      children: [ 
        FutureBuilder<DocumentSnapshot>(
            future: queries.doc(uid).get(),
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
                  decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.1,
              blurRadius: 0.1,
              offset: const Offset(0, 1),
            )]),
          
                  child: Text(
                        "Last Query: ${data['query']}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                );
              }
              return const CircularProgressIndicator();
            }),
             Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(30),
       decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
            // bottomLeft: Radius.elliptical(210, 210),
            // bottomRight: Radius.elliptical(110, 110),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.1,
              blurRadius: 0.1,
              offset: const Offset(0, 1),
            )
          ]),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          const Text(
            "Query: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            
            keyboardType: TextInputType.multiline,
            maxLines: null,
            
            decoration: const InputDecoration(
              
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: buttonColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: buttonColor,
                )
              ),
            ),
            cursorColor: buttonColor,
            controller: _textController,
            style: const TextStyle(
              decorationColor: buttonColor,
              color: buttonColor,
              
              
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),

            ),
              onPressed: () {
                CollectionReference queries =
                    FirebaseFirestore.instance.collection("query");
                queries.doc(uid).set({"query": _textController.text}).then((value) {
                  _textController.text = '';

                });
              },
              child: const Text("Send")),
        ],
      ),
    ),
    )],));
    }
    }
