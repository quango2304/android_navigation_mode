import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:android_navigation_mode/android_navigation_mode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DeviceNavigationMode navigationMode = DeviceNavigationMode.none;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    DeviceNavigationMode _navigationMode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _navigationMode = await AndroidNavigationMode.getNavigationMode;
    } on PlatformException {
      _navigationMode = DeviceNavigationMode.none;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      navigationMode = _navigationMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('navigationMode: $navigationMode\n'),
        ),
      ),
    );
  }
}
