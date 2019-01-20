import 'package:app/screens/app.dart';
import 'package:app/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Introduction extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      [
        pageModel(
          color: PRIMARY_COLOR,
          icon: Icon(
            MdiIcons.qrcode,
            color: ACCENT_COLOR,
          ),
          title: 'Prueba',
          image: 'assets/images/logo.png',
          text: 'afsfagdsagdsagadsg'
        ),
        pageModel(
          color: ACCENT_COLOR,
          icon: Icon(
            Icons.place,
            color: Colors.red,
          ),
          title: 'Prueba2',
          image: 'assets/images/logo.png',
          text: 'afsfagdsagdsagadsgAGSDADSG'
        ),
      ],
      onTapDoneButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => App(),
          ),
        );
      },
      doneText: Text('HECHO'),
      showSkipButton: false,
      pageButtonTextStyles: TextStyle(
        color: Colors.white,
          fontSize: 18.0,
        ),
    );
  }

  PageViewModel pageModel ({color, text, title, image, icon}) {
    return PageViewModel(
        pageColor: color,
        body: Text(text),
        title: Text(title),
        textStyle: TextStyle(color: Colors.white),
        bubble: icon,
        mainImage: Image.asset(
          image,
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )
    );
  }

}