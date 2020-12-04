import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/helper/helper.dart';
import 'package:newsApp/provider/loginState.dart';
import 'package:newsApp/widgets/appBar.dart';
import 'package:newsApp/widgets/appButton.dart';
import 'package:newsApp/widgets/inputText.dart';
import 'package:provider/provider.dart';
import 'package:rules/rules.dart';
import 'package:http/http.dart' as http;
import 'package:newsApp/widgets/articleListItem.dart';

class AddNewPost extends StatefulWidget {
  @override
  _AddNewPostState createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final webUrlController = TextEditingController();
  final imageUrlController = TextEditingController();

  CollectionReference appPost =
      FirebaseFirestore.instance.collection('app_post');
  CollectionReference tokenRef =
      FirebaseFirestore.instance.collection('tokenRef');

  Future<void> addNewPost() async {
    var now = new DateTime.now();
    return appPost.add({
      'title': titleController.text.trim(),
      'subtitle': subTitleController.text.trim(),
      "web_url": webUrlController.text.trim(),
      "image_Url": imageUrlController.text.trim(),
      "date": now
    }).then((value) async {
      List<String> tokenList = [];
      QuerySnapshot snapshot = await tokenRef.get();
      for (int i = 0; i < snapshot.docs.length; i++) {
        tokenList.add(snapshot.docs[i]['token']);
      }
      sendNotificationToallUser(tokenList);
    }).catchError((error) =>
        Helper().showSnackBar("Failed To add new Post", error, context, true));
  }

  sendNotificationToallUser(tokenList) async {
    String url = "https://fcm.googleapis.com/fcm/send";
    Map<String, dynamic> match = {
      "registration_ids": tokenList,
      "android": {"priority": "high"},
      "data": {
        "body": subTitleController.text.trim(),
        "title": titleController.text.trim(),
        "image_url": imageUrlController.text.trim(),
        "link": webUrlController.text.trim(),
      },
      "priority": "high"
    };
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAkI2sL00:APA91bFsj6gevvxlMpLJnXWfVmpdDX07LqKXnOAQX-TKUp8QdBmYukT-TrnIdSRdp6WFY6WnbGGOfCdRK2kw1e3xuNRMopgyZH6owJd3mHra-ht2orr8EfUPwiQ1ptdCBB5aX1YVufWa"
    };

    http.post(url, body: jsonEncode(match), headers: headers).then((response) {
      print(response.statusCode.toString());
      print(response.body.toString());
      if (response.statusCode == 200) {
        titleController.clear();
        subTitleController.clear();
        webUrlController.clear();
        imageUrlController.clear();
        setState(() {});
      } else {
        Helper().showSnackBar(response.body.toString(),
            response.statusCode.toString(), context, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: appBar("ADD NEW POST"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 22,
                ),
                ArticleListItem(
                  date: null,
                  imageUrl: imageUrlController.text,
                  showShado: true,
                  title: titleController.text,
                  animasion: false,
                ),
                InputText(
                    changeFous: (String text) {
                      setState(() {});
                    },
                    password: false,
                    hint: "Title",
                    textEditingController: titleController,
                    validator: (email) {
                      final emailRule = Rule(
                        email,
                        name: 'Title',
                        isRequired: true,
                      );
                      if (emailRule.hasError) {
                        return emailRule.error;
                      } else {
                        return null;
                      }
                    }),
                InputText(
                    changeFous: (String text) {
                      setState(() {});
                    },
                    password: false,
                    hint: "SubTitle",
                    textEditingController: subTitleController,
                    validator: (subTitle) {
                      final subTitleRule = Rule(
                        subTitle,
                        name: 'SubTitle',
                        isRequired: true,
                      );
                      if (subTitleRule.hasError) {
                        return subTitleRule.error;
                      } else {
                        return null;
                      }
                    }),
                InputText(
                    changeFous: (String text) {
                      setState(() {});
                    },
                    rightIcon: IconButton(
                      icon: Icon(
                        FluentIcons.dismiss_20_regular,
                      ),
                      onPressed: () {
                        imageUrlController.clear();
                      },
                    ),
                    password: false,
                    hint: "Image Url",
                    textEditingController: imageUrlController,
                    validator: (url) {
                      final iamge = Rule(url,
                          name: 'Image Url', isRequired: true, isUrl: true);
                      if (iamge.hasError) {
                        return iamge.error;
                      } else {
                        return null;
                      }
                    }),
                InputText(
                    changeFous: (String text) {
                      setState(() {});
                    },
                    password: false,
                    hint: "Web URL",
                    rightIcon: IconButton(
                      icon: Icon(
                        FluentIcons.dismiss_20_regular,
                      ),
                      onPressed: () {
                        webUrlController.clear();
                      },
                    ),
                    textEditingController: webUrlController,
                    validator: (url) {
                      final urlRule = Rule(url,
                          name: 'Web URL', isRequired: true, isUrl: true);
                      if (urlRule.hasError) {
                        return urlRule.error;
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 18,
                ),
                Consumer<LoginStateProvider>(
                  builder: (context, loginStateProvider, child) {
                    return Center(
                      child: Container(
                        height: 45.33,
                        width: 195.19,
                        child: AppButton(
                          buttonText: "Add new Post",
                          function: () {
                            if (_formKey.currentState.validate()) {
                              addNewPost();
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
