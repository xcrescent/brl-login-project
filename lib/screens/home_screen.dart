import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_proj/screens/fragments/home_fragment.dart';
import 'package:login_proj/screens/fragments/profile_fragment.dart';
import 'package:login_proj/screens/fragments/support_fragment.dart';
import 'package:login_proj/utils/const.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<Homescreen> {
  int pageIndex = 0;
  static const List<Widget> pages = [
    HomeFragment(),
    ProfileFragment(),
    SupportFragment(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
      if (!(firebaseAuth.currentUser!.emailVerified)) {
        firebaseAuth.currentUser!.reload();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // final NotificationController notificationController = NotificationController();
    // notificationController.setupNotification();
  }

  @override
  Widget build(BuildContext context) {
    
    // Object todo = (ModalRoute.of(context)!.settings.arguments) ?? [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 10),
          child: Row(children: [
            RichText(text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Howdy, What are You\n Looking For?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  )
                ),
                TextSpan(
                  text: '🤪',
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
                ]
                ),),
          ],) 
        ),
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                'Greetings!!',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              setState(() {
                pageIndex = 1;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Support'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              setState(() {
                pageIndex = 2;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Close Drawer'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ]),
      ),
      body: Center(
        child: pages.elementAt(pageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          // selectedItemColor: Colors.white,
          // unselectedItemColor: Colors.grey,
          currentIndex: pageIndex,
          onTap: _onItemTapped,
          // backgroundColor: footerColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(Icons.support_outlined), label: "Support"),
          ]),
    );
  }
}
