import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/search_card.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/interviews_module.dart';

import '../../../../constants.dart';

class CandidatesForm extends StatelessWidget {
  final ProposalID, EmployerID;

  CandidatesForm(this.ProposalID, this.EmployerID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Ionicons.getIconData("ios-arrow-round-back"),
                    size: 40,
                    color: QamaiThemeColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            CandidatesFormHeader(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      body: CandidatesWidgetList(ProposalID, EmployerID),
    );
  }
}

class CandidatesFormHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AutoSizeText(
            'List of candidates',
            maxLines: 2,
            textAlign: TextAlign.center,
            minFontSize: 10.0,
            maxFontSize: 30.0,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 23.0,
              color: QamaiThemeColor,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, bottom: 10, right: 30, top: 15),
          child: AutoSizeText(
            'List of candidates who applied for this request',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 5.0,
              color: LightGray,
            ),
          ),
        ),
        Divider(
          color: QamaiThemeColor,
        ),
      ],
    );
  }
}

class CandidatesWidgetList extends StatelessWidget {
  final ProposalID, EmployerID;

  CandidatesWidgetList(this.ProposalID, this.EmployerID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(Proposals)
          .document(ProposalID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;

          List<String> Candidateslist =
              List.from(userDocument['CandidateList']);

          List<Widget> candidates_widgets = [];

          if (Candidateslist.isEmpty) {
            return Center(
              child: Text(
                'NO APPLICANTS YET',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: QamaiThemeColor),
              ),
            );
          } else {
            for (var candidate in Candidateslist) {
              candidates_widgets.add(StreamBuilder(
                stream: Firestore.instance
                    .collection(UserInformation)
                    .document(candidate)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var EmployeeID = candidate;

                    return CandidateCard(
                      SearchResultCards(
                          snapshot.data, 'FullName', 'Story', 1, candidate),
                      EmployeeID, EmployerID, ProposalID,
                    );
                  } else {
                    return Text('Loading');
                  }
                },
              ));
            }
            return ListView(
              children: candidates_widgets,
            );
          }
        } else {
          return Center(
            child: Text('No applicants yet'),
          );
        }
      },
    );
  }
}

class CandidateCard extends StatelessWidget {
  final search_result_card;
  final EmployeeID, EmployerID, ProposalID;

  CandidateCard(this.search_result_card,
      this.EmployeeID, this.EmployerID, this.ProposalID);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: QamaiThemeColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            search_result_card,
            InviteForInterviewButton(EmployeeID: EmployeeID,
              EmployerID: EmployerID,
              ProposalID: ProposalID,),
          ],
        ),
      ),
    );
  }
}
