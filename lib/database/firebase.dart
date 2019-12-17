import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qamai_official/containers/modules/employer_information.dart'
as employer;
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/starting_screens/forgot_password.dart';
import 'package:qamai_official/screens/starting_screens/welcome_screen.dart';
import 'package:qamai_official/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/modules/user_information.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:qamai_official/containers/widgets/error_alerts.dart';
import 'package:qamai_official/containers/modules/alert_strings.dart';
import 'package:qamai_official/screens/starting_screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen.dart'
as Employer;
import 'package:qamai_official/screens/employer/home_screen/employer_form.dart';

final _Auth = FirebaseAuth.instance;
final firestore = Firestore.instance;
String pictureurl;

Future Register(BuildContext context) async {
  try {
    final newUser = await _Auth.createUserWithEmailAndPassword(
        email: getEmail(), password: getPass());

    FirebaseUser user = await _Auth.currentUser();

    firestore.collection(UserInformation).document(user.uid).setData({
      'FullName': '${getFirstName()} ${getLastName()}',
      'FirstName': getFirstName(),
      'LastName': getLastName(),
      'Email': getEmail(),
      'Phone': getPhone(),
      'DOB': getDOB(),
      'CNIC': getCNIC(),
      'Gender': getGender(),
      'ProfilePicture': (getGender() == 'male') ? dpmale : dpfemale,
      'Story': story,
      'NumberVerified': false,
      'online': true,
      'EmployerProfile': '',
      'ActiveProfile': 'Employee',
      'JobList': [],
      'Interviews': [],
    });

    user = (await _Auth.signInWithEmailAndPassword(
        email: getEmail(), password: getPass()))
        .user;

    if (newUser != null) {
      user.sendEmailVerification();
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
        type: AlertType.success,
        title: RegistrationSuccess,
        desc: PleaseLogin,
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style:
              TextStyle(color: White, fontSize: 15, fontFamily: 'Raleway'),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              ClearAllInfo();
              //Navigator.pushNamed(context, LoginScreen.id);
            },
            width: 120,
            color: QamaiGreen,
          )
        ],
      ).show();
    }
  } on PlatformException catch (e) {
    switch (e.code) {
      case 'ERROR_WEAK_PASSWORD':
        firebaseErrorAlerts(context, WeakPasswordtitle, WeakPasswordtext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
          ClearAllInfo();
        });
        break;
      case 'ERROR_INVALID_EMAIL':
        firebaseErrorAlerts(context, InvalidRegEmailtitle, InvalidRegEmailtext,
                () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, WelcomeScreen.id);
              ClearAllInfo();
            });
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        firebaseErrorAlerts(
            context, EmailAlreadyUsedtitle, EmailAlreadyUsedtext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
          ClearAllInfo();
        });
        break;
    }
  }
}

Future LogIn(BuildContext context) async {
  try {
    FirebaseUser user = (await _Auth.signInWithEmailAndPassword(
        email: getEmail(), password: getPass()))
        .user;
    if (user.isEmailVerified) {
      //Navigator.pushNamed(context, HomeScreen.id);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RelevantHomeScreen()),
      );

      ClearAllInfo();
    } else {
      user.sendEmailVerification();
      firebaseErrorAlerts(context, VerifyEmailtitle, VerifyEmailtext, () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, LoginScreen.id);
        ClearAllInfo();
      });
    }
  } on PlatformException catch (e) {
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        firebaseErrorAlerts(context, InvalidEmailtitle, InvalidEmailtext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, LoginScreen.id);
          ClearAllInfo();
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        firebaseErrorAlerts(context, WrongPasswordtitle, WrongPasswordtext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, LoginScreen.id);
          ClearAllInfo();
        });
        break;
      case 'ERROR_USER_NOT_FOUND':
        firebaseErrorAlerts(context, UserNotFoundtitle, UserNotFoundtext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, LoginScreen.id);
          ClearAllInfo();
        });
        break;
      case 'ERROR_USER_DISABLED':
        firebaseErrorAlerts(context, UserDisabledtitle, UserDisabledtext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, LoginScreen.id);
          ClearAllInfo();
        });
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        firebaseErrorAlerts(context, ManyRequeststitle, ManyRequeststext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, LoginScreen.id);
          ClearAllInfo();
        });
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        firebaseErrorAlerts(context, NotEnabledtitle, NotEnabledtext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, LoginScreen.id);
          ClearAllInfo();
        });
        break;
    }
  }
}

