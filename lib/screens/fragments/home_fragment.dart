import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: const [
          SizedBox(
            height: 60,
          ),
          Text("Home"),
        ],
      ),
    );
  }
}
