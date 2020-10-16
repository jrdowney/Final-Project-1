import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'screens/settings.dart';
import 'screens/help.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Fn Browser"),
          leading: GestureDetector(
            onTap: () {/* Write listener code here */},
            child: Icon(
              Icons.help,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                  child: Icon(
                    Icons.settings,
                    size: 26.0,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.more_vert),
                )),
          ],
          backgroundColor: Colors.grey[700],
        ),
        body: Container(
            child: Column(children: <Widget>[
          // Container(
          //   padding: EdgeInsets.all(20.0),
          //   child: Text(
          //       "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
          // ),
          Container(
              padding: EdgeInsets.all(10.0),
              child: progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container()),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: InAppWebView(
                initialUrl: "https://sra.cn.ca",
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  setState(() {
                    this.url = url;
                  });
                },
                onLoadStop:
                    (InAppWebViewController controller, String url) async {
                  setState(() {
                    this.url = url;
                  });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  if (_webViewController != null) {
                    _webViewController.goBack();
                  }
                },
              ),
              RaisedButton(
                child: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (_webViewController != null) {
                    _webViewController.goForward();
                  }
                },
              ),
              RaisedButton(
                child: Icon(Icons.refresh),
                onPressed: () {
                  if (_webViewController != null) {
                    _webViewController.reload();
                  }
                },
              ),
              RaisedButton(
                child: Icon(Icons.refresh),
                onPressed: () {
                  if (_webViewController != null) {
                    _webViewController.reload();
                  }
                },
              ),
              RaisedButton(
                child: Icon(Icons.refresh),
                onPressed: () {
                  if (_webViewController != null) {
                    _webViewController.reload();
                  }
                },
              ),
            ],
          ),
        ])),
      ),
    );
  }
}
