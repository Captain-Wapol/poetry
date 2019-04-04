
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poetry/bottomNavigation.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());
const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<body>
<video src="http://hanyu-word-legend.bj.bcebos.com/上古.mp4"  controls="controls"></video>
</body>
</html>
''';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aimee's App",
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: BottomNavigationWidget(),
      // home:WebView(
      //     //initialUrl: 'https://flutter.dev',
      //     javascriptMode: JavascriptMode.unrestricted,
      //     onWebViewCreated: (WebViewController webViewController) {
      //       _controller.complete(webViewController);
      //       final String contentBase64 =
      //           base64Encode(const Utf8Encoder().convert(kNavigationExamplePage));
      //       webViewController.loadUrl('data:text/html;base64,$contentBase64');
      //     },
      //     // TODO(iskakaushik): Remove this when collection literals makes it to stable.
      //     // ignore: prefer_collection_literals
      //     javascriptChannels: <JavascriptChannel>[
      //       _toasterJavascriptChannel(context),
      //     ].toSet(),
      //     onPageFinished: (String url) {
      //       print('Page finished loading: $url');
      //     },
      //   )
    );
  }
}
