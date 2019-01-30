import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return WebView(
      initialUrl: WEB_TAB_URL,
    );
  }

}