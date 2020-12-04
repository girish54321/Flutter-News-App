import 'package:flutter/material.dart';

Widget appBar(
  String title,
) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
      ),
    ),
  );
}
