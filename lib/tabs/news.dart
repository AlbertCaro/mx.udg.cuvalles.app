import 'package:CUValles/models/new.dart';
import 'package:CUValles/screens/newdetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsTab extends StatefulWidget {
  NewsTab({Key key}) : super(key: key);

  @override
  NewsState createState() => NewsState();

}

class NewsState extends State<NewsTab> {

  List<New> news = [
    New("Alberto", "8 de Agosto de 1997", "asgadsgasdgadsgasdgadsgsdfhsdfhdfshdsfhsdfhdsfhsdfhdsfhdsfhsdfhsdfhsdfhdsfhsdfhdfshsfdhdfshdfshsdfh", "Alberto Caro Navarro", "http://cdn.atomix.vg/wp-content/uploads/2017/08/kirby-playlist.jpg", "dssadgasdgadsgadsgadsgasdgasdg", "Noé Darío Mora Medina"),
    New("Prueba", "8 de Agosto de 1997", "asgadsgasdgadsgasdgadsgsfdhsdfhdfshsdfhdfshsdfhsdfhsdfhsdfdfghnmhagdgfhghjgfsngfndfbsfbgsngfngfngfn", "Alberto Caro Navarro", "http://cdn.atomix.vg/wp-content/uploads/2017/08/kirby-playlist.jpg", "asfasdfasdfadsfadsfadsfadsfadsf", "Noé Darío Mora Medina"),
  ];

  List<New> showedList = [];

  @override
  void initState() {
    showedList = news;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: false,
      itemCount: this.showedList.length,
      itemBuilder: (_, int index) => ItemList(this.showedList[index])
    );
  }

  void filterList (String value) {
    showedList = news.where((_new) => _new.title.contains(value)).toList();
  }

}

class ItemList extends StatelessWidget {
  ItemList(this._new);
  final New _new;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewDeatil(this._new)
          )
        );
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(this._new.photo),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 90),
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
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this._new.title,
                      style: TextStyle(
                      color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                    Text(
                      this._new.resume,
                      style: TextStyle(
                      color: Colors.white70,
                        fontSize: 14
                      ),
                    ),
                    Text(
                      this._new.date,
                      style: TextStyle(
                      color: Colors.white54,
                        fontSize: 14
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        )
      ),
    );
  }
}