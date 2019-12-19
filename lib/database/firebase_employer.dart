import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/modules/setget/employer_setget.dart' as employer;
import 'package:qamai_official/modules/strings/other_strings.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:qamai_official/screens/employer_employee_screens/employee_screens/home_screen.dart';
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/home_screen.dart'
    as Employer;
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/widgets/register_as_employer_form.dart';

import 'firebase_employee.dart';
//UpdateJobsList returner

Future AddJobs(Job) async {
  getUser();

  firestore.collection(UserInformation).document(userid).updateData({
    'JobList': FieldValue.arrayUnion([Job]),
  });

  firestore.collection(Proposals).document(Job).updateData({
    'CandidateList': FieldValue.arrayUnion([userid]),
  });
}

//RemoveJobsList returner

Future RemoveJobs(Job) async {
  getUser();

  firestore.collection(UserInformation).document(userid).updateData({
    'JobList': FieldValue.arrayRemove([Job]),
  });

  firestore.collection(Proposals).document(Job).updateData({
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
        firestore
            .collection(InternshipInformation)
            .document(userid)
            .updateData({
          'ProfilePicture': url,
        });
      } else if (userDocument['EmployerProfile'] == 'Job') {
        firestore.collection(WorkInformation).document(userid).updateData({
          'ProfilePicture': url,
        });
      }
    }
  });
}

//PUBLIC VARIABLES INITIALIZATION

void getUser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  userid = user.uid;
}

void getJobsList() async {
  DocumentReference documentReference =
      Firestore.instance.collection(UserInformation).document(userid);
  DocumentSnapshot documentSnapshot = await documentReference.get();

  temp_jobs_list = List.from(documentSnapshot.data['JobList']);

  print(temp_jobs_list);
}

//ProfilePictureReturner for ProposalSubmitter

class ProposalProfilePicture extends StatelessWidget {
  final EmployerProfile;
  final EmployerID;

  final radius;

  ProposalProfilePicture(this.EmployerProfile, this.EmployerID,
      {this.radius = 20.0});

  @override
  Widget build(BuildContext context) {
    if (EmployerProfile == 'Job') {
      return StreamBuilder(
          stream: Firestore.instance
              .collection('WorkInformation')
              .document(EmployerID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userDocument = snapshot.data;
              final title = userDocument['ProfilePicture'];
              return CircleAvatar(
                backgroundImage: NetworkImage('$title'),
                backgroundColor: QamaiThemeColor,
              );
            } else {
              return CircleAvatar(
                backgroundColor: QamaiThemeColor,
              );
            }
          });
    } else if (EmployerProfile == 'Internship') {
      return StreamBuilder(
          stream: Firestore.instance
              .collection('InternshipInformation')
              .document(EmployerID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userDocument = snapshot.data;
              final title = userDocument['ProfilePicture'];
              return CircleAvatar(
                backgroundImage: NetworkImage('$title'),
                backgroundColor: QamaiThemeColor,
                radius: radius,
              );
            } else {
              return CircleAvatar(
                backgroundColor: QamaiThemeColor,
                radius: radius,
              );
            }
          });
    }
  }
}
