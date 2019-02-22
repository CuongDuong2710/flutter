import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManagement {

  storeNewUser(user, context) {
    Firestore.instance
        .collection('/users')
        .add({'email': user.email, 'uid': user.uid}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }

  static bool isSignedIn() {
    bool isSignedIn = false;

    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      if (user != null)
        isSignedIn = true;
      else
        isSignedIn = false;
    });

    /*if (FirebaseAuth.instance.currentUser() != null)
      isSignedIn = true;
    else
      isSignedIn = false;*/

    return isSignedIn;
  }
}
