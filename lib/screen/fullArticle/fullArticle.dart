import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:newsApp/modal/articleListResponse.dart';
import 'package:newsApp/screen/appWebVIew/appWebView.dart';
import 'package:page_transition/page_transition.dart';

class FullArticle extends StatefulWidget {
  final Article article;
  FullArticle({Key key, this.article}) : super(key: key);

  @override
  _FullArticleState createState() => _FullArticleState();
}

class _FullArticleState extends State<FullArticle> {
  gotowebView(Article article) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: AppWebView(
              article: article,
            )));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // ignore: unused_local_variable
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    // ignore: unused_local_variable
    final double itemWidth = size.width / 2;
    return Scaffold(
        body: ExpandableBottomSheet(
      persistentContentHeight: 330,
      background: CachedNetworkImage(
        imageUrl: widget.article.urlToImage,
        imageBuilder: (context, imageProvider) => Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Container(
              //   height: 80,
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.topLeft,
              //         end: Alignment.topRight,
              //         colors: [
              //           Theme.of(context).accentColor,
              //           Color(0xFFFF2D55),
              //           Colors.white
              //         ]),
              //   ),
              // ),
              SafeArea(
                child: ListTile(
                  title: Text(
                    "NEWS360",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Bebas Neue",
                      fontSize: 24,
                      color: Color(0xffffffff),
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      FluentIcons.arrow_left_24_regular,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      FluentIcons.bookmark_24_regular,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      expandableContent: Container(
        // height: 300,
        child: Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.00),
              topRight: Radius.circular(15.00),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20.00,
                width: 73.00,
                decoration: BoxDecoration(
                  color: Color(0xffffe558),
                  borderRadius: BorderRadius.circular(15.00),
                ),
                child: Center(
                  child: Text(
                    "SPORTS",
                    style: TextStyle(
                      fontFamily: "Nexa Book",
                      fontSize: 11,
                      color: Color(0xff434040),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 14),
                child: Text(
                  widget.article.title,
                  style: TextStyle(
                    fontFamily: "Nexa Bold",
                    fontSize: 20,
                    color: Color(0xff1f0b0b),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 14),
                child: Text(
                  widget.article.description,
                  style: TextStyle(
                    height: 1.7,
                    fontFamily: "Nexa Book",
                    fontSize: 16,
                    color: Color(0xff3c3c3c),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(1.0),
                title: Text(
                  Jiffy(widget.article.publishedAt).yMMMMd,
                  style: TextStyle(
                    fontFamily: "Nexa Book",
                    fontSize: 12,
                    color: Color(0xff626262).withOpacity(0.45),
                  ),
                ),
                trailing: FlatButton.icon(
                    onPressed: () {
                      gotowebView(widget.article);
                    },
                    icon: Icon(
                      FluentIcons.globe_24_regular,
                      color: Theme.of(context).accentColor,
                    ),
                    label: Text("Open In Web")),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    ));
  }
}
