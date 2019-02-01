import 'package:CUValles/models/message.dart';
import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';

class MessagesTab extends StatefulWidget {
  MessagesTab({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MessagesState();
}

class MessagesState extends State<MessagesTab> {
  List<dynamic> messages = [
    Message("Dos", "Prueba"),
    Message("Uno", "Prueba"),
  ];

  List<dynamic> showedList = [];
  
  MessagesState () {
    showedList = messages;
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: LIST_BACKGROUND_COLOR,
      child: ListView.builder(
        reverse: true,
        itemBuilder: (BuildContext context, int index) => ItemList(this.showedList[index]),
        itemCount: this.showedList.length,
      ),
    );
  }

}

class ItemList extends StatelessWidget {
  ItemList(this.message);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage("https://avatarfiles.alphacoders.com/103/103117.gif"),
            ),
            Container(
              width: MediaQuery.of(context).size.width-80,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message.subject,
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}