import 'dart:typed_data';

import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/screens/simple_result_screen.dart';
import 'package:eye_shape/services/eye_shape_provider.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class EyelidScreenTwo extends StatefulWidget {
  final ResultMath resultMath;
  final Uint8List eyeCloseUp;
  static const String id = 'eyelidScreenTwo';

  EyelidScreenTwo({Key key, this.resultMath, this.eyeCloseUp})
      : super(key: key);

  @override
  _EyelidScreenTwoState createState() => _EyelidScreenTwoState();
}

class _EyelidScreenTwoState extends State<EyelidScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar:
            customAppBar(title: 'Eye Shape - Eyelid Shape', context: context),
        backgroundColor: kBodyColour,
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 20),
              child: InteractiveViewer(
                child: Image(
                  image: MemoryImage(widget.eyeCloseUp),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
              child: FlatButton(
                color: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    EdgeInsets.only(left: 25, top: 30, bottom: 30, right: 25),
                onPressed: () {
                  widget.resultMath.hooded = 'Hooded';
                  Provider.of<EyeShapeProvider>(context, listen: false).hooded =
                      'Hooded';
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SimpleResultScreen(
                        resultMath: widget.resultMath,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Wrap(
                            children: [
                              Text(
                                'Skin/Brow Bone obscures crease:',
                                style: kResultTextStyle,
                              ),
                              Text(
                                'Hooded',
                                style: kResultTextStyle,
                              ),
                            ],
                          ),
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
              child: FlatButton(
                color: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    EdgeInsets.only(left: 25, top: 30, bottom: 30, right: 25),
                onPressed: () {
                  widget.resultMath.hooded = 'Slightly Hooded';
                  Provider.of<EyeShapeProvider>(context, listen: false).hooded =
                      'Slightly Hooded';
                  Navigator.popUntil(context, (route) => route.isFirst);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SimpleResultScreen(
                        resultMath: widget.resultMath,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Wrap(
                            children: [
                              Text(
                                'I can see the crease clearly, I have two distinct lines: ',
                                style: kResultTextStyle,
                              ),
                              Text(
                                'Double Lid',
                                style: kResultTextStyle,
                              ),
                            ],
                          ),
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
            ),
          ],
        ),
      ),
    );
  }
}
