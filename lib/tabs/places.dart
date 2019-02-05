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

class PlacesState extends State<PlacesTab> with TickerProviderStateMixin {
  Widget body = Center(child: CircularProgressIndicator());
  List<dynamic> places;
  List<dynamic> showedList;
  bool locationStatus, detailOpened = false, firstOpenDetail = true;
  Position position;
  Place selectedPlace;
  AnimationController controller;
  ScrollController scrollController;


  PlacesState(this.locationStatus, this.position) {
    loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    scrollController = ScrollController();
    
    return body;
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
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
        selectedPlace = showedList[ItemList.selected];
        refreshList().then((val) {
          if (ItemList.itemsHeight != null) {
            print("Scroll");
            scrollController.animateTo(ItemList.itemsHeight * ItemList.selected, duration: Duration(milliseconds: 0), curve: Curves.ease);
          }
        });
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

  Future<bool> refreshList() {
    body = OrientationBuilder(
      builder: (context, orientation) {

        controller = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 700)
        );

        final animation = Tween(
          begin: 0,
          end: 1
        ).animate(controller);

        controller.forward();

        return Container(
          color: LIST_BACKGROUND_COLOR,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  itemBuilder: listBuilder,
                  itemCount: this.showedList.length,
                ),
              ),
              Device.get().isTablet && selectedPlace != null ? Expanded(
                flex: 2,
                child: PlaceDetailLarge(
                  place: selectedPlace,
                  controller: controller,
                ),
              ) : Container()
            ],
          ),
        );
      },
    );
    setState(() { });

    return Future.value(true);
  }

  Widget listBuilder (_, int index) => ItemList(
    itemNumber: index,
    place: this.showedList[index],
    locationStatus: this.locationStatus,
    position: this.position,
    onTap: Device.get().isTablet ? () {
      if (ItemList.selected != index) {
        detailOpened = true;
        ItemList.selected = index;
        selectedPlace = this.showedList[ItemList.selected];
        //scrollController.animateTo(ItemList.itemsHeight * index, duration: Duration(milliseconds: 500), curve: Curves.ease);
        refreshList();
        if (!firstOpenDetail) (mapKey.currentState as MapState).reloadMap(
          this.showedList[index]
        );
        firstOpenDetail = false;
      }
    } : null,
  );
}

class PlaceDetailLarge extends StatefulWidget {
  PlaceDetailLarge({this.place, this.controller});
  Place place;
  AnimationController controller;

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
          child: FadeTransition(
            opacity: widget.controller,
            child: PlaceDetail(
              place: widget.place,
            ),
          ),
        )
      ],
    );
  }
}

class ItemList extends StatefulWidget {

  ItemList({this.place, this.locationStatus, this.position, this.onTap, this.itemNumber});
  final Place place;
  final bool locationStatus;
  final Position position;
  final Function onTap;
  int itemNumber;
  static int selected = 0;
  static double itemsHeight;

  @override
  ItemListState createState() {
    return new ItemListState();
  }
}

class ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    
    bool useRow = MediaQuery.of(context).size.width > 602 || Device.get().isPhone;
    var subList = [
      Text(
        "Extensión: " + widget.place.extension,
        style: TextStyle(
          color: Colors.white70
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: useRow ? 16 : 0),
        child: Text(
          (widget.locationStatus) ? 
          "Distancia: " + widget.place.getDistance(widget.locationStatus, widget.position): 
          '',
          style: TextStyle(
            color: Colors.white70
          ),
        ),
      ),
    ];

    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.only(
          left: widget.itemNumber == ItemList.selected || Device.get().isPhone ? 0 : 8,
          right: widget.itemNumber == ItemList.selected || Device.get().isPhone ? 0 : 8
        ),
        child: Card(
          elevation: widget.itemNumber == ItemList.selected ? 4 : 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(SERVER_URL + widget.place.photo),
                fit: BoxFit.cover
              )
            ),
            child: AnimatedPadding(
              duration: Duration(milliseconds: 250),
              padding: EdgeInsets.only(top: widget.itemNumber == ItemList.selected && Device.get().isTablet ? 175 : 110),
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
                        widget.place.name,
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
                                  builder: (context) => PlaceDetail(place: this.widget.place)
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
                                  builder: (context) => MapScreen(place: this.widget.place)
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
      ),
    );
  }
}