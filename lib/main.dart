import 'package:flutter/material.dart';
import 'package:qamai_official/screens/employer_employee_screens/employee_screens/home_screen.dart';
import 'database/firebase_employer.dart';
import 'modules/themes/theme.dart';
import 'screens/starting_screens/splash_screen.dart';
import 'screens/starting_screens/welcome_screen.dart';
import 'screens/starting_screens/login_screen.dart';
import 'screens/starting_screens/forgot_password.dart';
import 'screens/starting_screens/signup_screen.dart';
import 'screens/starting_screens/signup_screen2.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(Theme());
}


class Theme extends StatefulWidget {
  @override
  _ThemeState createState() => _ThemeState();
}

class _ThemeState extends State<Theme> {
  @override
  void initState() {
    // TODO: implement initState
    InitializeWelcome();
    getUser();
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
