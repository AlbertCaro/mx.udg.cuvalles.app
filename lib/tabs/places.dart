import 'package:app/models/place.dart';
import 'package:app/screens/map.dart';
import 'package:app/values/constants.dart';
import 'package:app/values/functions.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';

class PlacesTab extends StatefulWidget {
  PlacesTab(this.locationStatus, this.position);
  final bool locationStatus;
  final Position position;

  @override
  State<StatefulWidget> createState() => PlacesState(this.locationStatus, this.position);
}

class PlacesState extends State<PlacesTab> {
  PlacesState(this.locationStatus, this.position);
  
  Widget body = Center(child: CircularProgressIndicator());
  List<dynamic> places = [];
  bool locationStatus;
  Position position;

  @override
  Widget build(BuildContext context) {
    
    return body;
  }

  @override
  void initState() {
    print(locationStatus);
    super.initState();
    loadPlaces();
  }

  
  void loadPlaces() {
    print('Entró 4');
    body = Center(child: CircularProgressIndicator());
    Place.consultAPI().then((list) {
      places = list.map((json) => Place.fromJSON(json)).toList();
      body = ListView.builder(
        itemBuilder: (_, int index) => ItemList(this.places[index], this.locationStatus, this.position),
        itemCount: this.places.length,
      );
      setState(() {});
    }).catchError((error) {
      errorWidget(
        icon: Icons.signal_wifi_off,
        title: 'No se ha podido contactar con el servidor',
        message: 'Revise su conexión',
        buttonText: 'Reintentar',
        onPressed: loadPlaces,
      );
    });
  }
}

/*class ItemList extends StatefulWidget {
  ItemList(this.place, this.locationStatus, this.position);

  final Place place;
  bool locationStatus;
  Position position;

  @override
  ItemListState createState() => ItemListState(this.place, this.locationStatus, this.position);

}*/

class ItemList extends StatelessWidget {

  ItemList(this.place, this.locationStatus, this.position);
  final Place place;
  final bool locationStatus;
  final Position position;

  @override
  Widget build(BuildContext context) {
    
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(SERVER_URL + place.photo),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 110),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.85),
                  Color.fromRGBO(0, 0, 0, 0.83),
                  Color.fromRGBO(0, 0, 0, 0.8),
                  Color.fromRGBO(0, 0, 0, 0.5),
                  Color.fromRGBO(0, 0, 0, 0)
                ]
              )
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 16,
                bottom: 8,
                left: 16,
                right: 16
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    place.name,
                    style: TextStyle(
                    color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Extensión: " + place.extension,
                        style: TextStyle(
                          color: Colors.white70
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Text(
                        (locationStatus) ? 
                        "Distancia: " + place.getDistance(locationStatus, position): 
                        '',
                        style: TextStyle(
                          color: Colors.white70
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                      children: <Widget>[
                        MaterialButton(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(Icons.info_outline),
                              ),
                              Text('Detalles')
                            ],
                          ),
                          textColor: ACCENT_COLOR,
                          onPressed: (){},
                        ),
                        Padding( padding: EdgeInsets.only(left: 8), ),
                        MaterialButton(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(Icons.place),
                              ),
                              Text('Ubicación')
                            ],
                          ),
                          textColor: ACCENT_COLOR,
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                  place.name,
                                  double.parse(place.lat),
                                  double.parse(place.lon)
                                )
                              )
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ) 
      )
    );
  }
}