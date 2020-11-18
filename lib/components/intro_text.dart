import 'package:eye_shape/components/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

///main widget which displays on screen at app start
Widget introText() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(currentContext);
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepPurple),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '• Take the picture in good light (no shadows covering your face)',
                    textAlign: TextAlign.left,
                    style: kBulletListStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '• Look directly at the camera',
                    textAlign: TextAlign.left,
                    style: kBulletListStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '• Keep your head straight, so your eyes are horizontal and your nose is vertical',
                    style: kBulletListStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '• Relax your face',
                    style: kBulletListStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '• No make up',
                    style: kBulletListStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
