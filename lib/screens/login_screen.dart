import 'package:flutter/material.dart';
import 'package:qamai_official/containers/widgets/error_alerts.dart';
import 'package:qamai_official/containers/widgets/text_inputs.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/database/firebase.dart';
import 'forgot_password.dart';
import 'package:qamai_official/containers/modules/regular_expression.dart';
import 'package:qamai_official/containers/modules/user_information.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool showSpinner;

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    showSpinner = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        color: QamaiThemeColor,
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Container(
                      child:
                          Center(child: Image.asset('images/logo_mid.png')))),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                      child: TextInput(
                        hint: Email,
                        keyboard: TextInputType.emailAddress,
                        passtext: false,
                        Max: 62,
                        onchanged: (value) {
                          bool Valid = Email_Exp.hasMatch(value);
                          if (Valid) {
                            setEmail(value);
                          } else {
                            if (value != '') {
                              setEmail(null);
                            }
                          }
                        },
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                      child: TextInput(
                        hint: Password,
                        keyboard: TextInputType.text,
                        passtext: true,
                        Max: 15,
                        onchanged: (value) {
                          bool Valid = Password_Exp.hasMatch(value);
                          if (Valid) {
                            setPass(value);
                          } else {
                            setPass(null);
                          }
                        },
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  child: Expanded(
                child: Center(
                  child: Button(
                    color: QamaiGreen,
                    text: Login,
                    onpress: () {
                      setState(() {
                        showSpinner = true;
                      });
                      if (getEmail() == null || getPass() == null) {
                        setState(() {
                          showSpinner = false;
                        });

                        standardErrorAlert(context, WarningDialogTitle, WarningDialogText,() {
                          Navigator.pop(context);
                          setState(() {
                            showSpinner=false;
                          });
                        });

                      } else {
                        setState(() {
                          showSpinner = true;
                        });
                        LogIn(context);
                      }
                    },
                  ),
                ),
              )),
              Center(
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, ForgotPasswordScreen.id);
                  },
                  child: Text(ForgotPassword,
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: QamaiGreen)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

