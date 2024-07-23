import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = "en";
  ThemeMode themeMode = ThemeMode.light;

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeMode(ThemeMode newMode) {
    if (themeMode == newMode) {
      return;
    }
    themeMode = newMode;
    notifyListeners();
  }

  bool isDark() {
    return themeMode == ThemeMode.dark;
  }
}
