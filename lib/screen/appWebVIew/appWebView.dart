import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:newsApp/modal/articleListResponse.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class PopUpMenueList {
  final String title;
  final Widget widget;

  PopUpMenueList(this.title, this.widget);
}

class AppWebView extends StatefulWidget {
  final Article article;
  AppWebView({Key key, this.article}) : super(key: key);

  @override
  _AppWebViewState createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  InAppWebViewController webView;
  String url = null;
  double progress = 0;

  List<PopUpMenueList> popUpMenuList = [
    new PopUpMenueList(
        "Share",
        Icon(
          Icons.share,
          color: Colors.grey,
        )),
    new PopUpMenueList(
        "Open in Web Browser", Icon(Icons.web, color: Colors.grey))
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
      webView.goBack();
    } else {
      throw 'Could not launch $url';
    }
  }

  void _select(PopUpMenueList popUpMenueList) {
    switch (popUpMenueList.title) {
      case 'Share':
        Share.share(widget.article.url, subject: widget.article.title);
        break;
      case 'Open in Web Browser':
        _launchInBrowser(widget.article.url);
        break;
    }
    print(popUpMenueList.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.article.title),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return popUpMenuList.map((PopUpMenueList choice) {
                return PopupMenuItem(
                    value: choice,
                    child: Row(
                      children: <Widget>[
                        choice.widget,
                        SizedBox(width: 14),
                        Text(choice.title),
                      ],
                    ));
              }).toList();
            },
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // WebView(
            //   initialUrl: widget.article.url,
            // ),
            InAppWebView(
//               initialData: InAppWebViewInitialData(
//                 data: '''<!DOCTYPE html>
// <html>
// <body>
// <h1>Display a Telephone Input Field</h1>
// <a href="tel:+18475555555">Click Here To Call Support 1-847-555-5555</a>
// <form action="/action_page.php">
//   <label for="phone">Enter a phone number:</label><br><br>
//   <input type="tel" id="phone" name="phone" placeholder="123-45-678" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}" required><br><br>
//   <small>Format: 123-45-678</small><br><br>
//   <input type="submit">
// </form>
// </body>
// </html>
// ''',
//               ),
              onLoadError: (InAppWebViewController controller, String url,
                  int code, String message) async {},
              initialUrl: widget.article.url,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
              )),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                print("URL$url");
                if (url.startsWith("tel:") ||
                    url.startsWith("mailto:") ||
                    url.startsWith("maps:") ||
                    url.startsWith("geo:") ||
                    url.startsWith("sms:")) {
                  _launchInBrowser(url);
                  print("LOAD MAORMOR");
                  // webView.stopLoading();
                  // webView.goBack();
                  // webView.goBack();
                  // webView.goBack();

                }
                setState(() {
                  this.url = url;
                });
              },
              onLoadStop:
                  (InAppWebViewController controller, String url) async {
                setState(() {
                  this.url = url;
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
            progress != 100 / 100
                ? Center(child: CircularProgressIndicator())
                : Text("")
          ],
        ),
      ),
    );
  }
}
