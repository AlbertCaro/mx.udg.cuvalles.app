import 'package:app/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_web/flutter_native_web.dart';

class MoodleTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return FlutterNativeWeb(
      onWebCreated: (webController) => webController.loadUrl(MOODLE_URL),
    );
  }
  
}