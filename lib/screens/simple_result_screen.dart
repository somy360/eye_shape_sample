import 'dart:io';

import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/screens/result_screen.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:flutter/material.dart';
import 'package:eye_shape/constants.dart';

class SimpleResultScreen extends StatefulWidget {
  static const String id = 'simpleResultScreen';
  final double turnRatio;
  final double roundnessRatio;
  final double closenessRatio;
  final ResultMath resultMath;
  final File pickedImage;

  SimpleResultScreen(
      {Key key,
      this.resultMath,
      this.turnRatio,
      this.roundnessRatio,
      this.closenessRatio,
      this.pickedImage})
      : super(key: key);

  @override
  _SimpleResultScreenState createState() => _SimpleResultScreenState();
}

class _SimpleResultScreenState extends State<SimpleResultScreen> {
  ResultMath resultMath;

  @override
  void initState() {
    super.initState();
    resultMath = widget.resultMath;
  }

  String getEyeShapeText() {
    String result = '';
    int counter = 0;
    //start of first pass
    if (resultMath.hooded == 'Monolid') {
      result = result + '-Monolid\n';
      counter++;
    }
    if (resultMath.getEyeTurnText() == 'Downturned') {
      result = result + '-Downturned\n';
      counter++;
    }
    if (resultMath.getEyeTurnText() == 'Upturned') {
      result = result + '-Upturned\n';
      counter++;
    }
    if (resultMath.getEyeRoundnessText() == 'Round') {
      result = result + '-Round\n';
      counter++;
    }
    if (resultMath.getEyeRoundnessText() == 'Almond') {
      result = result + '-Almond\n';
      counter++;
    }
    if (resultMath.hooded == 'Hooded') {
      result = result + '-Hooded\n';
    }
    if (resultMath.getEyeClosenessText() == 'Wide Set') {
      result = result + '-Wide Set\n';
    }
    if (resultMath.getEyeClosenessText() == 'Close Set') {
      result = result + '-Close Set\n';
    }
    //end of first pass

    if (counter == 0) {
      if (resultMath.getEyeTurnText() == 'Slightly Downturned') {
        result = result + '-Downturned\n';
        counter++;
      }
      if (resultMath.getEyeTurnText() == 'Slightly Upturned') {
        result = result + '-Upturned\n';
        counter++;
      }
      if (resultMath.getEyeRoundnessText() == 'Slightly Round') {
        result = result + '-Round\n';
        counter++;
      }
      if (resultMath.getEyeRoundnessText() == 'Slightly Almond') {
        result = result + '-Almond\n';
        counter++;
      }
    }

    if (counter == 0) {
      result = result + '-Almond';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyColour,
      appBar: customAppBar(title: 'Eye Shape Results', context: context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.deepPurple),
                child: Text(
                  'Your Eye Shape is: ',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange, width: 3),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.deepPurple),
                child: Column(
                  children: [
                    Text(
                      getEyeShapeText(),
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //eyeTurnResultCard(),
          //eyeRoundnessResultCard(),
          //eyeClosenessResultCard(),
          //eyeLidResultCard(),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Center(
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.deepPurple,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        resultMath: widget.resultMath,
                        pickedImage: widget.pickedImage,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Detailed Results',
                  style: kResultTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
