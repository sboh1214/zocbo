import 'package:flutter/material.dart';

class Setting extends ChangeNotifier {
  Brightness brightness = Brightness.light;

  void changeBrightness() {
    brightness == Brightness.light
        ? brightness = Brightness.dark
        : brightness = Brightness.light;
    notifyListeners();
  }
}
