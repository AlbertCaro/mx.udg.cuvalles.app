import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTab extends StatefulWidget {
  MapTab(this.lat, this.lon);
  final double lat, lon;

  @override
  State<StatefulWidget> createState() => MapState(lat, lon);
}

class MapState extends State<MapTab> {
  MapState(this.lat, this.lon);
  double lat, lon;

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        options: GoogleMapOptions(
          myLocationEnabled: true,
          cameraPosition: CameraPosition(
            target: LatLng(lat, lon),
            zoom: 17,
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { 
      controller.addMarker(
        MarkerOptions(
          position: LatLng(lat, lon)
        )
      );
     });
  }
}