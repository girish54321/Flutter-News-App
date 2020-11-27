import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/modal/user.dart';

class LoginStateProvider with ChangeNotifier {
  bool logedIn = false;
  var userData;
  AppUser user;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // CollectionReference favSong =
  //     FirebaseFirestore.instance.collection('favSong');
  // CollectionReference clientId =
  //     FirebaseFirestore.instance.collection('clientId');

  LoginStateProvider() {
    if (FirebaseAuth.instance.currentUser != null) {
      logedIn = true;
      notifyListeners();
      getUserData();
      print("LOG IN H");
    } else {
      print("NO LOAGIn");
      logedIn = false;
      notifyListeners();
    }
  }

  getUserData() async {
    DocumentSnapshot doc =
        await users.doc(FirebaseAuth.instance.currentUser.uid).get();
    user = AppUser.fromDocument(doc);
    print(user.userName);
    notifyListeners();
  }

  changeLoginState(bool state) {
    print("CHNECN USER");
    logedIn = state;
    print(state);
    LoginStateProvider();
    notifyListeners();
  }

  Future<void> addUser(userId, userName, email, imageUrl) {
    print("ADDING USER");
    print(userId);
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        logedIn = true;
        notifyListeners();
        return true;
      } else {
        users.doc(userId).set({
          'userName': userName,
          'email': email,
          "imageUrl": imageUrl,
          'user_id': userId,
        }).then((value) {
          logedIn = true;
          notifyListeners();
          print("Added");
          changeLoginState(true);
          return true;
        }).catchError((error) => print("Failed to add user: $error"));
      }
    });
  }
}
