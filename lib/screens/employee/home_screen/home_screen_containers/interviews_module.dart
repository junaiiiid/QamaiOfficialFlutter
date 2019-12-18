import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/chat_module.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/interviews_module.dart';

class EmployeeInterviewCardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(Interviews).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> ChatContainers = [];
          var interviews = snapshot.data.documents;

          for (var interview in interviews) {
            if (interview.data['EmployeeID'] == userid) {
              var CandidateDetails = StreamBuilder(
                stream: Firestore.instance
                    .collection(UserInformation)
                    .document(interview.data['EmployerID'])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var userDocument = snapshot.data;
                    if (userDocument['EmployerProfile'] == 'Internship') {
                      return InterviewCandidateDetails(
                          'EmployerName',
                          'EmployerTitle',
                          InternshipInformation,
                          interview.data['EmployerID']);
                    } else {
                      {
                        return InterviewCandidateDetails(
                            'EmployerName',
                            'EmployerTitle',
                            WorkInformation,
                            interview.data['EmployerID']);
                      }
                    }
                  }
                  return Center();
                },
              );

              var ChatProfilePicture = StreamBuilder(
                stream: Firestore.instance
                    .collection(UserInformation)
                    .document(interview.data['EmployerID'])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var userDocument = snapshot.data;
                    if (userDocument['EmployerProfile'] == 'Internship') {
                      return InterviewChatProfilePicture(
                          InternshipInformation, interview.data['EmployerID']);
                    } else {
                      {
                        return InterviewChatProfilePicture(
                            WorkInformation, interview.data['EmployerID']);
                      }
                    }
                  }
                  return Center();
                },
              );

              var ChatContainer = InterviewChatContainers(
                ChatProfilePicture,
                CandidateDetails,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                            interview.documentID,
                            interview.data['EmployerID'],
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
