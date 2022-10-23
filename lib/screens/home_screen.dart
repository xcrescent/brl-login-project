import 'package:flutter/material.dart';
import 'package:login_proj/controllers/notification_controller.dart';
import 'package:login_proj/screens/fragments/home_fragment.dart';
import 'package:login_proj/screens/fragments/profile_fragment.dart';
import 'package:login_proj/screens/fragments/support_fragment.dart';

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
    });
  }
  
  @override
  void initState() {
    super.initState();
    final NotificationController notificationController = NotificationController();
    notificationController.setupNotification();
  }


  @override
  Widget build(BuildContext context) {
    
    // Object todo = (ModalRoute.of(context)!.settings.arguments) ?? [];
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          "Authenticated",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home",),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.support_outlined), label: "Support"),
      ]),
      
    );
  }
}
