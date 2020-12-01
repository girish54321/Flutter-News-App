import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/helper/helper.dart';
import 'package:newsApp/screen/articalList/articalList.dart';
import 'package:newsApp/screen/homeScreen/NotificationPlugin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:newsApp/widgets/drawerHeader.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:newsApp/modal/NotificationPayload.dart';
import 'dart:convert';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Tab> myTabs = <Tab>[
    Tab(child: ArticleList(category: 'technology')),
    Tab(child: ArticleList(category: 'business')),
    Tab(child: ArticleList(category: 'entertainment')),
    Tab(child: ArticleList(category: 'general')),
    Tab(child: ArticleList(category: 'health')),
    Tab(child: ArticleList(category: 'science')),
    Tab(child: ArticleList(category: 'sports')),
  ];

  @override
  void initState() {
    super.initState();
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
    _tabController = TabController(vsync: this, length: myTabs.length);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      print("message88888888888888888888888888888$message");
      if (message != null) {
        // print(message.data);
        Helper().showSnackBar("message", "title", context, false);
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: HomeMain()));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      // Helper().showSnackBar(
      //     "message 22222222222222", "title 22222222222", context, false);
      // print("NEW DATA 22");
      print(message.data.toString());

      NotificationPayload notificationPayload =
          new NotificationPayload.fromJson(message.data);
      await notificationPlugin.showNotification(
        notificationPayload,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Helper().showSnackBar("message 3", "title 3", context, false);
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: HomeMain()));
    });
    _firebaseMessaging.getToken().then((String token) {
      print(token);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(notificationPayload) {
    print("PAYLOAD");
    print(notificationPayload);
    final body = json.decode(notificationPayload);
    NotificationPayload data = new NotificationPayload.fromJson(body);
    Helper().showSnackBar(data.body, data.title, context, false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
            key: _scaffoldKey,
            drawer: DrawerHeaderView(),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  FluentIcons.line_horizontal_3_20_filled,
                  color: Colors.black,
                ),
                // onPressed: () => _scaffoldKey.currentState.openDrawer(),
                onPressed: () async {
                  // await notificationPlugin.showNotification();
                },
              ),
              centerTitle: true,
              title: Text(
                "NEWS360",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Bebas Neue",
                    fontSize: 24,
                    color: Theme.of(context).accentColor),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(
                    FluentIcons.alert_24_regular,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
              bottom: TabBar(
                // indicatorPadding: EdgeInsets.symmetric(vertical: 14.0),
                labelPadding: EdgeInsets.symmetric(horizontal: 14.0),
                // labelPadding: EdgeInsets.only(bottom: 14.0),
                isScrollable: true,
                labelStyle: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500),
                unselectedLabelStyle: TextStyle(
                  fontSize: 18,
                  color: Color(0xff000000).withOpacity(0.40),
                ),
                labelColor: Theme.of(context).accentColor,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 2.5,
                controller: _tabController,
                tabs: [
                  Container(
                      height: 40, child: Center(child: Text("Technology"))),
                  Container(height: 40, child: Center(child: Text("Business"))),
                  Container(
                      height: 40, child: Center(child: Text("Entertainment"))),
                  Container(height: 40, child: Center(child: Text("General"))),
                  Container(height: 40, child: Center(child: Text("Health"))),
                  Container(height: 40, child: Center(child: Text("Science"))),
                  Container(height: 40, child: Center(child: Text("Sports"))),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab) {
                return tab;
              }).toList(),
            )));
  }
}
