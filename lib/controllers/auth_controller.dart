import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_proj/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  Stream<User?> get authChanges => firebaseAuth.authStateChanges();

  // add image to storage
  _uploadImageToStorage(Uint8List? image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePic')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // pick image
  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print("No image selected");
    }
  }

  forgotPassword(String email) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty) {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        res = 'success';
      } else {
        res = 'Email field must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  validatePassword(String pass) {
    // ^ represents starting character of the string.
// (?=.*[0-9]) represents a digit must occur at least once.
// (?=.*[a-z]) represents a lower case alphabet must occur at least once.
// (?=.*[A-Z]) represents an upper case alphabet that must occur at least once.
// (?=.*[@#$%^&-+=()] represents a special character that must occur at least once.
// (?=\\S+$) white spaces don’t allowed in the entire string.
// .{8, 20} represents at least 8 characters and at most 20 characters.
// $ represents the end of the string.
    bool passValid =
        RegExp(r"^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&-+=()]).{8,20}$")
            .hasMatch(pass);
    if (!(passValid)) {
      return "Must have at least one lowercase, one uppercase , one number, one special character and length at least 8";
    }

    return "strong";
  }

  validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  signinWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          //store user details in firestore
          firebaseFirestore.collection('users').doc(user.uid).set({
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

  Future<String> signUpUser(String email, String pass, String cpass,
      String fname, String username, Uint8List? image) async {
    String res = 'Some error occured';
    try {
      if (fname.isNotEmpty &&
          username.isNotEmpty &&
          pass.isNotEmpty &&
          email.isNotEmpty) {
        if (pass == cpass) {
          if (validatePassword(pass) == 'strong') {
            UserCredential userCredential =
                await firebaseAuth.createUserWithEmailAndPassword(
              email: email,
              password: pass,
            );
            String downloadUrl;
            if (image != null) {
              downloadUrl = await _uploadImageToStorage(image);
            } else {
              downloadUrl = '';
            }
            // User? user = userCredential.user;
            await userCredential.user!.sendEmailVerification();
            if (userCredential.additionalUserInfo!.isNewUser) {
              //store user details in firestore
              firebaseFirestore
                  .collection('users')
                  .doc(userCredential.user!.uid)
                  .set({
                'fname': fname,
                'username': username,
                'uid': userCredential.user!.uid,
                'email': email,
                'userImage': downloadUrl,
              });
            }
            res = 'success';
          } else {
            res = validatePassword(pass);
          }
        } else {
          res = 'Enter same password in both fields';
        }
      } else {
        res = 'Fields must not be empty';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      }
    } catch (e) {
      res = e.toString();
    }
    // print(res);
    return res;
  }

  loginUsers(String email, String pass) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty && pass.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);
        res = 'success';
      } else {
        res = 'Fields must not be empty';
      }

      // print("Signed in");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        res = 'Incorrect password';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
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

showSnackBarr(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
