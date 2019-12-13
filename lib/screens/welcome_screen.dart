import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:qamai_official/containers/widgets/image_slider.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import '../theme.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';


void Initialize(){
  FlutterStatusbarcolor.setStatusBarColor(QamaiThemeColor);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  FlutterStatusbarcolor.setNavigationBarColor(QamaiThemeColor);
  FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
}


class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ThemeService themeService = Provider.of<ThemeService>(context);
      themeService.switchToThemeA();
    });
    Initialize();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Image.asset('images/logo_small.png')),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(child: CarouselPage()),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: new Button(
                          color: QamaiGreen,
                          text: Login,
                          onpress: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          }),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(SignupText,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: QamaiGreen)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  }


