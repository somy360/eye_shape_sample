import 'package:eye_shape/components/intro_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PictureInfoDialog {
  static Future<void> showPictureInfoDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: AlertDialog(
          contentPadding: EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.deepPurple,
          elevation: 50,
          title: Text(
            "How to get the best Results",
            style: kBulletListStyle,
          ),
          content: Container(
            padding: EdgeInsets.all(0),
            width: 1000,
            //height: 300,
            child: introText(),
          ),
          actions: [
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.pop(context);
                return;
              },
            )
          ],
        ),
      ),
    );
  }
}
