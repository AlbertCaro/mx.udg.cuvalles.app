import 'dart:convert';

import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


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

Widget buildFab({ScrollController controller, FloatingActionButton fab}) {
  final double defaultTopMargin = 256.0 - 4.0;
  final double scaleStart = 96.0;
  final double scaleEnd = scaleStart / 2;
  double top = 256.0 - 4.0;
  double scale = 1.0;

  if (controller.hasClients) {
    double offset = controller.offset;
    top -= offset;
    if (offset < defaultTopMargin - scaleStart)
      scale = 1.0;
    else if (offset < defaultTopMargin - scaleEnd)
      scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
    else
      scale = 0.0;
  }
  
  return Positioned(
    top: top,
    right: 16.0,
    child: Transform(
      transform: Matrix4.identity()..scale(scale),
      alignment: Alignment.center,
      child: fab,
    ),
  );
}