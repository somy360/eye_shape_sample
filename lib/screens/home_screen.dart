import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:eye_shape/components/custom_appbar.dart';
import 'package:eye_shape/components/drawer_body.dart';
import 'package:eye_shape/components/loading_dialog.dart';
import 'package:eye_shape/components/picture_info_dialog.dart';
import 'package:eye_shape/components/show_image_dialog.dart';
import 'package:eye_shape/constants.dart';
import 'package:eye_shape/screens/analysis_error_screen.dart';
import 'package:eye_shape/screens/eyelid_screen.dart';
import 'package:eye_shape/services/eye_shape_provider.dart';
import 'package:eye_shape/services/result_math.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:provider/provider.dart';

///
/// any time left and right is mentioned it is in relation to looking at the image from the users perspective
/// not the perspective of the subject of the image
///
class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';

  HomeScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // stores the image the user has selected
  File pickedImage;
  //image picker from the [image_picker] package
  final picker = ImagePicker();
  //if there is an error found with the image the user selects this will be set to false
  bool imageAccepted;
  //to store our errorMessage
  String errorMessage = '';
  //to store the message we display, default shown but will change to the Eye Shape result if successful
  String result = 'New Image';
  //roundness
  String roundness = '';
  //stores users selection for image or camera
  // bool imageSelectionType;
  //stores if the loading dialog is active
  bool loadingDialogActive = false;
  //to store the current build context, for the use of our alert dialog
  BuildContext currentContext;
  //global key for Loading Dialog
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  //global key for getting the scaffold to open/close the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //this class contains our final results
  ResultMath resultMath;

  //Results
  double eyeTurnRatio;
  double roundnessRatio;
  double closenessRatio;

  /// Retrieve an image from the user, async function and returns future to pause and wait for user input
  Future _getImage() async {
    await showImageDialog();
    var pickedFile;
    bool imageSelectionType =
        Provider.of<EyeShapeProvider>(context, listen: false)
            .imageSelectionType;
    if (imageSelectionType != null) {
      if (imageSelectionType && imageSelectionType != null) {
        pickedFile = await picker.getImage(source: ImageSource.camera);
        if (pickedFile != null && pickedFile.path != null) {
          LoadingDialog.showLoadingDialog(context, _keyLoader);
          loadingDialogActive = true;

          pickedFile =
              await FlutterExifRotation.rotateImage(path: pickedFile.path);
        }
      } else {
        if (!imageSelectionType && imageSelectionType != null) {
          pickedFile = await picker.getImage(source: ImageSource.gallery);
          if (pickedFile != null && pickedFile.path != null) {
            LoadingDialog.showLoadingDialog(context, _keyLoader);
            loadingDialogActive = true;

            pickedFile =
                await FlutterExifRotation.rotateImage(path: pickedFile.path);
          }
        }
      }
    }
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
      });
    }
    Provider.of<EyeShapeProvider>(context, listen: false).imageSelectionType =
        null;
  }

  /// Alert dialog for display when the rotation is detected in the image
  ///
  /// TODO: copy [_showImageDialog] to allow chooising to override error
  void _showRotationErrorDialog(String message) {
    showDialog(
      context: currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("We detected some rotation in the image"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              color: Colors.deepPurple,
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Processes the image using ML Vision kit, Returns a future when completed
  ///
  /// Processing takes anything from 1 min on older phones to a few seconds on newer devices
  /// TODO: refactor this a little
  Future _processImage() async {
    //detector options
    FaceDetectorOptions options = FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
        mode: FaceDetectorMode.accurate);

    //open loading dialog
    if (!loadingDialogActive) {
      LoadingDialog.showLoadingDialog(context, _keyLoader);
      loadingDialogActive = true;
    }

    //vison object
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    //Face dector object
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector(options);

    try {
      //Get our faces from the image
      //TODO: loops forever add timeout and deal with it correctly
      List<Face> faces = await faceDetector
          .processImage(visionImage)
          .timeout(Duration(seconds: 20));

      print('facedector completed');

      if (faces != null) {
        print('face != null is true');
        FaceContour leftEyeContour;
        FaceContour rightEyeContour;
        //will contain height of the face bounding box (for comparison with inner/outer eye height difference to get amount of turn in the eye)
        double height;

        for (Face face in faces) {
          print('we have a face');
          //sub-function returns double to 2 decimal places
          double dp(double val) {
            double mod = pow(10.0, 2);
            return ((val * mod).round().toDouble() / mod);
          }

          height = face.boundingBox.height;
          print('height = $height');

          final double rotY = dp(face
              .headEulerAngleY); // Head is rotated to the right rotY degrees i.e vertical rotation/either neck or camera, side face
          final double rotZ = dp(face
              .headEulerAngleZ); // Head is tilted sideways rotZ degrees, i.e how tilted the head is

          print('rotY = $rotY, rotz = $rotZ');
          //checks if the head is rotated (on Y or Z axis) by more than 1 degree, if it is displays error message and stops any further calculations
          if (rotY > 3 || rotY < -3) {
            imageAccepted = false;
            //show this as popup
            errorMessage =
                'Rotation is $rotY degrees.\n\nYour head is turned too much to the side to get an accurate result, please look directly at the camera';
            Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                .pop(); //close the loading dialog
            _showRotationErrorDialog(errorMessage);

            return;
          } else {
            if (rotZ > 3 || rotZ < -3) {
              imageAccepted = false;
              //show as popup
              errorMessage =
                  'Rotation is $rotZ degrees.\n\nYour head or the image is tilted too much, please keep your eyes horizontal (in line with the top of the image)';
              Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                  .pop(); //close the loading dialog
              _showRotationErrorDialog(errorMessage);

              return;
            } else {
              imageAccepted = true;
            }
          }

          // get the countour objects for the left and right eye from the face
          leftEyeContour = face.getContour(FaceContourType.leftEye);
          rightEyeContour = face.getContour(FaceContourType.rightEye);

          //TODO: for testing - remove in future
          print(leftEyeContour.positionsList);
          print(rightEyeContour.positionsList);
        }

        // Do the math on our data for each eye
        double eyeTurn = (analyseLeftEyeTurn(leftEyeContour) +
                analyseRightEyeTurn(rightEyeContour)) /
            2;
        print(eyeTurn);
        print(height);
        setState(() {
          eyeTurnRatio = (eyeTurn / height) * 100;
        });
        print('eye turn: $eyeTurnRatio');

        analyseEyeSetting(
            leftEyeContour: leftEyeContour, rightEyeContour: rightEyeContour);
        analyseEyeRoundness(
            leftEyeContour: leftEyeContour, rightEyeContour: rightEyeContour);

        //get left corner coords to pass to [Result Math] for use in Eyelid crop calculation
        double dxOuterLeft = leftEyeContour.positionsList.elementAt(0).dx;
        double dyOuterLeft = leftEyeContour.positionsList.elementAt(0).dy;

        resultMath = ResultMath(
            turnRatio: eyeTurnRatio,
            roundnessRatio: roundnessRatio,
            closenessRatio: closenessRatio,
            dxOuterLeft: dxOuterLeft,
            dyOuterLeft: dyOuterLeft,
            faceHeight: height);

        if (loadingDialogActive) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          loadingDialogActive = false;
        }
        //close the loading dialog
        //_scaffoldKey.currentState.openDrawer();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ResultScreen(
        //       resultMath: resultMath,
        //       pickedImage: pickedImage,
        //     ),
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EyelidScreen(
              resultMath: resultMath,
              pickedImage: pickedImage,
            ),
          ),
        );
      }
    } on TimeoutException catch (exception) {
      print(exception.message);
      faceDetector.close();
      if (loadingDialogActive) {
        loadingDialogActive = false;
        Navigator.of(_keyLoader.currentContext, rootNavigator: true)
            .pop(); //close the loading dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AnalysisErrorScreen(),
          ),
        );
      }
    }
  }

  ///business logic to analyse how round/narrow the eye shape is
  ///TODO: potentially we could repeat this for 4/12, 5/11, 3/13 then take an average for a more accurate height
  void analyseEyeRoundness(
      {FaceContour leftEyeContour, FaceContour rightEyeContour}) {
    //check for null
    if (leftEyeContour == null || rightEyeContour == null) {
      print('no contours');
      return;
    } else {
      //get witdth of left eye
      double dxOuterLeft = leftEyeContour.positionsList.elementAt(0).dx;
      double dxInnerLeft = leftEyeContour.positionsList.elementAt(8).dx;
      double leftEyeWidth = dxInnerLeft - dxOuterLeft;
      //print('left Eye Width = $leftEyeWidth');

      //get height of left eye
      double dyUpperLeft = leftEyeContour.positionsList.elementAt(4).dy;
      double dyLowerLeft = leftEyeContour.positionsList.elementAt(12).dy;
      double leftEyeHeight = dyLowerLeft - dyUpperLeft;
      //print('left eye height = $leftEyeHeight');

      //get width/height ratio of left eye
      double leftEyeRatio = leftEyeWidth / leftEyeHeight;
      // print(
      //     'left eye width/height ratio (smaller number = wider/rounder eye shape) = $leftEyeRatio');

      //get width of right eye
      double dxOuterRight = rightEyeContour.positionsList.elementAt(8).dx;
      double dxInnerRight = rightEyeContour.positionsList.elementAt(0).dx;
      double rightEyeWidth = dxOuterRight - dxInnerRight;
      //print('right Eye Width = $rightEyeWidth');

      //get height of right eye
      double dyUpperRight = rightEyeContour.positionsList.elementAt(4).dy;
      double dyLowerRight = rightEyeContour.positionsList.elementAt(12).dy;
      double rightEyeHeight = dyLowerRight - dyUpperRight;
      //print('right eye height = $rightEyeHeight');

      //get width/height ratio of right eye
      double rightEyeRatio = rightEyeWidth / rightEyeHeight;
      // print(
      //     'right eye width/height ratio (smaller number = wider/rounder eye shape) = $rightEyeRatio');

      print(' roundness ratio = ' +
          ((rightEyeRatio + leftEyeRatio) / 2).toString());

      double averageRatio = (rightEyeRatio + leftEyeRatio) / 2;

      setState(() {
        roundnessRatio = averageRatio;
      });

      if (averageRatio < 3) {
        roundness = 'Round ';
      } else {
        if (averageRatio > 4) {
          roundness = 'Narrow ';
        }
      }
    }
    //get the height of the eye
    //based on the ratio of these decide whether eye is round or narrow / give percentage prediction
  }

  /// business logic to calculate distance between eyes
  void analyseEyeSetting(
      {FaceContour leftEyeContour, FaceContour rightEyeContour}) {
    //check for null
    if (leftEyeContour == null || rightEyeContour == null) {
      print('no contours');
      return;
    } else {
      //get the left eye width
      double dxOuterLeft = leftEyeContour.positionsList.elementAt(0).dx;
      double dxInnerLeft = leftEyeContour.positionsList.elementAt(8).dx;
      double leftEyeWidth = dxInnerLeft - dxOuterLeft;
      //print('left Eye Width = $leftEyeWidth');

      //get the right eye width
      double dxOuterRight = rightEyeContour.positionsList.elementAt(8).dx;
      double dxInnerRight = rightEyeContour.positionsList.elementAt(0).dx;
      double rightEyeWidth = dxOuterRight - dxInnerRight;
      //print('right Eye Width = $rightEyeWidth');

      //get the space between the eyes
      double distanceBetweenEyes = dxInnerRight - dxInnerLeft;
      print('distance between eyes = $distanceBetweenEyes');

      double avgWidth = (leftEyeWidth + rightEyeWidth) / 2;
      setState(() {
        closenessRatio = (avgWidth / distanceBetweenEyes) * 100;
      }); //larger the number the closer set the eyes are

      print('Closeness Ratio: $closenessRatio');
    }
  }

  ///business logic to analyse left eye up/downturn
  double analyseLeftEyeTurn(FaceContour leftEyeContour) {
    if (leftEyeContour == null) {
      print('no contours');
      return 0;
    } else {
      //TODO: add null check for EyeContours in case of fail
      double dyOuterLeft = leftEyeContour.positionsList.elementAt(0).dy;
      double dyInnerLeft = leftEyeContour.positionsList.elementAt(8).dy;
      double dxOuterLeft = leftEyeContour.positionsList.elementAt(0).dx;
      double dxInnerLeft = leftEyeContour.positionsList.elementAt(8).dx;
      double leftEyeWidth = dxInnerLeft - dxOuterLeft;
      if (dyInnerLeft > dyOuterLeft) {
        // print('The left eye is upturned by ' +
        //     (dyInnerLeft - dyOuterLeft).toString());
        return (dyInnerLeft - dyOuterLeft);
        //return ((dyInnerLeft - dyOuterLeft) / leftEyeWidth) * 100;
      }
      if (dyInnerLeft < dyOuterLeft) {
        // print('The left eye is downturned by ' +
        //     (dyOuterLeft - dyInnerLeft).toString());
        //        return ((dyInnerLeft - dyOuterLeft) / leftEyeWidth) * 100;
        return (dyInnerLeft - dyOuterLeft);
      } else {
        return 0;
      }
    }
  }

  ///business logic to analyse right eye up/downturn
  double analyseRightEyeTurn(FaceContour rightEyeContour) {
    if (rightEyeContour == null) {
      print('no contours');
      return 0;
    } else {
      double dyOuterRight = rightEyeContour.positionsList.elementAt(8).dy;
      double dyInnerRight = rightEyeContour.positionsList.elementAt(0).dy;
      double dxOuterRight = rightEyeContour.positionsList.elementAt(8).dx;
      double dxInnerRight = rightEyeContour.positionsList.elementAt(0).dx;
      double rightEyeWiidth = dxOuterRight - dxInnerRight;
      if (dyInnerRight > dyOuterRight) {
        // print('The right eye is upturned by ' +
        //     (dyInnerRight - dyOuterRight).toString());
        return (dyInnerRight - dyOuterRight);
        //return ((dyInnerRight - dyOuterRight) / rightEyeWiidth) * 100;
      }
      if (dyInnerRight < dyInnerRight) {
        // print('The right eye is downturned by ' +
        //     (dyOuterRight - dyInnerRight).toString());
        //return ((dyInnerRight - dyOuterRight) / rightEyeWiidth) * 100;
        return (dyInnerRight - dyOuterRight);
      } else {
        return 0;
      }
    }
  }

  Widget _centralWidget() {
    return pickedImage != null
        ? Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Center(child: ClipOval(child: Image.file(pickedImage))),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(40),
                  //foregroundDecoration: BoxDecoration(border: ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange, width: 3),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.deepPurple),
                  //color: Colors.orange,
                  child: Text(
                    'Eye\nShape',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 80, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    PictureInfoDialog.showPictureInfoDialog(
                        context, _keyLoader);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'How to get best results: ',
                        style: kBulletListStyle,
                      ),
                      Icon(
                        Icons.forward,
                        color: Colors.deepOrange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  ///
  /// Our UI stuff
  ///
  @override
  Widget build(BuildContext context) {
    currentContext = context;
    Provider.of<EyeShapeProvider>(context).currentContext = context;
    // This method is rerun every time setState is called.
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBodyColour,
      appBar: customAppBar(title: widget.title, context: context),
      drawer: Drawer(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text('Result'),
          ),
          body: drawerBody(
              context: context,
              resultMath: resultMath,
              pickedImage: pickedImage),
        ),
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. The main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                splashColor: Colors.deepPurple,
                onPressed: () async {
                  await _getImage();
                  if (pickedImage != null) {
                    await _processImage();
                  }
                },
                child: _centralWidget(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: FlatButton(
                onPressed: () {},
                child: FlatButton(
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  splashColor: Colors.deepPurple,
                  onPressed: () async {
                    await _getImage();
                    if (pickedImage != null) {
                      await _processImage();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Take a Picture',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
