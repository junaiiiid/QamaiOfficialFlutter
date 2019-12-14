import 'package:flutter/material.dart';
import 'package:qamai_official/containers/widgets/text_inputs.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:qamai_official/containers/modules/regular_expression.dart';
import 'package:qamai_official/containers/modules/user_information.dart';
import 'package:qamai_official/containers/widgets/error_alerts.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

String PasswordMatcher;
bool showSpinner;

class SignupScreen2 extends StatefulWidget {
  static String id = 'SignupScreen2';
  @override
  _SignupScreen2State createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  @override
  void initState() {
    // TODO: implement initState
    showSpinner=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: QamaiThemeColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Center(child: Image.asset('images/logo_mid.png')))),
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
                        passtext: false,
                        keyboard: TextInputType.emailAddress,
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
                          hint: Phone,
                          passtext: false,
                          keyboard: TextInputType.number,
                          Max: 11,
                          onchanged: (value) {
                            bool Valid = MobileNumber_Exp.hasMatch(value);
                            if (Valid) {
                              setPhone(value);
                            } else {
                              setPhone(null);
                            }
                          }),
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
                        passtext: true,
                        keyboard: TextInputType.text,
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
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                      child: TextInput(
                        hint: RPassword,
                        passtext: true,
                        keyboard: TextInputType.text,
                        Max: 15,
                        onchanged: (value) {
                          if (value == getPass()) {
                            PasswordMatcher = getPass();
                          } else {
                            PasswordMatcher = '0';
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
              SizedBox(
                height: 20.0,
              ),
              Container(
                  child: Expanded(
                child: Center(
                  child: Button(
                    color: BlackMaterial,
                    text: Signup,
                    onpress: () {
                      if (getEmail() == null ||
                          getPhone() == null ||
                          getPass() == null ||
                          PasswordMatcher != getPass()) {
                        setState(() {
                          showSpinner=true;
                        });

                        standardErrorAlert(context, WarningDialogTitle, WarningDialogText, (){
                          Navigator.pop(context);
                          setState(() {
                            showSpinner=false;
                          });
                        });
                      }
                      else
                        {
                          setState(() {
                            showSpinner=true;
                          });
                          Register(context);
                        }
                    },
                  ),
                ),
              )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                  child: Center(
                    child: AutoSizeText(
                      TOS,
                      maxLines: 1,
                      minFontSize: 5.0,
                      maxFontSize: 9.0,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 9.0,
                        color: QamaiGreen,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
