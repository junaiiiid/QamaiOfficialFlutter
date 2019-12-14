import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/database/firebase.dart';

void ConductInterview(EmployeeID, EmployerID, ProposalID) async {
  DocumentReference docRef =
      await firestore.collection(InterviewsInformation).add({
    'EmployeeID': EmployeeID,
    'EmployerID': EmployerID,
    'ProposalID': ProposalID,
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
