import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/constants.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:flutter/material.dart';

class EyelidResultScreen extends StatefulWidget {
  static const String id = 'eyelidResultScreen';
  final ResultMath resultMath;

  EyelidResultScreen({Key key, this.resultMath}) : super(key: key);

  @override
  _EyelidResultScreenState createState() => _EyelidResultScreenState();
}

class _EyelidResultScreenState extends State<EyelidResultScreen> {
  ResultMath resultMath;

  @override
  void initState() {
    super.initState();
    resultMath = widget.resultMath;
  }

  Widget eyeLidResultCard() {
    if (resultMath.hooded == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          color: Colors.deepPurple,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.only(left: 25, top: 30, bottom: 30, right: 25),
          onPressed: () {},
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
          onPressed: () {},
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
      appBar: customAppBar(context: context, title: 'Results - Eyelid Shape'),
      backgroundColor: kBodyColour,
      body: Container(
        child: ListView(
          children: [
            eyeLidResultCard(),
          ],
        ),
      ),
    );
  }
}
