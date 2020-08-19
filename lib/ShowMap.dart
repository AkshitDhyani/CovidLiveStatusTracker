import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowMap extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ShowMap();
  }

}

class _ShowMap extends State<ShowMap>{

  final Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://app.developer.here.com/coronavirus/',
          onWebViewCreated: (WebViewController controller){
            _completer.complete(controller);
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}