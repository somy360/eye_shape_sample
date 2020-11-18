import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/constants.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RoundnessScreen extends StatefulWidget {
  static const String id = 'roundnessScreen';
  final ResultMath resultMath;

  RoundnessScreen({Key key, this.resultMath}) : super(key: key);

  @override
  _RoundnessScreenState createState() => _RoundnessScreenState();
}

class _RoundnessScreenState extends State<RoundnessScreen> {
  ResultMath resultMath;

  @override
  void initState() {
    super.initState();
    resultMath = widget.resultMath;
  }

  Widget eyeRoundnessResultCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        color: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 25),
        onPressed: () {
          Get.to(RoundnessScreen());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Results - Roundness'),
      backgroundColor: kBodyColour,
      body: Container(
        child: ListView(
          children: [
            eyeRoundnessResultCard(),
          ],
        ),
      ),
    );
  }
}
