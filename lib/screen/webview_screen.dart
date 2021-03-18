import 'package:flip_gesture/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  String url;
  WebViewScreen(this.url);
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController webView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: webViewShow(),
      ),
    );
  }

  Widget webViewShow() {
    return InAppWebView(
      initialUrl: widget.url,
      onLoadStart: (InAppWebViewController controller, String url) {
        setState(() {
          url = widget.url;
        });
      },
    );
  }
}
