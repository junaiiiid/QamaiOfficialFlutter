import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/modules/employer_information.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/form_textfields.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:qamai_official/containers/modules/regular_expression.dart';
import 'package:qamai_official/containers/widgets/error_alerts.dart';
import 'package:qamai_official/database/firebase.dart';

bool showSpinner;


class EmployerForm extends StatefulWidget {
  @override
  _EmployerFormState createState() => _EmployerFormState();
}

class _EmployerFormState extends State<EmployerForm> {

  @override
  void initState() {
    showSpinner = false;
    super.initState();
    setCategory('Internship');
    getUser();
    firestore
        .collection(UserInformation)
        .document(userid)
        .updateData({
      'ActiveProfile': 'Employee',
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        color: QamaiThemeColor,
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            EmployerFormHeader(),
            Padding(
              padding:
              const EdgeInsets.only(left: 30, bottom: 10, right: 30, top: 15),
              child: AutoSizeText(
                'What will you be providing?',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 5.0,
                  color: QamaiThemeColor,
                ),
              ),
            ),
            Center(
              child: ToggleSwitch(
                minWidth: 100.0,
                initialLabelIndex: 0,
                activeBgColor: QamaiThemeColor,
                activeTextColor: White,
                inactiveBgColor: VeryLightGray,
                inactiveTextColor: LightGray,
                labels: ['Internship', 'Job'],
                onToggle: (index) {
                  index == 0 ? setCategory('Internship') : setCategory('Job');
                },
              ),
            ),
            EmployerFormTextFields('Organization Name', (value) {
              setName(value);
            }, 25),
            EmployerFormTextFields('Designation Title', (value) {
              setTitle(value);
            }, 25),
            EmployerFormTextFields('Organization Email',
                    (value) {
                  bool Valid = Email_Exp.hasMatch(value);
                  if (Valid) {
                    setEmail(value);
                  } else {
                    if (value != '') {
                      setEmail(null);
                    }
                  }
                }, 320),
            EmployerFormBigTextFields('Organization Description', (value) {
              setDescription(value);
            }, 400),
            Button(
              color: QamaiThemeColor,
              text: 'REGISTER',
              onpress: () {
                if (getEmail() == null || getName() == null ||
                    getTitle() == null || getDescription() == null) {
                  //RegisterPressDetected(1);
                  standardErrorAlert(
                      context, WarningDialogTitle, WarningDialogText, () {
                    Navigator.pop(context);
                  });
                }
                else {
                  firestore
                      .collection(UserInformation)
                      .document(userid)
                      .updateData({
                    'ActiveProfile': 'Employer',
                  });
                  setState(() {
                    showSpinner = true;
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => RegisterEmployer()),);
                  //ClearAllInfo();
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}


class EmployerFormHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AutoSizeText(
            'Want to register as an Employer?',
            maxLines: 2,
            textAlign: TextAlign.center,
            minFontSize: 10.0,
            maxFontSize: 30.0,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 23.0,
              color: QamaiThemeColor,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, bottom: 10, right: 30, top: 15),
          child: AutoSizeText(
            'Provide the following details to register as an employer',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 5.0,
              color: LightGray,
            ),
          ),
        ),
        Divider(
          color: QamaiThemeColor,
        ),
      ],
    );
  }
}


