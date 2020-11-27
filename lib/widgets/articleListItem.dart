import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsApp/animasions/rightToLeft.dart';
import 'package:shimmer/shimmer.dart';
import 'package:jiffy/jiffy.dart';

class ArticleListItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final String imageUrl;
  final bool showShado;
  final Function gotoNewsView;

  const ArticleListItem(
      {Key key,
      @required this.title,
      @required this.date,
      @required this.imageUrl,
      @required this.showShado,
      this.gotoNewsView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RightToLeft(
      child: InkWell(
        onTap: gotoNewsView,
        child: Card(
          elevation: 2,
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 11),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider),
                                borderRadius: BorderRadius.circular(2.00),
                              ),
                            ),
                        placeholder: (context, url) => LodingImage())
                    : LodingImage(),
                Container(
                  height: 100,
                  padding: EdgeInsets.only(left: 12),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 240,
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Nexa Book",
                            fontSize: 16,
                            color: Color(0xff0f0f0f),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(Jiffy(date).yMMMMd,
                            style: TextStyle(
                              fontFamily: "Nexa Book",
                              fontSize: 11,
                              color: Color(0xffc4c4c4),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LodingImage extends StatelessWidget {
  const LodingImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/placeholder.png')),
        borderRadius: BorderRadius.circular(2.00),
      ),
    );
  }
}

class ArticleListItemLoding extends StatefulWidget {
  @override
  _ArticleListItemLodingState createState() => _ArticleListItemLodingState();
}

class _ArticleListItemLodingState extends State<ArticleListItemLoding> {
  @override
  Widget build(BuildContext context) {
    return RightToLeft(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        child: ListTile(
          title: LoadingText(),
          subtitle: LoadingText(),
          leading: CachedNetworkImage(
            imageUrl: "http://via.placeholder.com/200x150",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
                borderRadius: BorderRadius.circular(8.00),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

class LoadingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          width: double.infinity,
          height: 6,
        ));
  }
}
