import 'dart:math';

import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/constants.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TurnScreen extends StatefulWidget {
  static const String id = 'turnScreen';
  final ResultMath resultMath;

  TurnScreen({Key key, @required this.resultMath}) : super(key: key);

  @override
  _TurnScreenState createState() => _TurnScreenState();
}

class _TurnScreenState extends State<TurnScreen> {
  ResultMath resultMath;

  @override
  void initState() {
    super.initState();
    resultMath = widget.resultMath;
  }

  Widget eyeTurnResultCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: FlatButton(
        color: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 25),
        onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Results - Eye Turn'),
      backgroundColor: kBodyColour,
      body: Container(
        child: ListView(
          children: [
            eyeTurnResultCard(),
          ],
        ),
      ),
    );
  }
}