Future ResetPassword(BuildContext context) async {
  bool is_caught = false;

  try {
    await _Auth.sendPasswordResetEmail(email: getRecoveryMail());
  } on PlatformException catch (e) {
    is_caught = true;
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        firebaseErrorAlerts(context, InvalidEmailtitle, InvalidEmailtext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, ForgotPasswordScreen.id);
          ClearAllInfo();
        }, type: AlertType.error);
        break;

      case 'ERROR_USER_NOT_FOUND':
        firebaseErrorAlerts(context, UserNotFoundtitle, UserNotFoundtext, () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, ForgotPasswordScreen.id);
          ClearAllInfo();
        }, type: AlertType.error);
        break;
    }
  }
  if (!is_caught) {
    firebaseErrorAlerts(context, ResestPasstitle, ResestPasstext, () {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, LoginScreen.id);
      ClearAllInfo();
    });
  }
}

Future LogOut(BuildContext context) async {
  await _Auth.signOut();
  Navigator.pop(context);
  Navigator.pushReplacementNamed(context, WelcomeScreen.id);
}

Widget ExistingUser(BuildContext context) {
  return FutureBuilder<FirebaseUser>(
      future: _Auth.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data; // this is your user instance
          /// is because there is user already logged
          if (user.isEmailVerified) {
            return RelevantHomeScreen();
          }
        }

        /// other way there is no user logged.
        return WelcomeScreen();
      });
}

