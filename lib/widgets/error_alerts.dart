import 'package:flutter/material.dart';
import 'package:qamai_official/modules/strings/other_strings.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:qamai_official/database/firebase_employee.dart';
import 'package:giffy_dialog/giffy_dialog.dart';


void firebaseErrorAlerts(BuildContext context,String title,String text,Function navigate,{type=AlertType.warning}){
  Alert(
    style: AlertStyle(
      animationType: AnimationType.grow,
      backgroundColor: QamaiThemeColor,
      titleStyle: TextStyle(
        color: White,
        fontFamily: 'Raleway',
        fontSize: 20.0,
      ),
      descStyle: TextStyle(
        color: LightGray,
        fontFamily: 'Raleway',
        fontSize: 15.0,
      ),
      overlayColor: Colors.black54,
    ),
    context: context,
    type: type,
    title: title,
    desc: text,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style:
          TextStyle(color: White, fontSize: 15, fontFamily: 'Raleway'),
        ),
        onPressed: navigate,
        width: 120,
        color: QamaiGreen,
      )
    ],
  ).show();
}

void standardErrorAlert(BuildContext context,String title,String text,Function navigate,{type=AlertType.warning}){
  Alert(
    style: AlertStyle(
      animationType: AnimationType.grow,
      backgroundColor: QamaiThemeColor,
      titleStyle: TextStyle(
        color: White,
        fontFamily: 'Raleway',
        fontSize: 20.0,
      ),
      descStyle: TextStyle(
        color: LightGray,
        fontFamily: 'Raleway',
        fontSize: 15.0,
      ),
      overlayColor: Colors.black54,
    ),
    context: context,
    type: type,
    title: title,
    desc: text,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(
              color: White,
              fontSize: 15,
              fontFamily: 'Raleway'),
        ),
        onPressed: navigate,
        width: 120,
        color: QamaiGreen,
      )
    ],
  ).show();
}

void logoutalert(BuildContext context){
  Alert(
    style: AlertStyle(
      animationType: AnimationType.grow,
      backgroundColor: White,
      titleStyle: TextStyle(
        color: White,
        fontFamily: 'Montserrat',
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
      descStyle: TextStyle(
        color: LightGray,
        fontFamily: 'Montserrat',
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
      overlayColor: Colors.white54,
    ),
    context: context,
    type: AlertType.warning,
    title: Logouttitle,
    desc: Logoutext,
    buttons: [
      DialogButton(
        child: Text(
          "No",
          style: TextStyle(
            color: White,
            fontSize: 14,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () => Navigator.pop(context),
        width: 110,
        color: Red,
      ),
      DialogButton(
        child: Text(
          "Yes",
          style: TextStyle(
              color: White,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Raleway'),
        ),
        onPressed: () => LogOut(context),
        width: 110,
        color: QamaiGreen,
      )
    ],
  ).show();
}

void dialog(BuildContext context,String title,String text,String okbtn,String cancelbtn,image,Function navigate){
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AssetGiffyDialog(
        buttonOkColor: QamaiGreen,
        buttonOkText: Text(
          okbtn,
          style: TextStyle(
              color: White,
              fontFamily: 'Raleway',
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
        buttonCancelColor: Red,
        buttonCancelText: Text(
          cancelbtn,
          style: TextStyle(
              color: White,
              fontFamily: 'Raleway',
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
        cornerRadius: 10.0,
        image: image,
        title: Text(
          title,
          style: TextStyle(
              color: QamaiThemeColor,
              fontFamily: 'Montserrat',
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        description: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: QamaiThemeColor,
              fontFamily: 'Montserrat',
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
        onOkButtonPressed: navigate,
      ));
}