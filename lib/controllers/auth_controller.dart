import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_proj/controllers/notification_controller.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<User?> get authChanges => _auth.authStateChanges();

  signinWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          //store user details in firestore
          _firebaseFirestore.collection('users').doc(user.uid).set({
            'fname': user.displayName,
            'username': user.email,
            'uid': user.uid,
            'email': user.email,
            'userImage': user.photoURL,
          });
        }
      }
      
    } catch (e) {}
  }

  authCreateWithEmailAndPassword(email, pass, fname, username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      User? user = userCredential.user;
      await user?.sendEmailVerification();
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          //store user details in firestore
          _firebaseFirestore.collection('users').doc(user.uid).set({
            'fname': fname,
            'username': username,
            'uid': user.uid,
            'email': email,
            'userImage': null,
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  authSignInWithEmailAndPassword(email, pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      // print("Signed in");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  // git client secret 0a443c074eb2a80e4e060483b4695feeaabc533d

  authSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("Signed Out");
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      print(e.code);
      // } else if (e.code == 'wrong-password') {
      // print('Wrong password provided for that user.');
    }
  }
}
