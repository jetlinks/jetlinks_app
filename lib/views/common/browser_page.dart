import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jetlinks_app/utils/base64.dart';
import 'package:jetlinks_app/common/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserPage extends StatefulWidget {

  final String webViewUrl;

  BrowserPage({this.webViewUrl});

  @override
  _BrowserPageState createState() => _BrowserPageState(webViewUrl);
}

class _BrowserPageState extends State<BrowserPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  String webViewUrl;
  String title;

  _BrowserPageState(String url){
    webViewUrl =Base64.decodeBase64(url.replaceAll('/', "/"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(title??'Jetlinks'),
        ),
        body: WebView(
          initialUrl: webViewUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          onPageFinished: (String url){},
        ),
      ),
    onWillPop: () async {
        var controller =await _controller.future;
        if(await controller.canGoBack()){
          // 是否可以回退到上一步
          controller.goBack();
          return false;
        }else {
          return true;
        }
    });
  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context)=>JavascriptChannel(
    name: 'Toaster',
    onMessageReceived: (JavascriptMessage message){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message.message)),);
    }
  );
}
