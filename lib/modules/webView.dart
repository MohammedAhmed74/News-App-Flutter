import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web_View extends StatelessWidget {
  late final String url;
  Web_View(this.url);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: WebView(
        initialUrl: '$url',
      ),
    );
  }
}
