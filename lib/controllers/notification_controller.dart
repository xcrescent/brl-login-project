import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // Stream<User?> get authChanges => _auth.authStateChanges();
  setupNotification() async {
    try {
    final fcmToken = await FirebaseMessaging.instance.getToken();
      _firebaseFirestore.collection('notification').doc(uid).set({
        'fcmToken': fcmToken,
      });
    }
    catch (e) {
      
    } 
  }
}
