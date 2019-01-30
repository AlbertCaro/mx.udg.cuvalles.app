import 'package:CUValles/values/functions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class Place {
  Place(this.name, this.lat, this.lon, this.photo, this.extension, this.description);

  String name, lat, lon, photo, extension, description;

  Place.fromJSON(Map json) :
    name = json['nombre'],
    lat = json['lat'],
    lon = json['lan'],
    photo = json['foto'],
    extension = json['extension'],
    description = json['descripcion'];
    

  static Future consultAPI () async {
    return jsonRequest("/rest_ubicaciones.php");
  }
  
  String getDistance(status, Position position) {
    if (status) {
      double mts = Distance().as(
        LengthUnit.Meter,
        LatLng(position.latitude, position.longitude),
        LatLng(double.parse(lat), double.parse(lon))
      );

      return (mts < 1000) ? mts.toInt().toString()+" mts" : (mts/1000).toStringAsFixed(2)+" km";
    }
    return '';
  }
}