Future Update(BuildContext context) async {
  try {
    FirebaseUser user = await _Auth.currentUser();
    return Alert(
        style: AlertStyle(
            animationType: AnimationType.grow,
            overlayColor: Colors.white54,
            titleStyle: TextStyle(
                color: QamaiThemeColor,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
                fontSize: 18)),
        context: context,
        title: storytitle,
        image: Image.network(
          pictureurl,
          width: 200,
        ),
        content: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setStory(value);
              },
              style: new TextStyle(color: QamaiThemeColor),
              decoration: InputDecoration(
                icon: Icon(
                  OMIcons.update,
                  color: QamaiGreen,
                ),
                labelText: storytext,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: LightGray,
                    fontSize: 14.0),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            child: Text(
              cancel,
              style: TextStyle(
                  color: White,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            width: 120,
            color: Red,
          ),
          DialogButton(
            child: Text(
              update,
              style: TextStyle(
                  color: White,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            onPressed: () async {
              if (getStory() != null) {
                await Future.delayed(Duration.zero, () {
                  firestore
                      .collection('UserInformation')
                      .document(user.uid)
                      .updateData({
                    'Story': getStory(),
                  });
                  Navigator.of(context).pop();
                });
              } else {
                setStory(storytext);
                await Future.delayed(Duration.zero, () {
                  firestore
                      .collection('UserInformation')
                      .document(user.uid)
                      .updateData({
                    'Story': getStory(),
                  });
                  Navigator.of(context).pop();
                });
              }
            },
            width: 120,
            color: QamaiGreen,
          ),
        ]).show();
  } catch (e) {
    print(e);
  }
}

Future PasswordChanger(BuildContext context) async {
  FirebaseUser user = await _Auth.currentUser();
  await _Auth.sendPasswordResetEmail(email: user.email);

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AssetGiffyDialog(
        onlyOkButton: true,
        buttonOkColor: QamaiGreen,
        buttonOkText: Text(
          'Okay',
          style: TextStyle(
              color: White,
              fontFamily: 'Raleway',
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        ),
        cornerRadius: 10.0,
        image: Image.asset(
          'images/Password2.png',
        ),
        title: Text(
          ResestPasstitle,
          style: TextStyle(
              color: QamaiThemeColor,
              fontFamily: 'Montserrat',
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        description: Text(
          'An Email has been sent to ${user
              .email} with instruction, on how to reset your password.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: QamaiThemeColor,
              fontFamily: 'Montserrat',
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ),
        onOkButtonPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ));
}

Future UpdateProfilePicture(BuildContext context, String url) async {
  FirebaseUser user = await _Auth.currentUser();

  firestore.collection('UserInformation').document(user.uid).updateData({
    'ProfilePicture': url,
  });
}

Future UpdateAvailability(bool value) async {
  getUser();
  firestore.collection('UserInformation').document(userid).updateData({
    'online': value,
  });
}


//UpdateJobsList returner

Future AddJobs(Job) async {
  getUser();

  firestore.collection(UserInformation).document(userid).updateData({
    'JobList': FieldValue.arrayUnion([Job]),
  });

  firestore.collection(ProposalsInformation).document(Job).updateData({
    'CandidateList': FieldValue.arrayUnion([userid]),
  });
}

//RemoveJobsList returner

Future RemoveJobs(Job) async {
  getUser();

  firestore.collection(UserInformation).document(userid).updateData({
    'JobList': FieldValue.arrayRemove([Job]),
  });

  firestore.collection(ProposalsInformation).document(Job).updateData({
    'CandidateList': FieldValue.arrayRemove([userid]),
  });
}

//EmployerEND

class RegisterEmployer extends StatelessWidget {
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
          if (userDocument['EmployerProfile'] == '') {
            if (employer.getCategory() == 'Internship') {
              getUser();
              firestore
                  .collection(UserInformation)
                  .document(userid)
                  .updateData({
                'EmployerProfile': 'Internship',
              });

              firestore
                  .collection(InternshipInformation)
                  .document(userid)
                  .setData({
                'EmployerName': employer.getName(),
                'EmployerTitle': employer.getTitle(),
                'EmployerEmail': employer.getEmail(),
                'EmployerDescription': employer.getDescription(),
                'ProfilePicture': dpinternship,
              });
              employer.ClearAllInfo();
            } else if (employer.getCategory() == 'Job') {
              getUser();
              firestore
                  .collection(UserInformation)
                  .document(userid)
                  .updateData({
                'EmployerProfile': 'Job',
              });

              firestore.collection(WorkInformation).document(userid).setData({
                'EmployerName': employer.getName(),
                'EmployerTitle': employer.getTitle(),
                'EmployerEmail': employer.getEmail(),
                'EmployerDescription': employer.getDescription(),
                'ProfilePicture': dpwork,
              });
              employer.ClearAllInfo();
            }

            return Employer.EmployerHomeScreen();
          } else {
            return Employer.EmployerHomeScreen();
          }
        } else {
          return Employer.EmployerHomeScreen();
        }
      },
    );
  }
}

class EmployerInitialize extends StatelessWidget {
  static String id = 'EmployerHomeScreen';

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
          if (userDocument['EmployerProfile'] == '') {
            return EmployerForm();
          } else {
            return Employer.EmployerHomeScreen();
          }
        } else {
          return Scaffold();
        }
      },
    );
  }
}

class RelevantHomeScreen extends StatelessWidget {
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
          if (userDocument['ActiveProfile'] == 'Employer') {
            return Employer.EmployerHomeScreen();
          } else {
            return HomeScreen();
          }
        } else {
          return HomeScreen();
        }
      },
    );
  }
}

Future UpdateEmployerProfilePicture(String url) async {
  getUser();
  DocumentReference documentReference =
  Firestore.instance.collection(UserInformation).document(userid);
  documentReference.get().then((datasnapshot) {
    if (datasnapshot.exists) {
      var userDocument = datasnapshot.data;
      if (userDocument['EmployerProfile'] == 'Internship') {
        firestore.collection(InternshipInformation).document(userid).updateData(
            {
              'ProfilePicture': url,
            });
      }
      else if (userDocument['EmployerProfile'] == 'Job') {
        firestore.collection(WorkInformation).document(userid).updateData({
          'ProfilePicture': url,
        });
      }
    }
  });
}

