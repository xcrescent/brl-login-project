import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          const SizedBox(
            height: 100,
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
            controller: _textController,
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
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
    );
  }
}
