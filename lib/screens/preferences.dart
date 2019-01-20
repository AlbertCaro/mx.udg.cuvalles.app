import 'package:flutter/material.dart';

class Preferences extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => PreferencesState();

}

class PreferencesState extends State<Preferences> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferencias"),
      ),
    );
  }

}