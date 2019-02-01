import 'package:CUValles/values/constants.dart';
import 'package:CUValles/widgets/detailinforow.dart';
import 'package:CUValles/widgets/detailscreen.dart';
import 'package:CUValles/models/new.dart';
import 'package:CUValles/widgets/listtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_html/flutter_html.dart';

class NewDeatil extends StatefulWidget {
  NewDeatil({this.newObject});

  final New newObject;

  @override
  NewDeatilState createState() => NewDeatilState();
}

class NewDeatilState extends State<NewDeatil> {
  ScrollController scrollController;

  String removeLineBreaks(String value) {

    var valueFinal = value.replaceAll("\n", "").replaceAll("	", "");
    print(valueFinal);
    return valueFinal;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DetailScreen(
            title: this.widget.newObject.date,
            contentTitle: this.widget.newObject.title,
            hasContentTitle: true,
            contentSubtitle: this.widget.newObject.date,
            imageUrl: this.widget.newObject.photo,
            content: <Widget>[
              Container(
                padding: EdgeInsets.all(Device.get().isTablet ? 32 : 16),
                child: Html(data: removeLineBreaks(widget.newObject.content)),
              ),
              Divider(),
              ListTitle(
                text: "Autores",
                color: ACCENT_COLOR,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 16,
                  left: 24,
                ),
                child: Column(
                  children: <Widget>[
                    DetailInfoRow(
                      icon: Icons.person,
                      text: this.widget.newObject.author,
                      label: "Texto",
                    ),
                    Divider(indent: 54,),
                    DetailInfoRow(
                      icon: Icons.photo_camera,
                      text: this.widget.newObject.imageAuthor,
                      label: "Imágenes",
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
