import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/constants.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ClosenessScreen extends StatefulWidget {
  static const String id = 'closenessScreen';
  final ResultMath resultMath;

  ClosenessScreen({Key key, this.resultMath}) : super(key: key);

  @override
  _ClosenessScreenState createState() => _ClosenessScreenState();
}

class _ClosenessScreenState extends State<ClosenessScreen> {
  ResultMath resultMath;

  @override
  void initState() {
    super.initState();
    resultMath = widget.resultMath;
  }

  Widget eyeClosenessResultCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        color: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 25),
        onPressed: () {
          Get.to(ClosenessScreen());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Results - Closeness'),
      backgroundColor: kBodyColour,
      body: Container(
        child: ListView(
          children: [eyeClosenessResultCard()],
        ),
      ),
    );
  }
}
