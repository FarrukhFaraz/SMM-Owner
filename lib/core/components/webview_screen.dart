import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String? appName;

  const WebViewPage({required this.url, this.appName, super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, title: Text(widget.appName ?? "WebView")),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url;

              if (uri != null && (uri.scheme == "http" || uri.scheme == "https")) {
                return NavigationActionPolicy.ALLOW;
              }

              return NavigationActionPolicy.CANCEL;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true; // Show loader
              });
              if (kDebugMode) {
                print("Started loading: $url");
              }
            },
            onLoadStop: (controller, url) async {
              setState(() {
                isLoading = false; // Hide loader
              });
              if (kDebugMode) {
                print("Finished loading: $url");
              }
            },
            onReceivedError: (controller, request, error) {
              setState(() {
                isLoading = false; // Hide loader on error
              });
              if (kDebugMode) {
                print("Received error: ${error.description}");
              }
            },
          ),
          if (isLoading)
            Container(
              color: Colors.white, // Ensure white background while loading
              child: Center(
                child: CircularProgressIndicator(), // Show loader
              ),
            ),
        ],
      ),
    );
  }
}
