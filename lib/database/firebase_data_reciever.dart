import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/screens/home_screen/home_screen_containers/proposal_widgets.dart';

//PUBLIC VARIABLES

String userid;

List<String> temp_jobs_list = [];

//CARD BUILDER

class CardBuilder extends StatefulWidget {
  final String title;
  final String text;
  final IconData icon;

  CardBuilder({Key key, this.title, this.text, this.icon}) : super(key: key);

  @override
  _CardBuilderState createState() => _CardBuilderState();
}

class _CardBuilderState extends State<CardBuilder> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(UserInformation)
            .document(userid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userDocument = snapshot.data;
            final title = userDocument[widget.text];
            return Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListTile(
                  leading: Icon(widget.icon, color: QamaiGreen, size: 20.0),
                  title: AutoSizeText(
                    '${widget.title} :   $title',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: QamaiThemeColor,
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    maxFontSize: 15,
                    minFontSize: 9,
                  ),
                ));
          } else {
            return Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListTile(
                  leading: Icon(widget.icon, color: QamaiGreen, size: 20.0),
                  title: AutoSizeText(
                    'LOADING...',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: QamaiThemeColor,
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    maxFontSize: 15,
                    minFontSize: 9,
                  ),
                ));
          }
        });
  }
}

//NAME RETURNER

class FirebaseName extends StatefulWidget {
  @override
  _FirebaseNameState createState() => _FirebaseNameState();
}

class _FirebaseNameState extends State<FirebaseName> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(UserInformation)
            .document(userid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userDocument = snapshot.data;
            final title = userDocument['FullName'];
            return AutoSizeText(
              '$title',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  color: QamaiThemeColor,
                  fontSize: 18.0),
              minFontSize: 15,
              maxFontSize: 18,
              maxLines: 1,
            );
          } else {
            return AutoSizeText(
              'LOADING...',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  color: QamaiThemeColor,
                  fontSize: 18.0),
              minFontSize: 15,
              maxFontSize: 18,
              maxLines: 1,
            );
          }
        });
  }
}

//STORY RETURNER

class FirebaseStory extends StatefulWidget {
  @override
  _FirebaseStoryState createState() => _FirebaseStoryState();
}

class _FirebaseStoryState extends State<FirebaseStory> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(UserInformation)
            .document(userid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userDocument = snapshot.data;
            final title = userDocument['Story'];
            return AutoSizeText(
              '$title',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: QamaiThemeColor,
                  decoration: TextDecoration.underline,
                  fontSize: 12.0),
              minFontSize: 10,
              maxFontSize: 12,
              maxLines: 1,
            );
          } else {
            return AutoSizeText(
              'LOADING...',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: QamaiThemeColor,
                  decoration: TextDecoration.underline,
                  fontSize: 12.0),
              minFontSize: 10,
              maxFontSize: 12,
              maxLines: 1,
            );
          }
        });
  }
}

//PROFILE PICTURE RETURNER

class FirebaseProfilePicture extends StatefulWidget {
  @override
  _FirebaseProfilePictureState createState() => _FirebaseProfilePictureState();
}

class _FirebaseProfilePictureState extends State<FirebaseProfilePicture> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(UserInformation)
            .document(userid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userDocument = snapshot.data;
            final title = userDocument['ProfilePicture'];
            return CircleAvatar(
              minRadius: 30,
              maxRadius: 60,
              backgroundImage: NetworkImage('$title'),
              backgroundColor: QamaiGreen,
            );
          } else {
            return CircleAvatar(
              minRadius: 30,
              maxRadius: 60,
              backgroundColor: QamaiGreen,
            );
          }
        });
  }
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
  final Category;
  final EmployerID;

  ProposalProfilePicture(this.Category, this.EmployerID);

  @override
  Widget build(BuildContext context) {
    if (Category == 'Job') {
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
    } else if (Category == 'Internship') {
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
              );
            } else {
              return CircleAvatar(
                backgroundColor: QamaiThemeColor,
              );
            }
          });
    }
  }
}
