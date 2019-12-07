import 'package:flutter/material.dart';
import 'package:qamai_official/database/firebase.dart';
import 'constants.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password.dart';
import 'screens/signup_screen.dart';
import 'screens/signup_screen2.dart';
import 'screens/employee/home_screen/home_screen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'theme.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(Theme());
}

void Initialize() async {
  await FlutterStatusbarcolor.setStatusBarColor(QamaiThemeColor);
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  await FlutterStatusbarcolor.setNavigationBarColor(QamaiThemeColor);
  await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
}

class Theme extends StatefulWidget {
  @override
  _ThemeState createState() => _ThemeState();
}

class _ThemeState extends State<Theme> {
  @override
  void initState() {
    // TODO: implement initState
    Initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeService(),
        child: Builder(builder: (BuildContext context) {
          ThemeService themeService = Provider.of<ThemeService>(
              context, listen: true);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeService.currentTheme,
            initialRoute: SplashScreen.id,
            routes: {
              SplashScreen.id: (context) => SplashScreen(),
              WelcomeScreen.id: (context) => WelcomeScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
              SignupScreen.id: (context) => SignupScreen(),
              SignupScreen2.id: (context) => SignupScreen2(),
              HomeScreen.id: (context) => HomeScreen(),
              EmployerInitialize.id: (context) => EmployerInitialize(),
            },
          );
        }));
  }
}
