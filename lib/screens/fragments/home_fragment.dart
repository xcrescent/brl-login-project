import 'dart:math';

import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
          Container(
            alignment: Alignment.center,
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
            padding: const EdgeInsets.only(
              top: 20,
              left: 50,
              right: 15,
            ),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'Howdy, What are You\n Looking For?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                      text: '🤪',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ]),
                ),
              ]),
              const SizedBox(
                height: 60,
              ),
              const CircleAvatar(
                radius: 64,
                backgroundColor: Colors.blue,
                backgroundImage: AssetImage('assets/images/utkarshsingh.jpeg'),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "I am a Second year Undergraduate student pursuing Bachelors of Technology Degree in Computer Science and Engineering. I love solving problems and coming up with creative solutions, further reinforcing my knowledge of Data Structures and Algorithms. I am skilled in Kotlin, JavaScript, C, and Python along with that I am also into Freelance Full Stack Software Development whether it's Android or Web.",
                  style: TextStyle(
                    fontSize: 23.0,
                    fontFamily: 'Dancing',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Hexagon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width, size.height * sqrt(3) / 4);
    path.lineTo(size.width * 0.75, size.height * sqrt(3) / 2);
    path.lineTo(size.width * 0.25, size.height * sqrt(3) / 2);
    path.lineTo(0, size.height * sqrt(3) / 4);
    path.lineTo(size.width * 0.25, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
