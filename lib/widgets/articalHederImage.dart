import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArticalHeaderImage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Function gotoNewsView;
  final double width;
  const ArticalHeaderImage(
      {Key key,
      @required this.title,
      @required this.imageUrl,
      this.gotoNewsView,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        gotoNewsView();
      },
      child: Container(
        width: width,
        margin: EdgeInsets.only(left: 12, top: 4),
        child: Stack(
          children: [
            Card(
              elevation: 0,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        width: width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageProvider,
                          ),
                          borderRadius: BorderRadius.circular(4.00),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        width: width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/placeholder.png'),
                          ),
                          borderRadius: BorderRadius.circular(4.00),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : Center(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/no_image.png')),
                          borderRadius: BorderRadius.circular(4.00),
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: 1,
              child: Container(
                width: 266.00,
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: "Nexa Bold",
                    fontSize: 18,
                    color: imageUrl != null ? Color(0xffffffff) : Colors.black,
                    shadows: [
                      Shadow(
                        offset: Offset(0.00, 3.00),
                        color: Color(0xff000000).withOpacity(0.16),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
