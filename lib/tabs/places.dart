import 'package:CUValles/tabs/map.dart';
import 'package:CUValles/widgets/errormessage.dart';
import 'package:CUValles/models/place.dart';
import 'package:CUValles/screens/map.dart';
import 'package:CUValles/screens/placedetail.dart';
import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:geolocator/geolocator.dart';

final GlobalKey mapKey = GlobalKey<MapState>();

class PlacesTab extends StatefulWidget {
  PlacesTab(Key key, this.locationStatus, this.position) : super(key: key);
  final bool locationStatus;
  final Position position;

  @override
  State<StatefulWidget> createState() => PlacesState(this.locationStatus, this.position);
}

class PlacesState extends State<PlacesTab> {
  Widget body = Center(child: CircularProgressIndicator());
  List<dynamic> places;
  List<dynamic> showedList;
  bool locationStatus, detailOpened = false, firstOpenDetail = true;
  Position position;
  Place selectedPlace;


  PlacesState(this.locationStatus, this.position) {
    loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    
    return body;
  }
  
  void loadPlaces() {
    body = Center(child: CircularProgressIndicator());
    Place.consultAPI().then((list) {
      print('zi');
      if(list.isEmpty) {
        body = ErrorMessage(
          icon: Icons.signal_wifi_off,
          title: 'No se ha podido contactar con el servidor',
          message: 'Revise su conexión',
          buttonText: 'Reintentar',
          onPressed: loadPlaces,
        );
      } else {
        places = list.map((json) => Place.fromJSON(json)).toList();
        showedList = places;
        selectedPlace = showedList[0];
        refreshList();
      }
      setState(() {});
    }).catchError((error) {
      body = ErrorMessage(
        icon: Icons.signal_wifi_off,
        title: 'No se ha podido contactar con el servidor',
        message: 'Revise su conexión',
        buttonText: 'Reintentar',
        onPressed: loadPlaces,
      );
    });
  }

  void refreshList() {
    body = OrientationBuilder(
      builder: (context, orientation) {
        return Container(
          color: LIST_BACKGROUND_COLOR,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemBuilder: listBuilder,
                  itemCount: this.showedList.length,
                ),
              ),
              Device.get().isTablet && selectedPlace != null ? Expanded(
                flex: 2,
                child: PlaceDetailLarge(place: selectedPlace),
              ) : Container()
            ],
          ),
        );
      },
    );
    setState(() { });
  }

  Widget listBuilder (_, int index) => ItemList(
    place: this.showedList[index],
    locationStatus: this.locationStatus,
    position: this.position,
    onTap: Device.get().isTablet ? () {
      detailOpened = true;
      selectedPlace = this.showedList[index];
      refreshList();
      if (!firstOpenDetail) (mapKey.currentState as MapState).reloadMap(
        this.showedList[index]
      );
      firstOpenDetail = false;
    } : null,
  );
}

class PlaceDetailLarge extends StatefulWidget {
  PlaceDetailLarge({this.place});
  Place place;

  @override
  PlaceDetailLargeState createState() => PlaceDetailLargeState();
}

class PlaceDetailLargeState extends State<PlaceDetailLarge> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: MapTab(
            key: mapKey,
            place: widget.place
          ),
        ),
        Expanded(
          child: PlaceDetail(
            place: widget.place,
          ),
        )
      ],
    );
  }
}

class ItemList extends StatelessWidget {

  ItemList({this.place, this.locationStatus, this.position, this.onTap});
  final Place place;
  final bool locationStatus;
  final Position position;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    bool useRow = MediaQuery.of(context).size.width > 602 || Device.get().isPhone;
    var subList = [
      Text(
        "Extensión: " + place.extension,
        style: TextStyle(
          color: Colors.white70
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: useRow ? 16 : 0),
        child: Text(
          (locationStatus) ? 
          "Distancia: " + place.getDistance(locationStatus, position): 
          '',
          style: TextStyle(
            color: Colors.white70
          ),
        ),
      ),
    ];

    return GestureDetector(
      onTap: onTap,
      child: Card(
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
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.55),
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
                    Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 8),
                      child: useRow
                      ? Row(
                        children: subList,
                      ): Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: subList,
                      ),
                    ),
                    Device.get().isPhone ?
                    Row(
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaceDetail(place: this.place)
                              )
                            );
                          },
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
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => MapScreen(place: this.place)
                              )
                            );
                          },
                        )
                      ],
                    ) : Container()
                  ],
                ),
              ),
            ),
          ) 
        )
      ),
    );
  }
}