import 'package:flutter/material.dart';

abstract class StateList<T extends StatefulWidget> extends State {
  List<dynamic> list;
  List<dynamic> showedList;
}