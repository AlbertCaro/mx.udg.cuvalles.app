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
    Message("Uno", "Prueba"),
    Message("Dos", "PruebaSAFSAFSfSAFSAFAFSAFaSFSAFAFSAFASFASFASfASFFSAFasSADFSADFASDFDIHFHIUADSIUFAIUDSHFIUSIHAUDHIUFIUHSADHFIUIHAUSDIHUFIHSAUDIHFUSAIHDUFIHUDSAHUFHASDHUFHUADSHUFHDSAUFHU"),
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
        reverse: false,
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
        padding: EdgeInsets.all(4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage("https://avatarfiles.alphacoders.com/103/103117.gif"),
          ),
          title: Text(message.subject),
          subtitle: Text(message.content),
        ),
      ),
    );
  }

}