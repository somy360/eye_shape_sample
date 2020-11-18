import 'package:eye_shape/services/eye_shape_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

import 'package:provider/provider.dart';

/// Alert dialog for choosing camera or gallery
Future showImageDialog() async {
  return showDialog(
    context: Get.context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Icon(
          Icons.portrait_rounded,
          color: Colors.deepPurple,
          size: 70,
        ),
        content: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Camera",
                        style: kBulletListStyle,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Provider.of<EyeShapeProvider>(Get.context, listen: false)
                      .imageSelectionType = true;
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Gallery",
                        style: kBulletListStyle,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Provider.of<EyeShapeProvider>(Get.context, listen: false)
                      .imageSelectionType = false;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
