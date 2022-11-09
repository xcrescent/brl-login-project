import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login_proj/controllers/notification_controller.dart';
import 'package:login_proj/screens/fragments/home_fragment.dart';
import 'package:login_proj/screens/fragments/profile_fragment.dart';
import 'package:login_proj/screens/fragments/support_fragment.dart';
import 'package:login_proj/utils/const.dart';

class Homescreen extends StatefulWidget {
  Homescreen({
    super.key, 
    // required this.themeX
    });
  // void themeX;
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
    final NotificationController notificationController =
        NotificationController();
    notificationController.setupNotification();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // Object todo = (ModalRoute.of(context)!.settings.arguments) ?? [];
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.1,
                    blurRadius: 0.1,
                    offset: const Offset(0, 1),
                  )
                ]),
            child: IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.grey,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ),
        title: Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(
            top: 5,
            left: 20,
            // right: 15,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(
              width: 20,
            ),
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.1,
                        blurRadius: 0.1,
                        offset: const Offset(0, 1),
                      )
                    ]),
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    // SchedulerBinding.instance.addPostFrameCallback((_) {
                    //   widget.themeX;
                    // });
                    // toggle
                  },
                  child: const Icon(
                    Icons.mode_night_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
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
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: pages.elementAt(pageIndex),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: pageIndex,
          onTap: _onItemTapped,
          // backgroundColor: footerColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_max_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
              activeIcon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.support_outlined),
              label: "Support",
              activeIcon: Icon(Icons.support_sharp),
            ),
          ]),
    );
  }
}
