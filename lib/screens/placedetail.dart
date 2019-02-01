import 'package:CUValles/widgets/detailinforow.dart';
import 'package:CUValles/widgets/detailscreen.dart';
import 'package:CUValles/widgets/sliverfloatingactionbutton.dart';
import 'package:CUValles/models/place.dart';
import 'package:CUValles/screens/map.dart';
import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class PlaceDetail extends StatefulWidget {
  PlaceDetail({Key key, this.place}) : super(key: key);
  final Place place;

  @override
  PlaceDetailState createState() => PlaceDetailState();
}

class PlaceDetailState extends State<PlaceDetail> with TickerProviderStateMixin {
  ScrollController scrollController;

  PlaceDetailState() {
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DetailScreen(
            title: this.widget.place.name,
            contentTitle: this.widget.place.name,
            hasContentTitle: Device.get().isTablet,
            imageUrl: SERVER_URL + this.widget.place.photo,
            content: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 24,
                ),
                child: Column(
                  children: <Widget>[
                    DetailInfoRow(
                      icon: Icons.info_outline,
                      text: widget.place.description,
                      label: "Descripción",
                    ),
                    Divider(indent: 54,),
                    DetailInfoRow(
                      icon: Icons.phone,
                      text: widget.place.extension,
                      label: "Extensión",
                    ),
                  ],
                )
              )
            ],
          ),
          Device.get().isPhone ?
          SliverFloatingActionButton(
            scrollController: scrollController,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapScreen(place: this.widget.place)
                )
              );
            },
            child: Icon(
              Icons.place,
              color: Colors.white
            ),
          )
          : Container()
        ],
      ),
    );
  }

  

}

/*
Padding(
          padding: EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 24,
          ),
          child: Column(
            children: <Widget>[
              row(
                icon: Icons.place,
                text: place.description,
                label: "Descripción",
                divider: true,
                context: context
              ),
              row(
                icon: Icons.phone,
                text: place.extension,
                label: "Extensión",
                divider: false,
                context: context
              ),
            ],
          ) */