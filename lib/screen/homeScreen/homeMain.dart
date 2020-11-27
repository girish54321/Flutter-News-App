import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/screen/articalList/articalList.dart';
import 'package:newsApp/widgets/drawerHeader.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
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
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
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
