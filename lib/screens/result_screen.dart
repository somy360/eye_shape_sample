import 'dart:io';
import 'dart:math';

import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/screens/closeness_screen.dart';
import 'package:eye_shape/screens/eyelid_result_screen.dart';
import 'package:eye_shape/screens/eyelid_screen.dart';
import 'package:eye_shape/screens/roundness_screen.dart';
import 'package:eye_shape/screens/turn_screen.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:flutter/material.dart';
import 'package:eye_shape/constants.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultScreen extends StatefulWidget {
  static const String id = 'resultScreen';
  final double turnRatio;
  final double roundnessRatio;
  final double closenessRatio;
  final ResultMath resultMath;
  final File pickedImage;

  ResultScreen(
      {Key key,
      this.resultMath,
      this.turnRatio,
      this.roundnessRatio,
      this.closenessRatio,
      this.pickedImage})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ResultMath resultMath;

  @override
  void initState() {
    super.initState();
    resultMath = widget.resultMath;
  }

  Widget eyeTurnResultCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        color: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 25),
        onPressed: () {
          Get.to(TurnScreen(resultMath: resultMath));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(
                  'Eye Turn: ',
                  style: kResultTextStyle,
                ),
                Text(
                  resultMath.getEyeTurnText(),
                  style: kResultTextStyleBold,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.rotate(
                      angle: -20 * pi / 180,
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.deepOrange,
                        size: 35,
                      ),
                    ),
                    Transform.rotate(
                      angle: 20 * pi / 180,
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.deepOrange,
                        size: 35,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Transform.rotate(
                      angle: 20 * pi / 180,
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.deepOrange,
                        size: 35,
                      ),
                    ),
                    Transform.rotate(
                      angle: -20 * pi / 180,
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.deepOrange,
                        size: 35,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0, left: 15, right: 15, top: 5),
              child: LinearPercentIndicator(
                alignment: MainAxisAlignment.center,
                //width: MediaQuery.of(context).size.width - 100,
                animation: true,
                lineHeight: 40.0,
                animationDuration: 2000,
                percent: resultMath.getTurnPercentage().toDouble() / 100,
                center: Text(
                  '' + resultMath.getTurnPercentage().toString() + '%',
                  style: TextStyle(fontSize: 30),
                ),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.deepOrange,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget eyeRoundnessResultCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        color: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 25),
        onPressed: () {
          Get.to(RoundnessScreen(
            resultMath: resultMath,
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(
                  'Eye Roundness: ',
                  style: kResultTextStyle,
                ),
                Text(
                  resultMath.getEyeRoundnessText(),
                  style: kResultTextStyleBold,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.horizontal_rule,
                      color: Colors.deepOrange,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.panorama_fish_eye,
                      color: Colors.deepOrange,
                      size: 35,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0, left: 15, right: 15, top: 5),
              child: LinearPercentIndicator(
                alignment: MainAxisAlignment.center,
                //width: MediaQuery.of(context).size.width - 100,
                animation: true,
                lineHeight: 40.0,
                animationDuration: 2000,
                percent:
                    (100 - resultMath.getRoundnessPercentage().toDouble()) /
                        100,
                center: Text(
                  '' +
                      (100 - resultMath.getRoundnessPercentage().toInt())
                          .toString() +
                      '%',
                  style: TextStyle(fontSize: 30),
                ),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.deepOrange,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget eyeClosenessResultCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        color: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 25),
        onPressed: () {
          Get.to(ClosenessScreen(
            resultMath: resultMath,
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(
                  'Eye Closeness: ',
                  style: kResultTextStyle,
                ),
                Text(
                  resultMath.getEyeClosenessText(),
                  style: kResultTextStyleBold,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.deepOrange,
                      size: 35,
                    ),
                    SizedBox(width: 15),
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.deepOrange,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.deepOrange,
                      size: 35,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.deepOrange,
                      size: 35,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0, left: 15, right: 15, top: 5),
              child: LinearPercentIndicator(
                alignment: MainAxisAlignment.center,
                //width: MediaQuery.of(context).size.width - 100,
                animation: true,
                lineHeight: 40.0,
                animationDuration: 2000,
                percent: resultMath.getClosenessPercentage().toDouble() / 100,
                center: Text(
                  '' + resultMath.getClosenessPercentage().toString() + '%',
                  style: TextStyle(fontSize: 30),
                ),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.deepOrange,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///TODO: stop centering text
  Widget eyeLidResultCard() {
    if (resultMath.hooded == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          color: Colors.deepPurple,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.only(left: 25, top: 30, bottom: 30, right: 25),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EyelidScreen(
                  resultMath: resultMath,
                  pickedImage: widget.pickedImage,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Eye-Lid Shape: ',
                    style: kResultTextStyle,
                  ),
                  Icon(
                    Icons.forward,
                    size: 30,
                    color: Colors.deepOrange,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          color: Colors.deepPurple,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.only(left: 25, top: 30, bottom: 30, right: 25),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EyelidResultScreen(
                  resultMath: resultMath,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text(
                    'Eye-Lid Shape: ',
                    style: kResultTextStyle,
                  ),
                  Text(
                    resultMath.hooded != null ? resultMath.hooded : '',
                    style: kResultTextStyleBold,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyColour,
      appBar: customAppBar(title: 'Eye Shape Results', context: context),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          eyeTurnResultCard(),
          eyeRoundnessResultCard(),
          eyeClosenessResultCard(),
          eyeLidResultCard(),
        ],
      ),
    );
  }
}
