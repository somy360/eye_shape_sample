import 'package:flutter/cupertino.dart';

class EyeShapeProvider extends ChangeNotifier {
  String _hooded;
  BuildContext _currentContext;
  //stores users selection for image or camera
  bool imageSelectionType;

  BuildContext get currentContext => _currentContext;

  set currentContext(BuildContext currentContext) {
    _currentContext = currentContext;
  }

  String get hooded => _hooded;

  set hooded(String hooded) {
    _hooded = hooded;
    notifyListeners();
  }
}
