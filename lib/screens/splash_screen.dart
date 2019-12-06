import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/screens/employer/home_screen/employer_form.dart';



class SplashScreen extends StatelessWidget {
  static String id = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
      imagePath: 'images/logo_mid.png',
      home: ExistingUser(context),
      duration: 2500,
      type: AnimatedSplashType.StaticDuration,
    );
  }
}
