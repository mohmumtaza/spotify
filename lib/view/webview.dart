import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webView extends StatefulWidget {
  const webView({super.key});

  @override
  State<webView> createState() => _webViewState();
}

class _webViewState extends State<webView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
          controller: WebViewController()
            ..loadRequest(
                Uri.parse("https://www.youtube.com"))
            ..setJavaScriptMode(JavaScriptMode.unrestricted)),
    );
  }
}