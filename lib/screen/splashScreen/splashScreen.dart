import 'package:flutter/material.dart';
import 'package:newsApp/screen/auth/loginScreen/login.dart';
import 'package:newsApp/widgets/appButton.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Text(
            "NEWS APP",
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 51, color: Theme.of(context).accentColor),
          ),
        ),
        Positioned(
            left: 1,
            right: 1,
            bottom: 61,
            child: Column(
              children: [
                Text(
                  "Daily news updates\n in just 360 letters",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Center(
                  child: Container(
                    height: 45.33,
                    width: 195.19,
                    margin: EdgeInsets.only(top: 18),
                    child: AppButton(
                      buttonText: "Get Stated",
                      function: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: LoginScreen()));
                      },
                    ),
                  ),
                ),
              ],
            )),
      ],
    ));
  }
}
