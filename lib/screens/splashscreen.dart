import 'package:CUValles/screens/app.dart';
import 'package:CUValles/screens/introduction.dart';
import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> {
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  bool firstOpen = true;

  @override
  void initState() {
    super.initState();
    preferences.then((preferences) {
      setState(() { firstOpen = (preferences.getBool("first_open") ?? true); });
    });
  }

  @override
  Widget build(BuildContext context) {

    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: (firstOpen) ? Introduction() : App(),
      image: Image.asset('assets/images/logo.png'),
      photoSize: 150,
      backgroundColor: PRIMARY_COLOR,
      loaderColor: ACCENT_COLOR,
      title: Text(''),
      styleTextUnderTheLoader: TextStyle(
        fontSize: 0,
      ),
    );
  }
}