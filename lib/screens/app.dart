import 'package:app/models/place.dart';
import 'package:app/screens/preferences.dart';
import 'package:app/tabs/map.dart';
import 'package:app/tabs/moodle.dart';
import 'package:app/tabs/places.dart';
import 'package:app/tabs/qr.dart';
import 'package:app/values/constants.dart';
import 'package:app/tabs/home.dart';
import 'package:app/tabs/messages.dart';
import 'package:app/tabs/web.dart';
import 'package:app/values/functions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission/permission.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: PRIMARY_COLOR
      ),
      home: HomePage(title: APP_TITLE),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool locationStatus = false;
  Position position;
  
  List<Widget> tabs;

  List<String> titles = [
    "Inicio",
    "Valles Web",
    "Moodle",
    "Mensajes",
    "Mapa",
    "Lugares",
    "Checador"
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      HomeTab(),
      WebTab(),
      MoodleTab(),
      MessagesTab(),
      MapTab(),
      PlacesTab(this.locationStatus, this.position),
      QRTab()
    ];

    checkPermissions();
  }

  void checkPermissions() {
    Geolocator().checkGeolocationPermissionStatus()
      .then((status) => status == GeolocationStatus.granted)
      .then((result) {
        if (result) {
          print(result);
          this.locationStatus = result;
          getPosition();
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) => 
                AlertDialog(
                  title: Text('Se requieren permisos'),
                  content: Text(
                    'Se necesita acceso a su ubicación, para ' +
                    'calcular con los lugares de interés del ' +
                    'centro, y a la cámara para utilizar el ' +
                    'lector del checador del iOS Development Lab.'
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      child: Text('ACEPTAR'),
                      onPressed: () {
                        requestLocationPermission();
                        Navigator.of(context).pop();
                      },
                      textColor: ACCENT_COLOR,
                    )
                  ],
                )
            );
        }
      });
  }

  Future requestLocationPermission() => Permission.requestSinglePermission(PermissionName.Location)
    .then((status) => status == PermissionStatus.allow)
    .then((result) {
      locationStatus = result;
      getPosition();
      Permission.requestSinglePermission(PermissionName.Camera);
    });

  void getPosition() {
    Geolocator().getPositionStream(
      LocationOptions(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10
      )
    ).listen((position) {
      print('Entró 3');
      this.position = position;
      tabs[5] = PlacesTab(this.locationStatus, this.position);
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getAppBar(
        titles[index],
        popupOption
      ),
      body: tabs[index],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                APP_TITLE,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                ),
              ),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR
              ),
            ),
            item(Icons.home, 0, context),
            item(MdiIcons.web, 1, context),
            item(Icons.school, 2, context),
            item(Icons.message,3, context),
            item(Icons.map, 4, context),
            item(Icons.place, 5, context),
            item(MdiIcons.qrcode, 6, context)
          ],
        ),
      ),
    );
  }

  ListTile item (icon, number, context) => ListTile(
    leading: Icon(icon),
    title: Text(titles[number]),
    onTap: () { 
      setState(() {
        index = number;
      });
      Navigator.pop(context);
    },
    selected: (index == number) ? true : false,
  );

  void popupOption (option) {
    if (option == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Preferences()
        )
      );
    }
  }
}
