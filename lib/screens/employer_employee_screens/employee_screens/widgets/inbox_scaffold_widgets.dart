import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qamai_official/database/firebase_employer.dart';
import 'package:qamai_official/modules/strings/other_strings.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/widgets/chat_module.dart';
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/widgets/interviews_module.dart';
import 'package:qamai_official/widgets/button.dart';
import 'package:qamai_official/database/firebase_employee.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/widgets/review_cards.dart';

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
                    widget.employerprofile,
                    widget.userDocument['EmployerID'],
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

class CategoryIconReturner extends StatelessWidget {
  final data;

  CategoryIconReturner(this.data);

  @override
  Widget build(BuildContext context) {
    if (data['Category'] == 'Internship') {
      return Icon(
        Ionicons.getIconData('ios-school'),
        size: 25,
      );
    } else {
      return Icon(
        OMIcons.business,
        size: 25,
      );
    }
  }
}

//SENT

class SentList extends StatelessWidget {
  final document;

  SentList(this.document);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(UserInformation)
          .document(document)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;
          temp_jobs_list = List.from(userDocument['JobList']);

          List<SentCard> sent_card_list = [];

          for (var v in temp_jobs_list) {
            final sent_card = SentCard(
              SentName(v),
              SentDescription(v),
              SentRate(v),
              SentCategory(v),
              SentProfilePicture(v),
              (document == userid)
                  ? SentButton(v)
                  : DisabledButton(
                      color: LightGray,
                      text: 'APPLIED',
                    ),
            );

            sent_card_list.add(sent_card);
          }
          return ListView(
            children: sent_card_list,
          );
        } else {
          return Center(
            child: Text(
              'No offers sent',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          );
        }
      },
    );
  }
}

class SentName extends StatelessWidget {
  final JobID;

  SentName(this.JobID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Proposals')
            .document(JobID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userDocument = snapshot.data;
            final title = userDocument['EmployerName'];
            return Text(
              title,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            );
          } else {
            return Text(
              'LOADING...',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            );
          }
        });
  }
}

class SentCategory extends StatelessWidget {
  final JobID;

  SentCategory(this.JobID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Proposals')
            .document(JobID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userDocument = snapshot.data;
            final title = userDocument['Category'];
            return Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'LOADING...',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            );
          }
        });
  }
}

class SentDescription extends StatelessWidget {
  final JobID;

  SentDescription(this.JobID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Proposals')
            .document(JobID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userDocument = snapshot.data;
            final title = userDocument['ProposalDescription'];
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          } else {
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'LOADING...',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          }
        });
  }
}

class SentRate extends StatelessWidget {
  final JobID;

  SentRate(this.JobID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Proposals')
            .document(JobID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userDocument = snapshot.data;
            final title = userDocument['Rate'];
            return Padding(
              padding: EdgeInsets.all(35),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: QamaiGreen,
                ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(35),
              child: Text(
                'LOADING...',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: QamaiGreen,
                ),
              ),
            );
          }
        });
  }
}

class SentButton extends StatelessWidget {
  final JobID;

  SentButton(this.JobID);

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
            temp_jobs_list = List.from(userDocument['JobList']);

            if (temp_jobs_list.contains(JobID)) {
              return Button(
                color: Red,
                text: 'WITHDRAW',
                onpress: () {
                  RemoveJobs(JobID);
                },
              );
            } else {
              return DisabledButton(color: LightGray, text: 'WITHDRAWN');
            }
          } else {
            return DisabledButton(color: LightGray, text: 'WITHDRAWN');
          }
        });
  }
}

class SentProfilePicture extends StatelessWidget {
  final JobID;

  SentProfilePicture(this.JobID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('Proposals')
          .document(JobID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userDocument = snapshot.data;
          final employerprofile = userDocument['EmployerProfile'];
          final employerid = userDocument['EmployerID'];

          return ProposalProfilePicture(employerprofile, employerid);
        } else {
          return CircleAvatar(
            backgroundColor: QamaiThemeColor,
          );
        }
      },
    );
  }
}

class SentCard extends StatefulWidget {
  final NameWidget;
  final DescriptionWidget;
  final RateWidget;
  final CategoryWidget;
  final PictureWidget;
  final ButtonWidget;

  SentCard(this.NameWidget, this.DescriptionWidget, this.RateWidget,
      this.CategoryWidget, this.PictureWidget, this.ButtonWidget);

  @override
  _SentCardState createState() => _SentCardState();
}

class _SentCardState extends State<SentCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      child: widget.PictureWidget,
                    ),
                    widget.NameWidget,
                  ],
                ),
                widget.CategoryWidget,
              ],
            ),
            Divider(
              color: QamaiThemeColor,
            ),
            widget.DescriptionWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.ButtonWidget,
                widget.RateWidget,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//INTERVIEW

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
