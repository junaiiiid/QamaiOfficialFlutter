import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/forgot_password.dart';
import 'package:qamai_official/screens/welcome_screen.dart';
import 'package:qamai_official/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/modules/user_information.dart';
import 'package:qamai_official/screens/home_screen/home_screen.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:qamai_official/containers/widgets/error_alerts.dart';
import 'package:qamai_official/containers/modules/alert_strings.dart';
import 'package:qamai_official/screens/login_screen.dart';
import 'package:provider/provider.dart';


final _Auth = FirebaseAuth.instance;
final firestore = Firestore.instance;
String pictureurl;


Future Register(BuildContext context) async {
  try {
    final newUser = await _Auth.createUserWithEmailAndPassword(
        email: getEmail(), password: getPass());

    FirebaseUser user = await _Auth.currentUser();

    firestore.collection(UserInformation).document(user.uid).setData({
      'CNIC': getCNIC(),
      'DOB': getDOB(),
      'Email': getEmail(),
      'FirstName': getFirstName(),
      'LastName': getLastName(),
      'Phone': getPhone(),
      'Story': story,
      'ProfilePicture': (getGender() == 'male') ? dpmale : dpfemale,
      'Gender': getGender(),
      'NumberVerified': false,
      'FullName': '${getFirstName()} ${getLastName()}',
      'JobList':[],
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
  ThemeService themeService = Provider.of<ThemeService>(context);
  try {
    FirebaseUser user = (await _Auth.signInWithEmailAndPassword(
        email: getEmail(), password: getPass()))
        .user;
    if (user.isEmailVerified) {
      themeService.switchToThemeB();
      Navigator.pushNamed(context, HomeScreen.id);
      //Navigator.pushNamed(context, HomeScreen.id);
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

  bool is_caught=false;

  try {
    final newUser =
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
  ThemeService themeService = Provider.of<ThemeService>(context);
  themeService.switchToThemeA();
  Navigator.pop(context);
  Navigator.pop(context);
  Navigator.pushNamed(context, WelcomeScreen.id);
}

Widget ExistingUser(BuildContext context) {
  return FutureBuilder<FirebaseUser>(
      future: _Auth.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data; // this is your user instance
          /// is because there is user already logged
          if (user.isEmailVerified) {
            return HomeScreen(
            );
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
  final newUser = await _Auth.sendPasswordResetEmail(email: user.email);

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
              'An Email has been sent to ${user.email} with instruction, on how to reset your password.',
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

//SEARCHER

class SearchService {


  searchPeople(String searchField) {
    return Firestore.instance
        .collection('UserInformation')
        .where('FullName', isGreaterThanOrEqualTo: searchField)
        .getDocuments();
  }

  searchJob(String searchField) {
    return Firestore.instance
        .collection('WorkInformation')
        .where('JobTitle', isGreaterThanOrEqualTo: searchField)
        .getDocuments();
  }

  searchInternship(String searchField) {
    return Firestore.instance
        .collection('InternshipInformation')
        .where('InternshipEmployerName', isGreaterThanOrEqualTo: searchField)
        .getDocuments();
  }
}

//UpdateJobsList returner

Future AddJobs(Job) async {

    firestore.collection(UserInformation).document(userid).updateData({
      'JobList': FieldValue.arrayUnion([Job]),
    });
}

//RemoveJobsList returner

Future RemoveJobs(Job) async {

  firestore.collection(UserInformation).document(userid).updateData({
    'JobList': FieldValue.arrayRemove([Job]),
  });
}
