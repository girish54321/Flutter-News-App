import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/modal/NotificationPayload.dart';
import 'package:newsApp/screen/appWebVIew/appWebView.dart';
import 'package:newsApp/widgets/articleListItem.dart';
import 'package:newsApp/widgets/lodingScreen.dart';
import 'package:page_transition/page_transition.dart';

class AppNewsList extends StatefulWidget {
  @override
  _AppNewsListState createState() => _AppNewsListState();
}

class _AppNewsListState extends State<AppNewsList> {
  CollectionReference appPost =
      FirebaseFirestore.instance.collection('app_post');

  gotoNewsView(
    body,
    imageUrl,
    link,
    title,
  ) {
    var symbole = """
      { "body":"$body",
  "title":"$title",
   "imageUrl":"$imageUrl",
    "link":"$link"}""";

    final stringData = json.decode(symbole);

    NotificationPayload data = new NotificationPayload.fromJson(stringData);
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: AppWebView(
              notificationPayload: data,
            )));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: appPost
            .orderBy('date', descending: true)
            .snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data.docs[index];
              Timestamp time = document.data()['date'];
              DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
              return ArticleListItem(
                animasion: true,
                title: document.data()['title'],
                date: time.toDate(),
                imageUrl: document.data()['image_Url'],
                gotoNewsView: () {
                  gotoNewsView(
                      document.data()['title'],
                      document.data()['image_Url'],
                      document.data()['web_url'],
                      document.data()['title']);
                },
                showShado: false,
              );
            },
          );
        },
      ),
    );
  }
}
