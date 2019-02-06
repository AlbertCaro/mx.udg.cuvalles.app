import 'package:CUValles/components/drawerheader.dart';
import 'package:CUValles/models/preference.dart';
import 'package:CUValles/models/user.dart';
import 'package:CUValles/tabs/map.dart';
import 'package:CUValles/tabs/messages.dart';
import 'package:CUValles/tabs/moodle.dart';
import 'package:CUValles/tabs/news.dart';
import 'package:CUValles/tabs/web.dart';
import 'package:CUValles/screens/login.dart';
import 'package:CUValles/screens/preferences.dart';
import 'package:CUValles/tabs/places.dart';
import 'package:CUValles/tabs/qr.dart';
import 'package:CUValles/values/constants.dart';
import 'package:CUValles/widgets/listtitle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission/permission.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class App extends StatefulWidget {
  App({Key key, this.preference, this.user}) : super(key: key);
  Preference preference;
  User user;

  @override
  AppState createState() => AppState();

}

class AppState extends State<App> {
  final GlobalKey newsKey = GlobalKey<NewsState>();
  final GlobalKey placesKey = GlobalKey<PlacesState>();
  final GlobalKey messagesKey = GlobalKey<MessagesState>();

  final FirebaseMessaging messaging = FirebaseMessaging();
  bool locationStatus = false;
  Position position;
  SearchBar searchBar;
  set setSearchBar(bar) => searchBar = bar; 
  
  List<Widget> tabs;

  List<String> titles = [
    "Noticias",
    "Valles Web",
    "Moodle",
    "Mensajes",
    "Mapa",
    "Lugares",
    "iOS Development Lab",
    "CELex"
  ];

  int index = 0;

  AppState() {
    tabs = [
      NewsTab(key: newsKey,),
      WebTab(),
      MoodleTab(),
      MessagesTab(key: messagesKey,),
      MapTab(),
      PlacesTab(placesKey, this.locationStatus, this.position),
      QRTab(),
      Center()
    ];

    searchBar = SearchBar(
      inBar: false,
      setState: setState,
      onChanged: filterList,
      onSubmitted: filterList,
      onClosed: onCloseSearch,
      hintText: "Buscar...",
      buildDefaultAppBar: buildAppBar
    );
  }

  @override
  void initState() {
    super.initState();

    checkPermissions();

    messaging.requestNotificationPermissions();
    messaging.subscribeToTopic('informe');
    messaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print(message['notification']);
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    messaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    messaging.getToken().then((token) {
      print("token: "+token);
    });
  }

  void filterList(String value) {
    if (index == 0) {
      NewsState state = (newsKey.currentState as NewsState);
      state.showedList = state.news.where(
        (_new) => _new.title.toLowerCase().contains(value.toLowerCase())
      ).toList();
      state.setState(() {});
    } else if (index == 3) {
      MessagesState state = (messagesKey.currentState as MessagesState);
      state.showedList = state.messages.where(
        (message) => message.subject.toLowerCase().contains(value.toLowerCase()) ||
                     message.content.toLowerCase().contains(value.toLowerCase())
      ).toList();
      state.setState(() {});
    } else if (index == 5) {
      print(value);
      PlacesState state = (placesKey.currentState as PlacesState);
      state.showedList = state.places.where(
        (place) => place.name.toLowerCase().contains(value.toLowerCase())
      ).toList();

      print("List: "+state.showedList.toString());
      state.refreshList();
    }
  }

  void onCloseSearch() {
    if (index == 0) {
      NewsState state = (newsKey.currentState as NewsState);
      state.showedList = state.news;
      state.setState(() {});
    } else if (index == 3) {
      MessagesState state = (messagesKey.currentState as MessagesState);
      state.showedList = state.messages;
      state.setState(() {});
    } else if (index == 5) {
      PlacesState state = (placesKey.currentState as PlacesState);
      state.showedList = state.places;
      state.refreshList();
    }
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
                  'Se detectó que no se proporcionaron algunos permisos. Se solicitarán de nuevo.'
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
      this.position = position;
      tabs[5] = PlacesTab(placesKey, this.locationStatus, this.position);
      setState(() {});
    });
  }

  Widget badge = Icon(
    Icons.brightness_1,
    size: 12.0,
    color: Colors.red,
  );

  AppBar buildAppBar (BuildContext context) {
    return AppBar(
        title: Text(titles[index]),
        actions: <Widget>[
          (index == 0 || index == 5 || index == 3) ? searchBar.getSearchAction(context) : Container(),
          PopupMenuButton(
            onSelected: popupOption,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text('Preferencias'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Cerrar sesión'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Login'),
                value: 2,
              )
            ]
          ),
        ],
      );
  }

  bool userDetailOpened = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: searchBar.build(context),
      body: tabs[index],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Header(
              onDetailPressed: () {
                setState(() {
                  userDetailOpened = !userDetailOpened;
                });
              },
              user: widget.user,
            ),
            userDetailOpened ?
            Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(MdiIcons.login),
                  title: Text("Iniciar sesión"),
                  onTap: () { 
                  },
                )
              ],
            )
            : drawerMenu(context)
          ],
        ),
      ),
    );
  }

  ListTile item (icon, number, context) => ListTile(
    leading: icon,
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
          builder: (context) => Preferences(
            preference: widget.preference,
          )
        )
      );
    } else if (option == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => App()
        )
      );
      Navigator.pop(context);
    } else if (option == 2) {
      Navigator.push( 
        context,
        MaterialPageRoute(
          builder: (context) => Login()
        )
      );
    }
  }


  Widget drawerMenu(context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      item(Icon(MdiIcons.newspaper), 0, context),
      item(Icon(MdiIcons.web), 1, context),
      ListTile(
        leading: Icon(Icons.school),
        title: Text('Moodle'),
        onTap: () { 
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MoodleTab()
            )
          );
        }
      ),
      //item(Icon(Icons.school), 2, context),
      item(Stack(
        children: <Widget>[
          Icon(Icons.message),
          Positioned(
            top: -1.0,
            right: -1.0,
            child: Stack(
              children: <Widget>[
                badge
              ],
            )
          )
        ],
      ), 3, context),
      item(Icon(Icons.map), 4, context),
      item(Icon(Icons.place), 5, context),
      Divider(),
      ListTitle(
        text: "Checadores",
        color: Colors.black54,
      ),
      item(Icon(MdiIcons.languageSwift), 6, context),
      item(Icon(MdiIcons.translate), 7, context),
    ],
  );
}