import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kommunicate_flutter_plugin/kommunicate_flutter_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Kcomm(),
    );
  }
}

class Kcomm extends StatefulWidget {
  @override
  _KcommState createState() => _KcommState();
}

class _KcommState extends State<Kcomm> {
  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Do you want to chat with us?",
                  style: TextStyle(fontSize: 35),
                  textAlign: TextAlign.center,
                ),
              ),
              RaisedButton(
                child: Text("Click Here"),
                onPressed: () async {
                  setState(() {
                    showLoader = true;
                  });
                  try {
                    dynamic conversationObject = {
                      'appId': '3ee0d8fb8677a5f3f8fc76529452278af',
                      'withPreChat': true
                    };
                    dynamic result =
                        await KommunicateFlutterPlugin.buildConversation(
                            conversationObject);
                    setState(() {
                      showLoader = false;
                    });
                    print(
                        "Conversation builder success : " + result.toString());
                  } on Exception catch (e) {
                    print("Conversation builder error occurred : " +
                        e.toString());
                  }
                  setState(() {
                    showLoader = false;
                  });
                },
              ),
            ],
          ),
          (showLoader)
              ? Center(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
