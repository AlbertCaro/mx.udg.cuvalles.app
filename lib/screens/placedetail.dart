import 'package:CUValles/widgets/detailinforow.dart';
import 'package:CUValles/widgets/detailscreen.dart';
import 'package:CUValles/widgets/sliverfloatingactionbutton.dart';
import 'package:CUValles/models/place.dart';
import 'package:CUValles/screens/map.dart';
import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';

class PlaceDetail extends StatefulWidget {
  PlaceDetail({this.place});
  final Place place;

  @override
  PlaceDetailState createState() => PlaceDetailState(place: this.place);
}

class PlaceDetailState extends State<PlaceDetail> with TickerProviderStateMixin {
  PlaceDetailState({this.place});

  ScrollController scrollController;
  TabController tabController;

  Place place;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    tabController = TabController(length: 2, vsync: this);
    scrollController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DetailScreen(
            title: this.place.name,
            imageUrl: SERVER_URL + this.place.photo,
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
                      text: place.description,
                      label: "Descripción",
                      divider: true,
                      context: context
                    ),
                    DetailInfoRow(
                      icon: Icons.phone,
                      text: place.extension,
                      label: "Extensión",
                      divider: false,
                      context: context
                    ),
                  ],
                )
              )
            ],
          ),
          SliverFloatingActionButton(
            scrollController: scrollController,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapScreen(place: this.place)
                )
              );
            },
            child: Icon(
              Icons.place,
              color: Colors.white
            ),
          )
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