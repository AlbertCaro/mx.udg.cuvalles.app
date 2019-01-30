import 'package:flutter/material.dart';

class ListTitle extends StatelessWidget {
  ListTitle({this.text, this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}