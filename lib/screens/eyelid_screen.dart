import 'dart:io';
import 'dart:typed_data';

import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/screens/eyelid_screen_two.dart';
import 'package:eye_shape/services/eye_shape_provider.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imgLib;
import 'package:provider/provider.dart';
import '../constants.dart';
import 'result_screen.dart';

class EyelidScreen extends StatefulWidget {
  final ResultMath resultMath;
  final File pickedImage;
  static const String id = 'eyelidScreen';

  EyelidScreen({Key key, this.resultMath, this.pickedImage}) : super(key: key);

  @override
  _EyelidScreenState createState() => _EyelidScreenState();
}

class _EyelidScreenState extends State<EyelidScreen> {
  ///returns cropped image as dart [Image]
  // Image cropImage() {
  //   //Image ourImage = Image.file(widget.pickedImage);
  //   imgLib.Image img = imgLib.decodeImage(widget.pickedImage.readAsBytesSync());
  //   imgLib.Image croppedImg = imgLib.copyCrop(img, 160, 220, 200, 100);

  //   //imgLib.Image image = imgLib.flipHorizontal(ourImage)
  //   Uint8List bytes = imgLib.encodeJpg(croppedImg);
  //   return Image.memory(imgLib.encodeJpg(croppedImg));
  // }

  Uint8List eyeCloseUp;

  @override
  void initState() {
    super.initState();

    //show a dialog with some extra information
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          contentPadding: EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.deepPurple,
          elevation: 50,
          title: Text(
            "Eyelid Shape Tutorial",
            style: kBulletListStyle,
          ),
          content: eyeLidInfoContent(),
        ),
      );
    });
  }

  Widget eyeLidInfoContent() {
    return Container(
      padding: EdgeInsets.all(0),
      width: 1000,
      //height: 300,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hooded - Double lid',
                style: kBulletListStyle,
              ),
              Image.asset('assets/images/doublelid.jpeg'),
            ],
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            '• After this tutorial you will see a picture of your eye.\n\n• Look carefully, do you see a second line between the top of your eye and your eyebrow like above?',
            style: kBulletListStyle,
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: FlatButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.deepOrange,
              child: Text(
                "Next",
                style: kBulletListStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showEyelidInfoHooded(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget eyeLidInfoContentHooded() {
    return Container(
      padding: EdgeInsets.all(0),
      width: 1000,
      //height: 300,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hooded',
                style: kBulletListStyle,
              ),
              Image.asset('assets/images/hooded.jpg'),
            ],
          )),
          SizedBox(
            height: 20,
          ),
          Text(
            '• Sometimes the brow bone partly covers the eyelid.\n\n• As you can see in the inner corner there is still a crease above the eye and so the eye is hooded',
            style: kBulletListStyle,
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: FlatButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.deepOrange,
              child: Text(
                "Next",
                style: kBulletListStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showEyelidInfoMonolid(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEyelidInfoHooded(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.deepPurple,
        elevation: 50,
        title: Text(
          "Eyelid Shape Tutorial",
          style: kBulletListStyle,
        ),
        content: eyeLidInfoContentHooded(),
      ),
    );
  }

  void _showEyelidInfoMonolid(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.deepPurple,
        elevation: 50,
        title: Text(
          "Eyelid Shape Tutorial",
          style: kBulletListStyle,
        ),
        content: eyeLidInfoContentMonolid(),
      ),
    );
  }

  Widget eyeLidInfoContentMonolid() {
    return Container(
      padding: EdgeInsets.all(0),
      width: 1000,
      //height: 300,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monolid',
                style: kBulletListStyle,
              ),
              Image.asset('assets/images/monolid.jpg'),
            ],
          )),
          SizedBox(
            height: 20,
          ),
          Text(
            '• Or is there no line between the top of your eye and your eyebrow, making it appear smooth?\n\n• This is called a Monolid',
            style: kBulletListStyle,
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: FlatButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.deepOrange,
              child: Text(
                "Finish",
                style: kBulletListStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  ///returns cropped image as
  ///TODO: wierd rotation stuff - fixed needs proper testing
  Uint8List cropImage() {
    print(widget.resultMath.faceHeight);
    print(widget.resultMath.dxOuterLeft);
    print(widget.resultMath.dyOuterLeft);

    //Image ourImage = Image.file(widget.pickedImage);
    imgLib.Image img = imgLib.decodeImage(widget.pickedImage.readAsBytesSync());

    int xCoord = widget.resultMath.dxOuterLeft.toInt() -
        widget.resultMath.faceHeight ~/ 10;
    int yCoord = widget.resultMath.dyOuterLeft.toInt() -
        widget.resultMath.faceHeight ~/ 6;

    imgLib.Image croppedImg;

    print(xCoord);
    print(yCoord);

    print(img.height);
    print(img.width);
    if (img.width <= img.height) {
      croppedImg = imgLib.copyCrop(
          img,
          xCoord,
          yCoord,
          widget.resultMath.faceHeight ~/ 2.5,
          widget.resultMath.faceHeight ~/ 4);
    } else {
      croppedImg = imgLib.copyCrop(
        img,
        yCoord,
        xCoord,
        widget.resultMath.faceHeight ~/ 4,
        widget.resultMath.faceHeight ~/ 2.5,
      );
    }

    //imgLib.Image image = imgLib.flipHorizontal(ourImage)
    eyeCloseUp = imgLib.encodeJpg(croppedImg);
    return eyeCloseUp;
  }

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
                  image: MemoryImage(cropImage()),
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
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ResultScreen(
                  //         resultMath: widget.resultMath,
                  //         pickedImage: widget.pickedImage,
                  //       ),
                  //     ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EyelidScreenTwo(
                        resultMath: widget.resultMath,
                        eyeCloseUp: eyeCloseUp,
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
                                'I have a Crease (Line): Hooded',
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
                  widget.resultMath.hooded = 'Monolid';
                  Provider.of<EyeShapeProvider>(context, listen: false).hooded =
                      'Monolid';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        resultMath: widget.resultMath,
                        pickedImage: widget.pickedImage,
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
                                'I have no Crease (No Line): ',
                                style: kResultTextStyle,
                              ),
                              Text(
                                'Monolid',
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
