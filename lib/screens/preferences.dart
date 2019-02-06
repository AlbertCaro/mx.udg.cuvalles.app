import 'package:CUValles/models/preference.dart';
import 'package:CUValles/values/constants.dart';
import 'package:CUValles/widgets/listtitle.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';

class Preferences extends StatefulWidget {
  Preferences({this.preference});
  final Preference preference;

  @override
  State<StatefulWidget> createState() => PreferencesState(preference);
}

class PreferencesState extends State<Preferences> {

  Preference preference;
  PackageInfo packageInfo;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceModel = "", 
         osVersion = "",
         appName = "",
         appVersion = "",
         buildNumber = "",
         appPackage = "";
  int taps = 1;

  PreferencesState(this.preference) {
    getPreferences();
  }

  void getPreferences() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      deviceModel = info.manufacturer+ " " +info.model;
      osVersion = "Android "+info.version.release+" API "+info.version.sdkInt.toString();
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      deviceModel = info.utsname.machine;
      osVersion = info.systemVersion;
    }
    
    packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    appPackage = packageInfo.packageName;

    setState(() { });
  }

  void changePush (bool value) => setState(() { preference.push = value; });

  void changeSync (bool value) {
    if (!value) changeMobileNetwork(value);
    setState(() { preference.synchronization = value; });
  }

  void changeMobileNetwork (bool value) => setState(() { preference.syncUsesMobileNetwork = value; });

  void changeMobileNetworkButton () => changeMobileNetwork(!preference.syncUsesMobileNetwork);

  void changePushButton () => changePush(!preference.push);

  void changeSyncButton () => changeSync(!preference.synchronization);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferencias"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              ListTitle(
                text: "Mensajería",
                color: ACCENT_COLOR,
              ),
              ItemList(
                title: "Notificaciones push",
                description: "Recibir notificaciones de mensajes y tareas",
                action: Switch(
                  value: preference.push,
                  onChanged: changePush,
                ),
                divider: false,
                onTap: changePushButton,
              ),
              ListTitle(
                text: "Sincronización",
                color: ACCENT_COLOR,
              ),
              ItemList(
                first: true,
                title: "Sincronizar ahora",
                description: "Sincronización manual de tareas.",
                divider: true,
                onTap: () {},
              ),
              ItemList(
                title: "Sincronización automática",
                description: "Sincronizar tareas al calendario de manera automática",
                action: Switch(
                  value: preference.synchronization,
                  onChanged: changeSync,
                ),
                divider: true,
                onTap: changeSyncButton,
              ),
              ItemList(
                last: true,
                title: "Uso de la red móvil",
                description: "Permitir a la aplicación sincronizarse cuando esté conectado a redes móviles.",
                action: Switch(
                  value: preference.syncUsesMobileNetwork,
                  onChanged: preference.synchronization ? changeMobileNetwork : null,
                ),
                divider: false,
                disabled: !preference.synchronization,
                onTap: changeMobileNetworkButton,
              ),
              ListTitle(
                text: "Información",
                color: ACCENT_COLOR,
              ),
              ItemList(
                onTap: () {},
                title: deviceModel,
                description: "OS: "+osVersion,
                divider: true,
                first: true,
              ),
              ItemList(
                title: appName,
                description: appPackage+
                             "\nVersión: "+appVersion+
                             "\nNúmero de compilación: "+buildNumber,
                divider: true,
                onTap: () {
                  if (taps >= 8) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Encontraste el easter egg"),
                        content: Text(
                          "Aplicación desarrollada por el becario Alberto Caro Navarro.\n\nalbertcaronava@gmail.com"
                        ),
                        actions: <Widget>[
                          MaterialButton(
                            child: Text("ACEPTAR"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      )
                    );
                  }
                  taps++;
                },
              ),
              ItemList(
                title: "Acerca de",
                description: "Información sobre esta aplicación y licencias de código abierto.",
                divider: false,
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: appName+ " App",
                    applicationVersion: appVersion,
                    applicationLegalese: "Derechos reservados ©1997 - 2019. Universidad de Guadalajara. \n"
                                         "\nAplicación desarrollada por el Área de Generación de Contenidos "
                                         "Educativos de la Coordinación de Tecnologías para el Aprendizaje"
                                         " del Centro Universitario de los Valles.",
                  );
                },
              ),
            ]),
          )
        ],
      ),
    );
  }

}

class ItemList extends StatelessWidget {
  ItemList({this.title, this.description, this.action, this.onTap, this.divider, this.first, this.last, this.disabled = false});

  final String title, description;
  final Widget action;
  final bool divider;
  final bool first;
  final bool last;
  final Function onTap;
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MaterialButton(
          onPressed: !disabled ? onTap : null,
          padding: EdgeInsets.only(
            top: (divider && first == null || last != null) ? 12 : 0,
            right: 16,
            bottom: (divider && first == null || last != null ) ? 12 : 0,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(
                    title,
                    style: TextStyle( 
                      color: !disabled ? Colors.black : Colors.black38
                    ),
                  ),
                  subtitle: Text(
                    description,
                    style: TextStyle(
                      color: !disabled ? Colors.black54 : Colors.black26
                    ),
                  ),
                ),
              ),
              (action != null) ? action : Container(),
            ],
          ),
        ),
        (divider) ? Divider(height: 0) : Container()
      ],
    );
  }
}

