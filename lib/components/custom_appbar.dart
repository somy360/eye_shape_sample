///
/// This file contains all the classes and methods needed for our customAppBar
///
///

import 'package:eye_shape/constants.dart';
import 'package:eye_shape/screens/about_screen.dart';
import 'package:eye_shape/screens/help_screen.dart';
import 'package:eye_shape/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';

BuildContext currentContext;

///
/// method returns our custom app bar
///
Widget customAppBar({String title, BuildContext context}) {
  currentContext = context;
  return AppBar(
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: GestureDetector(
          onTap: () {
            //return to home
            navigator.popUntil(ModalRoute.withName(HomeScreen.id));
          },
          child: Icon(Icons.home),
        ),
      ),
      PopupMenuButton(
        color: Colors.deepPurple,
        onSelected: _select,
        itemBuilder: (BuildContext context) {
          return choices.skip(2).map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: Row(
                children: [
                  Text(
                    choice.title,
                    style: kBulletListStyle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(choice.icon),
                ],
              ),
            );
          }).toList();
        },
      ),
    ],
    backgroundColor: Colors.deepPurple,
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    title: Text(title),
  );
}

void _select(Choice choice) {
  // Causes the app to rebuild with the new _selectedChoice.
  if (choice.title == 'Restart') {
    navigator.popUntil((route) => route.isFirst);
    navigator.pushReplacementNamed(HomeScreen.id);
  }
  if (choice.title == 'Help') {
    //push new screen with help stuff
    Get.to(HelpScreen());
  }
  if (choice.title == 'About') {
    //push about screen

    //Navigator.pushNamed(navigatorKey.currentContext, AboutScreen.id);
    Get.to(AboutScreen());
  }
  if (choice.title == 'Leave a Review') {
    //push new screen with help stuff
    LaunchReview.launch();
  }
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'About', icon: Icons.event_note),
  const Choice(title: 'Help', icon: Icons.mode_comment),
  //const Choice(title: 'Feedback', icon: Icons.assessment),
  const Choice(title: 'Restart', icon: Icons.refresh),
  const Choice(title: 'Leave a Review', icon: Icons.rate_review),
];

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
