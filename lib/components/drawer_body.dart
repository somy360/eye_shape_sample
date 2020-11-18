import 'dart:io';

import 'package:eye_shape/screens/result_screen.dart';
import 'package:eye_shape/services/eye_shape_provider.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

/// body of our drawer - displays a summary of the results
Widget drawerBody(
    {@required ResultMath resultMath,
    @required BuildContext context,
    @required File pickedImage}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.deepPurple),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.remove_red_eye_rounded,
                  color: Colors.deepOrange,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      Text(
                        'Eye Turn: ',
                        style: kBulletListStyle,
                      ),
                      Text(
                        resultMath != null ? resultMath.getEyeTurnText() : '',
                        style: kResultTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.deepPurple),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.remove_red_eye_rounded,
                  color: Colors.deepOrange,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      Text(
                        'Eye Roundness: ',
                        style: kBulletListStyle,
                      ),
                      Text(
                        resultMath != null
                            ? resultMath.getEyeRoundnessText()
                            : '',
                        style: kResultTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.deepPurple),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.remove_red_eye_rounded,
                  color: Colors.deepOrange,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      Text(
                        'Eye Closeness: ',
                        style: kBulletListStyle,
                      ),
                      Text(
                        resultMath != null
                            ? resultMath.getEyeClosenessText()
                            : '',
                        style: kResultTextStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.deepPurple),
            padding: EdgeInsets.all(20),
            child: getEyelidText(context: context, resultMath: resultMath),
          ),
        ),
        Opacity(
          opacity: resultMath != null ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.deepPurple,
              onPressed: () {
                if (resultMath != null)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        resultMath: resultMath,
                        pickedImage: pickedImage,
                      ),
                    ),
                  );
              },
              padding: EdgeInsets.all(20),
              child: Text(
                'See Full Results',
                style: kBulletListStyle,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

///TODO: we need to setup a a provider for accessing hooded and add a listener here plus notify listeners in the provider
Widget getEyelidText(
    {@required BuildContext context, @required ResultMath resultMath}) {
  if (resultMath != null) {
    return Row(
      children: [
        Icon(
          Icons.remove_red_eye_rounded,
          color: Colors.deepOrange,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Wrap(
            children: [
              Text(
                'Eye-Lid Shape: ',
                style: kBulletListStyle,
              ),
              Text(
                Provider.of<EyeShapeProvider>(context, listen: true).hooded !=
                        null
                    ? Provider.of<EyeShapeProvider>(context, listen: true)
                        .hooded
                    : '',
                style: kResultTextStyle,
              )
            ],
          ),
        ),
      ],
    );
  } else {
    return Row(
      children: [
        Icon(
          Icons.remove_red_eye_rounded,
          color: Colors.deepOrange,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Eye-Lid Shape:',
          style: kBulletListStyle,
        ),
      ],
    );
  }
}
