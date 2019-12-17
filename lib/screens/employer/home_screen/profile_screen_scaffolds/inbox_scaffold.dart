import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/proposal_widgets.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/candidates_form.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/interviews_module.dart';
import 'package:qamai_official/screens/employer/home_screen/proposal_form.dart';
import '../../../../theme.dart';

class EmployerInbox extends StatefulWidget {
  @override
  _EmployerInboxState createState() => _EmployerInboxState();
}

class _EmployerInboxState extends State<EmployerInbox> {
  @override
  void initState() {
    InitializeHome();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Column(
              children: <Widget>[
                TabBar(
                  indicatorColor: QamaiGreen,
                  unselectedLabelColor: QamaiThemeColor,
                  labelColor: QamaiGreen,
                  tabs: [
                    Tab(
                      child: Text(
                        'New',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Submitted',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Recieved',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Interviews',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              NewProposal(),
              SubmittedProposalsList(userid),
              RecievedProposalsList(),
              InterviewCardsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class NewProposal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Icon(
                Ionicons.getIconData("ios-clipboard"),
                color: QamaiGreen,
                size: 100,
              ),
            ),
            Align(
              alignment: Alignment(0.25, -0.20),
              child: Icon(
                Ionicons.getIconData("ios-add-circle"),
                color: QamaiThemeColor,
                size: 25,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProposalForm()),
          );
        },
      ),
    );
  }
}

class SubmittedProposalsList extends StatelessWidget {
  final document;

  SubmittedProposalsList(this.document);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(ProposalsInformation).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final proposals = snapshot.data.documents;

          getUser();

          List<ProposalCard> ProposalCardlist = [];
          for (var proposal in proposals) {
            if (proposal['EmployerID'] == document) {
              final EmployerName = proposal.data['EmployerName'];
              final ProposalDescription = proposal.data['ProposalDescription'];
              final Rate = proposal.data['Rate'];
              final Category = proposal.data['Category'];
              final EmployerProfile = proposal.data['EmployerProfile'];
              final EmployerID = proposal.data['EmployerID'];

              final docRef = proposal.documentID;

              final proposal_card = ProposalCard(
                EmployerName,
                ProposalDescription,
                Rate,
                Category,
                ProposalProfilePicture(EmployerProfile, EmployerID),
                (document == userid)
                    ? DeleteProposalButton(docRef)
                    : DisabledButton(color: LightGray, text: 'POSTED',),
                docRef,
                EmployerProfile,
                proposal,
              );

              ProposalCardlist.add(proposal_card);
            }
          }
          return ListView(
            children: ProposalCardlist,
          );
        } else {
          return ListView(
            children: <Widget>[
              ProposalCard(
                'LOADING...',
                'LOADING...',
                'LOADING...',
                'LOADING...',
                CircleAvatar(
                  backgroundColor: QamaiThemeColor,
                ),
                DisabledButton(
                  text: 'APPLIED',
                  color: LightGray,
                ),
                '',
                '',
                '',
              ),
            ],
          );
        }
      },
    );
  }
}

class RecievedProposalsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(ProposalsInformation).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final proposals = snapshot.data.documents;

          getUser();

          List<ProposalCard> ProposalCardlist = [];
          for (var proposal in proposals) {
            if (proposal['EmployerID'] == userid) {
              final EmployerName = proposal.data['EmployerName'];
              final ProposalDescription = proposal.data['ProposalDescription'];
              final Rate = proposal.data['Rate'];
              final Category = proposal.data['Category'];
              final EmployerProfile = proposal.data['EmployerProfile'];
              final EmployerID = proposal.data['EmployerID'];

              final ProposalID = proposal.documentID;

              final proposal_card = ProposalCard(
                EmployerName,
                ProposalDescription,
                Rate,
                Category,
                ProposalProfilePicture(EmployerProfile, EmployerID),
                ViewCandidatesButton(ProposalID, EmployerID),
                ProposalID,
                EmployerProfile,
                proposal,
              );

              ProposalCardlist.add(proposal_card);
            }
          }
          return ListView(
            children: ProposalCardlist,
          );
        } else {
          return ListView(
            children: <Widget>[
              ProposalCard(
                'LOADING...',
                'LOADING...',
                'LOADING...',
                'LOADING...',
                CircleAvatar(
                  backgroundColor: QamaiThemeColor,
                ),
                DisabledButton(
                  text: 'APPLIED',
                  color: LightGray,
                ),
                '',
                '',
                '',
              ),
            ],
          );
        }
      },
    );
  }
}

class DeleteProposalButton extends StatelessWidget {
  final Proposal;

  DeleteProposalButton(this.Proposal);

  @override
  Widget build(BuildContext context) {
    return Button(
      color: Red,
      text: 'DELETE',
      onpress: () {
        DeleteProposal(Proposal);
        RemoveJobs(Proposal);
      },
    );
  }
}

class ViewCandidatesButton extends StatelessWidget {
  final ProposalID, EmployerID;

  ViewCandidatesButton(this.ProposalID, this.EmployerID);

  @override
  Widget build(BuildContext context) {
    return Button(
      color: QamaiGreen,
      text: 'CANDIDATES',
      onpress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CandidatesForm(ProposalID, EmployerID)),
        );
      },
    );
  }
}

void DeleteProposal(var docref) {
  Firestore.instance.collection(ProposalsInformation).document(docref).delete();
}






