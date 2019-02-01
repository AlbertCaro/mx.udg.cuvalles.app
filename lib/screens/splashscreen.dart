import 'package:CUValles/models/preference.dart';
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
  Preference preference;
  bool firstOpen = true;

  SplashState() {
    Preference.getIstance().then((result) {
      preference = result;
    });

    preferences.then((preferences) {
      setState(() { firstOpen = (preferences.getBool("first_open") ?? true); });
    });
  }

  @override
  Widget build(BuildContext context) {

    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: (firstOpen) ? Introduction(
        preference: preference,
        ) : App(
        preference: preference,
      ),
      image: Image.asset(
        'assets/images/logo.png',
        width: MediaQuery.of(context).size.width/2-50,
      ),
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