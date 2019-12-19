import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/database/firebase_employer.dart';
import 'package:qamai_official/modules/strings/other_strings.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:qamai_official/screens/employer_employee_screens/employee_screens/home_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:qamai_official/database/firebase_employee.dart';

void settings(BuildContext context) {
  Alert(
      style: AlertStyle(
        animationType: AnimationType.grow,
        backgroundColor: White,
        titleStyle: TextStyle(
          color: QamaiThemeColor,
          fontFamily: 'Raleway',
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
        descStyle: TextStyle(
          color: LightGray,
          fontFamily: 'Raleway',
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
        overlayColor: Colors.white54,
      ),
      context: context,
      title: "Settings",
      content: Column(
        children: <Widget>[
          Divider(
            color: QamaiThemeColor,
          ),
          SizedBox(
            height: 20,
          ),
          OnlineSwitch(),
          SizedBox(
            height: 20,
          ),
          ModeSwitch(),
        ],
      ),
      buttons: []).show();
}

class OnlineSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUser();
    return StreamBuilder(
      stream: Firestore.instance
          .collection(UserInformation)
          .document(userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;

          bool temp = userDocument['online'];

          return Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Availability',
                  style: TextStyle(
                    color: QamaiThemeColor,
                    fontFamily: 'Raleway',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                LiteRollingSwitch(
                  value: temp,
                  textOn: 'ONLINE',
                  textOff: 'OFFLINE',
                  colorOn: QamaiGreen,
                  colorOff: Red,
                  iconOn: Icons.done,
                  iconOff: Icons.remove_circle_outline,
                  textSize: 16.0,
                  onChanged: (bool state) {
                    UpdateAvailability(state);
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Availability',
                  style: TextStyle(
                    color: QamaiThemeColor,
                    fontFamily: 'Raleway',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUser();
    return StreamBuilder(
      stream: Firestore.instance
          .collection(UserInformation)
          .document(userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;

          if (userDocument['ActiveProfile'] == 'Employee') {
            return Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Switch Mode',
                    style: TextStyle(
                      color: QamaiThemeColor,
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ToggleSwitch(
                    minWidth: 90.0,
                    initialLabelIndex: 0,
                    activeBgColor: QamaiGreen,
                    activeTextColor: White,
                    inactiveBgColor: VeryLightGray,
                    inactiveTextColor: LightGray,
                    labels: ['Employee', 'Employer'],
                    onToggle: (index) {
                      if (index == 0) {
                        firestore
                            .collection(UserInformation)
                            .document(userid)
                            .updateData({
                          'ActiveProfile': 'Employee',
                        });
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      }
                      else {
                        firestore
                            .collection(UserInformation)
                            .document(userid)
                            .updateData({
                          'ActiveProfile': 'Employer',
                        });
                        Navigator.pushReplacementNamed(
                            context, EmployerInitialize.id);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Switch Mode',
                    style: TextStyle(
                      color: QamaiThemeColor,
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ToggleSwitch(
                    minWidth: 90.0,
                    initialLabelIndex: 1,
                    activeBgColor: QamaiGreen,
                    activeTextColor: White,
                    inactiveBgColor: VeryLightGray,
                    inactiveTextColor: LightGray,
                    labels: ['Employee', 'Employer'],
                    onToggle: (index) {
                      if (index == 0) {
                        firestore
                            .collection(UserInformation)
                            .document(userid)
                            .updateData({
                          'ActiveProfile': 'Employee',
                        });
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      } else {
                        firestore
                            .collection(UserInformation)
                            .document(userid)
                            .updateData({
                          'ActiveProfile': 'Employer',
                        });
                        Navigator.pushReplacementNamed(
                            context, EmployerInitialize.id);
                      }
                    },
                  ),
                ],
              ),
            );
          }
        } else {
          return Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Switch Mode',
                  style: TextStyle(
                    color: QamaiThemeColor,
                    fontFamily: 'Raleway',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
