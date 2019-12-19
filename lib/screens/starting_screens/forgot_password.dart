import 'package:flutter/material.dart';
import 'package:qamai_official/modules/setget/user_setget.dart';
import 'package:qamai_official/modules/strings/other_strings.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:qamai_official/widgets/text_inputs.dart';
import 'package:qamai_official/widgets/button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:qamai_official/modules/strings/regular_expression.dart';
import 'package:qamai_official/database/firebase_employee.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qamai_official/screens/starting_screens/login_screen.dart';


class ForgotPasswordScreen extends StatefulWidget {
  static String id = 'ForgotPassword';
  bool showSpinner;
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  @override
  void initState() {
    // TODO: implement initState
    showSpinner=false;
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
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Center(child: Image.asset('images/image_6.png')))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Expanded(
                          child: AutoSizeText(
                            FP1,
                            maxLines: 1,
                            minFontSize: 10.0,
                            maxFontSize: 30.0,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: LightGray,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 28.0, right: 28.0),
                            child: AutoSizeText(
                              FP2,
                              maxLines: 3,
                              minFontSize: 4.0,
                              maxFontSize: 20.0,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal,
                                fontSize: 20.0,
                                color: LightGray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextInput(
                            hint: email,
                            passtext: false,
                            keyboard: TextInputType.emailAddress,
                            Max: 62,
                            onchanged:(value){
                              bool Valid = Email_Exp.hasMatch(value);
                              if(Valid)
                              {
                                setRecoveryMail(value);
                              }
                              else{
                                setRecoveryMail(null);
                              }
                            },
                          ),
                        ),
                      )),
                ],
              ),
//            SizedBox(
//              height: 20.0,
//            ),
              Container(
                child: Expanded(
                  child: Center(
                      child: Button(
                        color: QamaiGreen,
                        text: Submit,
                        onpress: (){
                          setState(() {
                            showSpinner=true;
                          });
                          ResetPassword(context);
                        },
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
