import 'package:CUValles/models/place.dart';
import 'package:CUValles/tabs/map.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  MapScreen({this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: MapTab(place: place),
    );
  }

}