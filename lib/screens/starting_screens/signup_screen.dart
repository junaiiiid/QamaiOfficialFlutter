import 'package:flutter/material.dart';
import 'package:qamai_official/containers/modules/user_information.dart';
import 'package:qamai_official/containers/widgets/error_alerts.dart';
import 'package:qamai_official/containers/widgets/text_inputs.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:qamai_official/containers/modules/regular_expression.dart';
import 'signup_screen2.dart';
import 'package:gender_selector/gender_selector.dart';

String DateOfBirth = DOB;

class SignupScreen extends StatefulWidget {
  static String id = 'SignupScreen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      hint: FirstName,
                      passtext: false,
                      keyboard: TextInputType.text,
                      Max: 50,
                      onchanged: (value) {
                        bool Valid = Name_Exp.hasMatch(value);
                        if (Valid) {
                          setFirstName(value);
                        } else {
                          setFirstName(null);
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
                      hint: LastName,
                      passtext: false,
                      keyboard: TextInputType.text,
                      Max: 50,
                      onchanged: (value) {
                        bool Valid = Name_Exp.hasMatch(value);
                        if (Valid) {
                          setLastName(value);
                        } else {
                          setLastName(null);
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
                      hint: DateOfBirth,
                      passtext: false,
                      ontap: () {
                        DatePicker.showDatePicker(context,
                            onChanged: (date) {
                              setState(() {
                                DateOfBirth = DOB;
                              });
                            },
                            locale: LocaleType.en,
                            showTitleActions: true,
                            theme: DatePickerTheme(
                              doneStyle: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: QamaiGreen,
                              ),
                              backgroundColor: QamaiThemeColor,
                              itemStyle: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: QamaiGreen,
                              ),
                            ),
                            onConfirm: (date) {
                              setState(() {
                                DateOfBirth = date.toString().split(' ')[0];
                                setDOB(DateOfBirth);
                              });
                            });
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
                      enabled: false,
                      hint: CNIC,
                      passtext: false,
                      keyboard: TextInputType.number,
                      Max: 13,
                      onchanged: (value) {
                        bool Valid = CNIC_Exp.hasMatch(value);
                        if (Valid) {
                          setCNIC(value);
                        } else {
                          setCNIC(null);
                        }
                      },
                    ),
                  ),
                )),
              ],
            ),
            GenderSelector(
              margin: EdgeInsets.only(left: 10, top: 30, right: 10,),
              selectedGender: Gender.FEMALE,
              onChanged: (gender) async {
                if(gender==Gender.FEMALE)
                {
                  setGender('female');
                }
                else if(gender==Gender.MALE){
                  setGender('male');
                }
              },

            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
                child: Expanded(
              child: Center(
                child: Button(
                  color: BlackMaterial,
                  text: Next,
                  onpress: () {
                   if(getFirstName()==null ||
                       getLastName()==null ||
                       getDOB()==null ||
                       getCNIC()==null
                   )
                     {
                       standardErrorAlert(context, WarningDialogTitle, WarningDialogText, (){
                         Navigator.pop(context);
                       });
                     }
                   else
                     {
                       Navigator.pushNamed(context, SignupScreen2.id);
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
                    minFontSize: 6.0,
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
    );
  }
}
