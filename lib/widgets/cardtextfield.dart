import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardTextField extends StatefulWidget {
  CardTextField({
    this.obscureText,
    this.icon,
    this.hintText,
    this.controller,
    this.eye,
    this.error,
    this.keyboardType
  });
  
  @required
  bool obscureText, error;
  @required
  final Icon icon;
  @required
  final String hintText;
  @required
  final TextEditingController controller;
  @required
  final bool eye;
  TextInputType keyboardType;

  @override
  CardTextFieldState createState() => CardTextFieldState();
}

class CardTextFieldState extends State<CardTextField> {
  IconData iconEye = MdiIcons.eye;
  String errorText = "";
  bool first = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Container(
            padding: EdgeInsets.only(
              top: 4,
              left: 14,
              right: 14,
              bottom: 4,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    obscureText: widget.obscureText,
                    keyboardType: widget.keyboardType,
                    decoration: InputDecoration(
                      fillColor: ACCENT_COLOR,
                      border: InputBorder.none,
                      hintText: widget.hintText[0].toUpperCase()+widget.hintText.substring(1),
                      icon: widget.icon,
                    ),
                  ),
                ),
                widget.eye ?
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: GestureDetector(
                    onTap: () { setState(() {
                        widget.obscureText = !widget.obscureText;
                        if (widget.obscureText)
                          iconEye = MdiIcons.eye;
                        else
                          iconEye = MdiIcons.eyeOff;
                      });
                    },
                    child: Icon(
                      iconEye,
                      color: Colors.black54,
                    ),
                  ),
                )
                : Container(),
                validation()
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            errorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(color: Colors.black, blurRadius: 8, offset: Offset(1, 1))
              ]
            ),
          ),
        )
      ],
    );
  }

  Widget validation () {
    iconEye = MdiIcons.eye;
    errorText = (widget.error) ? "El "+widget.hintText+" no puede quedar vacío" : "";
    
    Widget iconError = Container();

    if (widget.error) { 
      iconError = Padding(
        padding: EdgeInsets.only(left: 12),
        child: Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
    first = false;
    return iconError;
  }
}

