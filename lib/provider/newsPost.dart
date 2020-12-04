import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/modal/FavSongeMobileData.dart';

class NewsPost with ChangeNotifier {
  List<AppNewsPost> appNewsPost = [];
  CollectionReference appPost =
      FirebaseFirestore.instance.collection('app_post');
  NewsPost() {
    updateProviderData();
  }

  void updateList() {
    appNewsPost.clear();
    updateProviderData();
  }

  void clearList() {
    appNewsPost = [];
    notifyListeners();
  }

  Future<void> updateProviderData() async {
    QuerySnapshot snapshot = await appPost.get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      AppNewsPost allPostData = new AppNewsPost(
        snapshot.docs[i]['title'],
        snapshot.docs[i]['subtitle'],
        snapshot.docs[i]['web_url'],
      );
      appNewsPost.add(allPostData);
      notifyListeners();
    }
  }
}
