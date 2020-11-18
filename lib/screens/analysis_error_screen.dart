import 'dart:io';

import 'package:eye_shape/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnalysisErrorScreen extends StatefulWidget {
  static const String id = 'analysisErrorScreen';

  AnalysisErrorScreen({Key key}) : super(key: key);

  @override
  _AnalysisErrorScreenState createState() => _AnalysisErrorScreenState();
}

class _AnalysisErrorScreenState extends State<AnalysisErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Error'),
      ),
      backgroundColor: kBodyColour,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      'There was an error analysing the image...',
                      style: kResultTextStyle,
                    ),
                  ),
                  Center(
                    child: Text(
                      kErrorText,
                      style: kBulletListStyle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: FlatButton(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 40, right: 40),
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      //works on android only
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop'); //preferred.*
                      //SystemNavigator.pop();
                      //works on both systems but cannot publish an app with exit(0) used programatically plus bad practice in android
                      exit(0);
                    },
                    child: Text(
                      'Exit Eye Shape',
                      style: kResultTextStyle,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
