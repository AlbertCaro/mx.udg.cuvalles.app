import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';

class DetailInfoRow extends StatelessWidget {
  DetailInfoRow({this.icon, this.text, this.label, this.divider, this.context});

  final IconData icon;
  final String text, label;
  final bool divider;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Icon(
              icon,
              color: ACCENT_COLOR,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 32
            ),
            child: Container(
              width: MediaQuery.of(this.context).size.width-90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 16
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  (divider) ? Divider() : Container()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}