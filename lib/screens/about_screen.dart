import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/constants.dart';
import 'package:eye_shape/screens/about_screen_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatefulWidget {
  static const String id = 'aboutScreen';

  AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
                      kAboutText,
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
                      Get.to(AboutScreenTwo());
                    },
                    child: Text(
                      'Next',
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
