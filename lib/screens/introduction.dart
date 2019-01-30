import 'package:CUValles/screens/app.dart';
import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission/permission.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introduction extends StatefulWidget {
  @override
  IntroductionState createState() => IntroductionState();

}

class IntroductionState extends State<Introduction> {
  bool locationGranted = false, cameraGranted = false;

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      [
        pageModel(
          color: PRIMARY_COLOR,
          title: 'Bienvenido',
          image: 'assets/images/logo.png',
          body: Text('Antes de empezar necesita saber algunas cosas de la aplicación. Dezliza para continuar...')
        ),
        pageModel(
          color: Colors.indigo,
          icon: Icon(
            Icons.info,
            color: Colors.pink,
          ),
          title: 'Información',
          image: 'assets/images/logo.png',
          body: Text('Noticias, mensajes generales, acceso a moodle.')
        ),
        pageModel(
          color: Colors.teal,
          icon: Icon(
            Icons.place,
            color: Colors.red,
          ),
          title: 'Ubicación',
          image: 'assets/images/introduction/map.png',
          body: Column(
            children: <Widget>[
              Text(
                'Mapa e información de los lugares de interés del centro.\n Se requiere permiso para acceso a la ubicación',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10,),
                child: button(
                  child: (!locationGranted) ? Text("Conceder accesso") : Text("Acceso concedido"),
                  onPressed: (!locationGranted) ? grantLocation : null
                ),              
              ),
              
            ],
          ),
        ),
        pageModel(
          color: Colors.red,
          icon: Icon(
            MdiIcons.qrcode,
            color: Colors.indigo,
          ),
          title: 'Checador iOS',
          image: 'assets/images/logo.png',
          body: Column(
            children: <Widget>[
              Text(
                'Registre su entrada y salida del iOS Development Lab con el lector de códigos QR.\n'+
                'Se requiere permiso para acceso a la cámara',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10,),
                child: button(
                  child: (!cameraGranted) ? Text("Conceder accesso") : Text("Acceso concedido"),
                  onPressed: (!cameraGranted) ? grantCamera : null
                ),              
              ),
            ],
          ),
        ),
      ],
      onTapDoneButton: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("first_open", false).then(print);

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

  void grantLocation() {
    Permission.requestSinglePermission(PermissionName.Location).then((response) {
      locationGranted = response == PermissionStatus.allow;
      setState(() {});
    });
  }

  void grantCamera() {
    Permission.requestSinglePermission(PermissionName.Camera).then((response) {
      cameraGranted = response == PermissionStatus.allow;
      setState(() {});
    });
  }

  PageViewModel pageModel ({color, body, title, image, icon}) {
    return PageViewModel(
        pageColor: color,
        body: body,
        title: Text(title),
        textStyle: TextStyle(color: Colors.white),
        bubble: icon,
        mainImage: Image.asset(
          image,
          height: 250,
          width: 250.0,
          alignment: Alignment.center,
        )
    );
  }

  MaterialButton button({child, onPressed}) => MaterialButton(
    color: Colors.black12,
    textColor: Colors.white,
    child: child,
    onPressed: onPressed,
  );

}