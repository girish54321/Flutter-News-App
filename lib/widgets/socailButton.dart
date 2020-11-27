import 'package:flutter/material.dart';

class SosailButton extends StatelessWidget {
  final Widget icon;
  final Function function;
  const SosailButton({Key key, this.icon, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 50.00,
        width: 50.00,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).accentColor),
        child: Center(child: icon),
      ),
    );
  }
}
