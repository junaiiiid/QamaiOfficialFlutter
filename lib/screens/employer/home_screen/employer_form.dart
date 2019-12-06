import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/form_textfields.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EmployerForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          EmployerFormHeader(),
          EmployerFormBody(),
        ],
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

class EmployerFormBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
        ToggleSwitch(
          minWidth: 100.0,
          initialLabelIndex: 0,
          activeBgColor: QamaiThemeColor,
          activeTextColor: White,
          inactiveBgColor: VeryLightGray,
          inactiveTextColor: LightGray,
          labels: ['Internship', 'Work'],
          onToggle: (index) {
            print('switched to: $index');
          },
        ),
        EmployerFormTextFields('Organization Name', (value) {}, 25),
        EmployerFormTextFields('Designation Title', (value) {}, 25),
        EmployerFormTextFields('Organization Email', (value) {}, 25),
        EmployerFormBigTextFields('Organization Description', (value) {}, 100),
        Button(
          color: QamaiThemeColor,
          text: 'REGISTER',
          onpress: () {},
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
