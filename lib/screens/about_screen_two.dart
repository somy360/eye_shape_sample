import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreenTwo extends StatefulWidget {
  static const String id = 'aboutScreenTwo';

  AboutScreenTwo({Key key}) : super(key: key);

  @override
  _AboutScreenTwoState createState() => _AboutScreenTwoState();
}

class _AboutScreenTwoState extends State<AboutScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'About'),
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
                      kAboutText2,
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
                      navigator.popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      'Close',
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
