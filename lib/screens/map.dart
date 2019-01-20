import 'package:app/tabs/map.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  MapScreen(this.title, this.lat, this.lon);

  final String title;
  final double lat, lon;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: MapTab(lat, lon),
    );
  }

}