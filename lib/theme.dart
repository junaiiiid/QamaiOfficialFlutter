import 'package:flutter/material.dart';
import 'constants.dart';

class ThemeService with ChangeNotifier {
  static final ThemeData themeA = ThemeData(
    primaryColor: QamaiThemeColor,
    scaffoldBackgroundColor: QamaiThemeColor,
    fontFamily: 'Raleway',
    hintColor: White,
    textSelectionColor: White,
    primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
    textTheme: Typography(platform: TargetPlatform.iOS).white,
    appBarTheme: AppBarTheme(
      color: BlackMaterial,
    ),
  );

  static final ThemeData themeB =
      ThemeData.light().copyWith(scaffoldBackgroundColor: White);

  ThemeData _currentTheme = themeA;

  get currentTheme => _currentTheme;

  switchToThemeA() {
    _currentTheme = themeA;
    notifyListeners();
  }

  switchToThemeB() {
    _currentTheme = themeB;
    notifyListeners();
  }
}
