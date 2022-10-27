import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_proj/utils/colors.dart';
import 'package:path/path.dart';

class SupportFragment extends StatefulWidget {
  const SupportFragment({super.key});

  @override
  State<SupportFragment> createState() => _SupportFragment();
}

class _SupportFragment extends State<SupportFragment> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.only(top: 150),
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
            ),
              onPressed: () {
                CollectionReference queries =
                    FirebaseFirestore.instance.collection("query");
                queries.add({"query": _textController.text}).then((value) {
                  _textController.text = 'Sent';

                });
              },
              child: const Text("Send")),
        ],
      ),
    ),
    );
  }
}
