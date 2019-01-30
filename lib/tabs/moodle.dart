import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MoodleTab extends StatefulWidget {
  @override
  MoodleState createState() => MoodleState();
}


class MoodleState extends State<MoodleTab> {

  @override
  Widget build(BuildContext context) {

    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Moodle"),
      ),
      url: MOODLE_URL,
      withJavascript: true,
      appCacheEnabled: true,
    );
  }
}

