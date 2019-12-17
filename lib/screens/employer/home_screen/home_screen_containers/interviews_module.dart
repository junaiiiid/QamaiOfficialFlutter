import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/chat_module.dart';

void ConductInterview(EmployeeID, EmployerID, ProposalID) async {
  DocumentReference docRef =
      await firestore.collection(InterviewsInformation).add({
    'EmployeeID': EmployeeID,
    'EmployerID': EmployerID,
    'ProposalID': ProposalID,
        'Status': '',
      });

  DocumentReference proposals =
  Firestore.instance.collection(ProposalsInformation).document(ProposalID);

  proposals.get().then((datasnapshot) {
    if (datasnapshot.exists) {
      var document = datasnapshot.data;
      if (document['EmployerProfile'] == 'Internship') {
        DocumentReference employer = Firestore.instance
            .collection(InternshipInformation)
            .document(EmployerID);
        employer.get().then((datasnapshot) {
          if (datasnapshot.exists) {
            Firestore.instance
                .collection(InterviewsInformation)
                .document(docRef.documentID)
                .collection('Chat')
                .document()
                .setData({
              'MessageSender': datasnapshot.data['EmployerName'],
              'MessageText': document['ProposalDescription'],
              'CreatedAt': FieldValue.serverTimestamp(),
            });
          }
        });
      } else {
        DocumentReference employer =
        Firestore.instance.collection(WorkInformation).document(EmployerID);
        employer.get().then((datasnapshot) {
          if (datasnapshot.exists) {
            Firestore.instance
                .collection(InterviewsInformation)
                .document(docRef.documentID)
                .collection('Chat')
                .document()
                .setData({
              'MessageSender': datasnapshot.data['EmployerName'],
              'MessageText': document['ProposalDescription'],
              'CreatedAt': FieldValue.serverTimestamp(),
            });
          }
        });
      }
    }
  });

  firestore.collection(UserInformation).document(EmployeeID).updateData({
    'Interviews': FieldValue.arrayUnion([docRef.documentID]),
  });

  firestore.collection(ProposalsInformation).document(ProposalID).updateData({
    'Interviews': FieldValue.arrayUnion([docRef.documentID]),
  });
}

class InviteForInterviewButton extends StatelessWidget {
  final EmployerID, EmployeeID, ProposalID;

  InviteForInterviewButton({this.EmployeeID, this.EmployerID, this.ProposalID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(ProposalsInformation)
          .document(ProposalID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;
          if (List.from(userDocument['Interviews']).isEmpty) {
            return Button(
              color: QamaiGreen,
              text: "INVITE",
              onpress: () {
                ConductInterview(EmployeeID, EmployerID, ProposalID);
              },
            );
          } else {
            List temp = List.from(userDocument['Interviews']);
            return StreamBuilder(
              stream: Firestore.instance
                  .collection(UserInformation)
                  .document(EmployeeID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userDocument = snapshot.data;
                  if (List.from(userDocument['Interviews']).isEmpty) {
                    return Button(
                      color: QamaiGreen,
                      text: "INVITE",
                      onpress: () {
                        ConductInterview(EmployeeID, EmployerID, ProposalID);
                      },
                    );
                  } else {
                    for (var t in temp) {
                      if (List.from(userDocument['Interviews']).contains(t)) {
                        return DisabledButton(
                          text: 'INVITED',
                          color: LightGray,
                        );
                      }
                    }
                    return Button(
                      color: QamaiGreen,
                      text: "INVITE",
                      onpress: () {
                        ConductInterview(EmployeeID, EmployerID, ProposalID);
                      },
                    );
                  }
                } else {
                  return DisabledButton(
                    text: 'INVITED',
                    color: LightGray,
                  );
                }
              },
            );
          }
        } else {
          return DisabledButton(
            text: 'INVITED',
            color: LightGray,
          );
        }
      },
    );
  }
}

class InterviewCardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(InterviewsInformation).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> ChatContainers = [];
          var interviews = snapshot.data.documents;

          for (var interview in interviews) {
            if (interview.data['EmployerID'] == userid) {
              var CandidateDetails = InterviewCandidateDetails(
                  'FullName',
                  'Story',
                  UserInformation,
                  interview.data['EmployeeID']);

              var ChatProfilePicture = InterviewChatProfilePicture(
                  UserInformation, interview.data['EmployeeID']);

              var ChatContainer = InterviewChatContainers(
                ChatProfilePicture,
                CandidateDetails,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(
                                interview,
                                interview.data['EmployeeID'],
                                ChatProfilePicture,
                                CandidateDetails)),
                  );
                },
              );

              ChatContainers.add(ChatContainer);
            }
          }
          return ListView(
            children: ChatContainers,
          );
        }
        return Center(
          child: Text(
            'No Interviews Conducted',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: QamaiThemeColor),
          ),
        );
      },
    );
  }
}

class InterviewChatContainers extends StatelessWidget {
  final ProfilePicture, CandidateDetails, onPress;

  InterviewChatContainers(this.ProfilePicture, this.CandidateDetails,
      this.onPress);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: VeryLightGray,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ProfilePicture,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CandidateDetails,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      icon: Icon(
                        OMIcons.verifiedUser,
                        size: 30,
                        color: QamaiGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: onPress,
    );
  }
}

class InterviewChatProfilePicture extends StatelessWidget {
  final collection, document;

  InterviewChatProfilePicture(this.collection, this.document);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(collection)
          .document(document)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userdocument = snapshot.data;
          return CircleAvatar(
            radius: 40,
            backgroundColor: QamaiGreen,
            backgroundImage: NetworkImage('${userdocument['ProfilePicture']}'),
          );
        } else {
          return CircleAvatar(
            radius: 40,
            backgroundColor: QamaiGreen,
          );
        }
      },
    );
  }
}

class InterviewCandidateDetails extends StatelessWidget {
  final title, subtitle, collection, documentID;

  InterviewCandidateDetails(this.title, this.subtitle, this.collection,
      this.documentID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(collection)
          .document(documentID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userdocument = snapshot.data;
          return Column(
            children: <Widget>[
              Text(
                '${userdocument[title]}',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              Text(
                '${userdocument[subtitle]}',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 10,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: <Widget>[
              Text(
                'LOADING...',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              Text(
                'LOADING...',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
