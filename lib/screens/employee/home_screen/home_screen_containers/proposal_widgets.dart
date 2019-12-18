import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/screens/employee/home_screen/profile_screen_scaffolds/inbox_scaffold.dart';
import 'package:qamai_official/screens/employee/home_screen/profile_screen_scaffolds/profile_scaffold.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/review_cards.dart';
import 'package:qamai_official/screens/employer/home_screen/profile_screen_scaffolds/profile_scaffold.dart';

//PROPOSALS

class ProposalsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('Proposals').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final proposals = snapshot.data.documents;
          List<ProposalCard> ProposalCardlist = [];
          for (var proposal in proposals) {
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
              ProposalButton(docRef),
              docRef,
              EmployerProfile,
              proposal,
            );

            ProposalCardlist.add(proposal_card);
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

class ProposalCard extends StatefulWidget {
  final EmloyerName;
  final ProposalDescription;
  final Rate;
  final Category;
  final DisplayPicture;
  final button;
  final docref;
  final userDocument;
  final employerprofile;

  ProposalCard(
      this.EmloyerName,
      this.ProposalDescription,
      this.Rate,
      this.Category,
      this.DisplayPicture,
      this.button,
      this.docref,
      this.employerprofile,
      this.userDocument);

  @override
  _ProposalCardState createState() => _ProposalCardState();
}

class _ProposalCardState extends State<ProposalCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: VeryLightGray,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: widget.DisplayPicture,
                      ),
                      Text(
                        widget.EmloyerName,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      widget.Category,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: QamaiThemeColor,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.ProposalDescription,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.button,
                  Padding(
                    padding: EdgeInsets.all(35),
                    child: Text(
                      widget.Rate,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProposalProfile(
                  widget.userDocument,
                  ProposalProfilePicture(
                    widget.employerprofile, widget.userDocument['EmployerID'],
                  ),
                  widget.button)),
        );
      },
    );
  }
}

class ProposalProfile extends StatelessWidget {
  final data;
  final PictureWidget;
  final button;

  ProposalProfile(this.data, this.PictureWidget, this.button);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: White,
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(260),
                child: Column(
                  children: <Widget>[
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
                    SizedBox(
                      height: 20,
                    ),
                    ProposalOverview(data, PictureWidget),
                    SizedBox(
                      height: 20,
                    ),
                    TabBar(
                      indicatorColor: QamaiGreen,
                      unselectedLabelColor: QamaiThemeColor,
                      labelColor: QamaiGreen,
                      tabs: [
                        Tab(
                          icon: CategoryIconReturner(data),
                        ),
                        Tab(
                          icon: Icon(
                            OMIcons.starBorder,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  JobDetails(
                    data: data,
                    button: button,
                  ),
                  NoReviews(),
                ],
              ),
            ),
          )),
    );
  }
}

class ProposalOverview extends StatelessWidget {
  final data;
  final PictureWidget;

  ProposalOverview(this.data, this.PictureWidget);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PictureWidget,
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: AutoSizeText(
                  '${data['EmployerName']}',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      color: QamaiThemeColor,
                      fontSize: 18.0),
                  minFontSize: 15,
                  maxFontSize: 18,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: AutoSizeText(
                  '${data['Category']}',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: QamaiThemeColor,
                      decoration: TextDecoration.underline,
                      fontSize: 12.0),
                  minFontSize: 10,
                  maxFontSize: 12,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class JobDetails extends StatelessWidget {
  final data;
  final button;

  const JobDetails({
    Key key,
    this.data,
    this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Job Description :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            '${data['ProposalDescription']}',
            style: TextStyle(
                fontFamily: 'Raleway', color: QamaiThemeColor, fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Rate :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '${data['Rate']}',
            style: TextStyle(
                fontFamily: 'Raleway', color: QamaiThemeColor, fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Location :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '${data['Location']}',
            style: TextStyle(
                fontFamily: 'Raleway', color: QamaiThemeColor, fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Timings :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '${data['Time']}',
            style: TextStyle(
                fontFamily: 'Raleway', color: QamaiThemeColor, fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Positions Avaliable :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '${data['Positions']}',
            style: TextStyle(
                fontFamily: 'Raleway', color: QamaiThemeColor, fontSize: 12.0),
          ),
        ),
        button,
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

//Button returner for ProposalSubmitter

class ProposalButton extends StatelessWidget {
  final Job;

  ProposalButton(this.Job);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(UserInformation)
            .document(userid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //var userDocument = snapshot.data;
            final List<String> jobs_list = List.from(snapshot.data['JobList']);
            if (jobs_list.contains(Job)) {
              return DisabledButton(
                text: 'APPLIED',
                color: LightGray,
              );
            } else {
              return Button(
                color: QamaiGreen,
                text: 'APPLY',
                onpress: () {
                  AddJobs(Job);
                  getJobsList();
                },
              );
            }
          } else {
            return DisabledButton(
              text: 'APPLIED',
              color: LightGray,
            );
          }
        });
  }
}

//Icon returner

