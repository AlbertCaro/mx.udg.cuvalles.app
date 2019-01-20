import 'dart:convert';

import 'package:app/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


AppBar getAppBar (title, onSelected) {
  return AppBar(
    title: Text(title),
    actions: <Widget>[
      PopupMenuButton(
        onSelected: onSelected,
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            child: Text('Preferencias'),
              value: 0,
          )
        ]
      )
    ],
  );
}

Future jsonRequest(path) async {
  var url = SERVER_URL + path;
  Response response = await get(url);

  if (response.statusCode < 200 || response.statusCode > 300) {
    throw new Exception('Petición http fallida');
  } else {
    try {
      return json.decode(response.body);
    } catch (error) {
      print('zi');
      return new List();
    }
  }
    
}

Widget errorWidget({IconData icon, String title, String message, String buttonText, onPressed}) {
    return Center(
      child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black54,
              size: 160,
            ),
            Padding(padding: EdgeInsets.only(top: 16.0),),
            Text(title,
              style: TextStyle(
              fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: 8.0),),
            Text(message),
            Padding(padding: EdgeInsets.only(top: 8.0),),
            MaterialButton(
              child: Text(buttonText),
              textColor: ACCENT_COLOR,
              onPressed: onPressed,
            )
          ]
        ),
    );
  }