import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:qamai_official/database/firebase_employee.dart';
import 'package:qamai_official/modules/strings/other_strings.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


void sendMail() async{
  final Email email = Email(
    body: '',
    subject: 'Request Information Change',
    recipients: ['info@qamaiofficial.com'],
    cc: ['qamaiofficial@gmail.com'],
    bcc: ['qamaiofficial@gmail.com'],
  );

  await FlutterEmailSender.send(email);
}

void PhoneVerification(BuildContext buildcontext) async{


  FlutterOtp object=FlutterOtp();

  object.generateOtp();

  FirebaseUser user = await FirebaseAuth.instance.currentUser();

  DocumentReference documentReference =
  Firestore.instance.collection(UserInformation).document(user.uid);
  documentReference.get().then((datasnapshot) {
    object.sendOtp(datasnapshot.data['Phone']);
    print(datasnapshot.data['Phone']);
  });


  Alert(
      style: AlertStyle(animationType: AnimationType.grow,overlayColor: Colors.white54,isCloseButton: false,
          titleStyle: TextStyle(color: QamaiThemeColor,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
              fontSize: 15)),
      context: buildcontext,
      title: 'Number Verification',
      image: Image.asset('images/lock.jpg',width: 200,),
      content: Column(
        children: <Widget>[
          Text(
            'Enter SMS verification code',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: QamaiThemeColor,
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10,),
          PinInputTextField(
            autoFocus: true,
            pinLength: 4,
            decoration: BoxTightDecoration(
              strokeColor: QamaiGreen,
              textStyle: TextStyle(color: QamaiThemeColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            onSubmit: (value){
              if(object.resultChecker(int.parse(value))==true)
              {
                firestore.collection('UserInformation').document(user.uid).updateData({
                  'NumberVerified': true,
                });
                Navigator.of(buildcontext).pop();
              }
              else{
                Alert(
                  style: AlertStyle(
                    animationType: AnimationType.grow,
                    backgroundColor: White,
                    titleStyle: TextStyle(
                      color: QamaiThemeColor,
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                    descStyle: TextStyle(
                      color: QamaiThemeColor,
                      fontFamily: 'Montserrat',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overlayColor: Colors.black54,
                  ),
                  context: buildcontext,
                  type: AlertType.error,
                  title: 'Verification Failed',
                  desc: 'Please try again, Make sure you are entering correct code.',
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Okay",
                        style: TextStyle(
                          color: White,
                          fontSize: 14,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => Navigator.pop(buildcontext),
                      width: 120,
                      color: QamaiGreen,
                    )
                  ],
                ).show();
              }
            },
          ),
        ],
      ),
      buttons: []).show();

}