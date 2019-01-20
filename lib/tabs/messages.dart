import 'package:flutter/material.dart';

class MessagesTab extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MessagesState();
}

class MessagesState extends State<MessagesTab> {

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Text("Messages"),
    );
  }

}