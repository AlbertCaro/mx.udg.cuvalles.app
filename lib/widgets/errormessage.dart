import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  ErrorMessage({this.title, this.message, this.buttonText, this.icon, this.onPressed});

  final String title, message, buttonText;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black54,
            size: 160,
          ),
          Padding(padding: EdgeInsets.only(top: 16.0),),
          Text(title,
            style: TextStyle(
            fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.only(top: 8.0),),
          Text(message),
          Padding(padding: EdgeInsets.only(top: 8.0),),
          MaterialButton(
            child: Text(buttonText),
            textColor: ACCENT_COLOR,
            onPressed: onPressed,
          )
        ]
      ),
    );
  }

}