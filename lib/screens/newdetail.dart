import 'package:CUValles/widgets/detailinforow.dart';
import 'package:CUValles/widgets/detailscreen.dart';
import 'package:CUValles/models/new.dart';
import 'package:flutter/material.dart';

class NewDeatil extends StatefulWidget {
  NewDeatil(this._new);

  final New _new;

  @override
  NewDeatilState createState() => NewDeatilState();
}

class NewDeatilState extends State<NewDeatil> {
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DetailScreen(
            title: this.widget._new.title,
            imageUrl: this.widget._new.photo,
            content: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Arboretum, bosque de los valles, es el nombre del proyecto de reforestación que realiza el Centro Universitario de los Valles con el objeto de ofrecer un espacio adecuado para su comunidad universitaria, mismo que sea amigable con el entorno natural que les rodea, reconoció Leobardo Padilla Miranda, responsable del proyecto. \n\nAdemás este microclima contribuirá a la protección de la fauna silvestre de la región, al constituirse como un refugió para distintas aves amenazadas en las épocas de cosecha de la caña de azúcar. En este sentido, también fungirá como disipador de las concentraciones de CO2 producto de la zafra y permitirá la recuperación de mantos freáticos.\n\nEs por ello, que para este proyecto tiene como propósito disponer de 5 mil árboles, pertenecientes a especies de la región Valles, lo cual garantizará una mayor probabilidad de vida, debido a los factores abióticos presentes en esta parte de la zona.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 24,
                ),
                child: Column(
                  children: <Widget>[
                    DetailInfoRow(
                      icon: Icons.person,
                      text: this.widget._new.author,
                      label: "Texto",
                      divider: true,
                      context: context
                    ),
                    DetailInfoRow(
                      icon: Icons.photo_camera,
                      text: this.widget._new.imageAuthor,
                      label: "Imágenes",
                      divider: false,
                      context: context
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
