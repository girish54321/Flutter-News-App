import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsApp/animasions/rightToLeft.dart';
import 'package:newsApp/modal/articleListResponse.dart';
import 'package:newsApp/networking/api.dart';
import 'package:newsApp/screen/fullArticle/fullArticle.dart';
import 'package:newsApp/widgets/articalHederImage.dart';
import 'package:newsApp/widgets/articleListItem.dart';
import 'package:http/http.dart' as http;
import 'package:newsApp/widgets/lodingScreen.dart';
import 'package:page_transition/page_transition.dart';

class ArticleList extends StatefulWidget {
  final String category;

  const ArticleList({Key key, this.category}) : super(key: key);
  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  bool _loading = true;
  // ScrollController _scrollController = ScrollController();
  ArticlesList articlesList;

  @override
  void initState() {
    super.initState();
    getNewsList();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     getMoreNewList();
    //   }
    // });
  }

  getMoreNewList() async {
    int listSize = 0;
    if (articlesList != null) {
      listSize = articlesList.articles.length;
    }
    print("LOAD MORW0$listSize");
    try {
      http.Response response =
          await Network().getArticles(widget.category, listSize);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        print(response.body);
        ArticlesList articlesList2 = new ArticlesList.fromJson(resBody);
        setState(() {
          _loading = false;
          articlesList.articles.addAll(articlesList2.articles);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  getNewsList() async {
    int listSize = 0;
    if (articlesList != null) {
      listSize = articlesList.articles.length;
    }
    try {
      http.Response response =
          await Network().getArticles(widget.category, listSize);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        articlesList = new ArticlesList.fromJson(resBody);
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  gotoNewsView(Article article) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: FullArticle(article: article)));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
        body: _loading
            ? LoadingScreen()
            : CustomScrollView(
                // controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: RightToLeft(
                        child: Container(
                          height: 160.0,
                          margin: EdgeInsets.only(bottom: 8),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _loading ? 3 : 3,
                            itemBuilder: (context, index) {
                              Article article = articlesList.articles[index];
                              return ArticalHeaderImage(
                                width: size.width * 0.8,
                                imageUrl: article.urlToImage,
                                title: article.title,
                                gotoNewsView: () {
                                  gotoNewsView(article);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Article article = articlesList.articles[index];
                          return ArticleListItem(
                            title: article.title,
                            date: article.publishedAt,
                            imageUrl: article.urlToImage,
                            gotoNewsView: () {
                              gotoNewsView(article);
                            },
                            showShado: false,
                          );
                        },
                        childCount: _loading ? 3 : articlesList.articles.length,
                      ),
                    ),
                  ]));
  }
}
