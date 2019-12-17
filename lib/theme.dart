import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
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

void InitializeHome() {
  FlutterStatusbarcolor.setStatusBarColor(White);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  FlutterStatusbarcolor.setNavigationBarColor(QamaiThemeColor);
  FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
}

void InitializeWelcome() async {
  await FlutterStatusbarcolor.setStatusBarColor(QamaiThemeColor);
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  await FlutterStatusbarcolor.setNavigationBarColor(QamaiThemeColor);
  await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
}

void InitializeChatScreen() async {
  await FlutterStatusbarcolor.setStatusBarColor(QamaiThemeColor);
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  await FlutterStatusbarcolor.setNavigationBarColor(White);
  await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
}