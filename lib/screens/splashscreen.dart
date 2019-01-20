import 'package:app/screens/app.dart';
import 'package:app/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> {
  
  @override
  Widget build(BuildContext context) {

    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: App(),
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