import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/constants.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  static const String id = 'helpScreen';

  HelpScreen({Key key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Help'),
      backgroundColor: kBodyColour,
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              kFAQ,
              style: kResultTextStyleBold,
            ),
            Text(
              kFAQText,
              style: kBulletListStyle,
            ),
          ],
        ),
      ),
    );
  }
}
