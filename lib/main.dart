import 'package:CUValles/screens/splashscreen.dart';
import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    title: APP_TITLE,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      primaryColor: PRIMARY_COLOR,
      accentColor: ACCENT_COLOR,
      textSelectionColor: ACCENT_COLOR,
    ),
    home: Splash(),
  )
);

