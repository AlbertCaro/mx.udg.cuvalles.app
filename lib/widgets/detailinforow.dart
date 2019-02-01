import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';

class DetailInfoRow extends StatelessWidget {
  DetailInfoRow({this.icon, this.text, this.label, this.isLargeScreen = false});

  final IconData icon;
  final String text, label;
  final bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              width: MediaQuery.of(context).size.width/2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      bottom: 16
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}