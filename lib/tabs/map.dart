import 'package:app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTab extends StatefulWidget {
  MapTab({this.place});
  final Place place;

  @override
  State<StatefulWidget> createState() => MapState(place: this.place,);
}

class MapState extends State<MapTab> {
  MapState({this.place});
  Place place;

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        options: GoogleMapOptions(
          myLocationEnabled: true,
          cameraPosition: CameraPosition(
            target: LatLng(20.5366296, -103.9672237),
            zoom: 17,
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { 
      if (place != null) {
        controller.addMarker(
          MarkerOptions(
            position: LatLng(double.parse(place.lat), double.parse(place.lon))
          )
        );
      } else {
        Place.consultAPI().then((response) {
          print('zi');
          List<dynamic> places = (response.map((json) => Place.fromJSON(json)).toList());
          for (Place place in places) {
            print('zi');
            controller.addMarker(
              MarkerOptions(
                position: LatLng(double.parse(place.lat), double.parse(place.lon)),
                infoWindowText: InfoWindowText(place.name, "Extensión: "+place.extension),
              )
            );
          }
          setState(() {});
        });
      }
      
     });
  }
}