import 'package:eye_shape/screens/about_screen.dart';
import 'package:eye_shape/screens/eyelid_screen.dart';
import 'package:eye_shape/screens/help_screen.dart';
import 'package:eye_shape/screens/result_screen.dart';
import 'package:eye_shape/services/eye_shape_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(EyeShape());
}

class EyeShape extends StatelessWidget {
  // This widget is the root of our application, inside which all other widgets are nested.
  @override
  Widget build(BuildContext context) {
    // We set the preferred orientation of the whole app here, we could declare this further
    // down the widget tree to have it effect only one screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(
      create: (context) {
        return EyeShapeProvider();
      },
      child: GetMaterialApp(
        title: 'Eye Shape',
        //not really using the app theme currently but will keep it here for future use
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          HomeScreen.id: (context) => HomeScreen(
                title: 'Eye Shape',
              ),
          ResultScreen.id: (context) => ResultScreen(),
          EyelidScreen.id: (context) => EyelidScreen(),
          AboutScreen.id: (context) => AboutScreen(),
          HelpScreen.id: (context) => HelpScreen(),
        },
        //first route that will be shown on app start
        initialRoute: HomeScreen.id,
      ),
    );
  }
}
