import 'package:flutter/material.dart';

class ListTileText extends StatelessWidget {
  final String text;

  const ListTileText({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontFamily: "Nexa Bold",
          fontSize: 15,
          color: Color(0xff20255a),
        ));
  }
}
