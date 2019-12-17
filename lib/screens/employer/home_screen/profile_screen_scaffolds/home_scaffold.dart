import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import '../../../../theme.dart';

class EmployerHome extends StatefulWidget {
  @override
  _EmployerHomeState createState() => _EmployerHomeState();
}

class _EmployerHomeState extends State<EmployerHome> {
  @override
  void initState() {
    InitializeHome();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return EmployerHomeList();
  }
}

class EmployerProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: QamaiThemeColor,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Your Progress',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: QamaiGreen,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Ionicons.getIconData("ios-happy"),
                    size: 25,
                    color: QamaiGreen,
                  ),
                ),
              ],
            ),
            Divider(
              color: QamaiGreen,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 8.0,
                        percent: 1.0,
                        center: Text(
                          '100%',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: QamaiGreen,
                          ),
                        ),
                        progressColor: QamaiGreen,
                      ),
                      AutoSizeText(
                        'Response',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: QamaiGreen,
                        ),
                      ),
                      AutoSizeText(
                        'Rate',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: QamaiGreen,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 8.0,
                        percent: 0.2,
                        center: Text(
                          '20%',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Red,
                          ),
                        ),
                        progressColor: Red,
                      ),
                      AutoSizeText(
                        'Jobs',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Red,
                        ),
                      ),
                      AutoSizeText(
                        'Provided',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Red,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 8.0,
                        percent: 0.6,
                        center: Text(
                          '60%',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.orange,
                          ),
                        ),
                        progressColor: Colors.orange,
                      ),
                      AutoSizeText(
                        'Positive',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.orange,
                        ),
                      ),
                      AutoSizeText(
                        'Rating',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployerHomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        EmployerHomeProfileVerified(),
        EmployerProgressWidget(),
        EmployerHomeProgressReport(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class EmployerHomeProgressReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUser();
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(Proposals).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data.documents;

          int proposals = 0;
          int interviews = 0;

          for (var documents in userDocument) {
            if (documents.data['EmployerID'] == userid) {
              proposals++;
            }
          }

          return EmployerHomeProgressReportWidget(
            proposals: proposals,
            interviews: interviews,
          );
        } else {
          return EmployerHomeProgressReportWidget();
        }
      },
    );
  }
}

class EmployerHomeProgressReportWidget extends StatelessWidget {
  final proposals;
  final interviews;
  final rating;

  EmployerHomeProgressReportWidget(
      {this.proposals, this.interviews, this.rating = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Progress Report',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: QamaiThemeColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Ionicons.getIconData("ios-journal"),
                    size: 25,
                    color: QamaiThemeColor,
                  ),
                ),
              ],
            ),
            Divider(
              color: QamaiThemeColor,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: QamaiGreen,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              proposals.toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                fontSize: 60,
                                color: QamaiThemeColor,
                              ),
                            ),
                            AutoSizeText(
                              'Proposals Submitted',
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: QamaiThemeColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: QamaiGreen,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              interviews.toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                fontSize: 60,
                                color: QamaiThemeColor,
                              ),
                            ),
                            AutoSizeText(
                              'Interviews In Progress',
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: QamaiThemeColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: QamaiGreen,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              rating.toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                fontSize: 60,
                                color: QamaiThemeColor,
                              ),
                            ),
                            AutoSizeText(
                              'Overall Rating',
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: QamaiThemeColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployerHomeProfileVerifiedWidget extends StatelessWidget {
  final first_widget;
  final second_widget;
  final third_widget;

  EmployerHomeProfileVerifiedWidget(
      this.first_widget, this.second_widget, this.third_widget);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: VeryLightGray,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                first_widget,
                Container(
                    height: 80, child: VerticalDivider(color: QamaiThemeColor)),
                second_widget,
                Container(
                    height: 80, child: VerticalDivider(color: QamaiThemeColor)),
                third_widget,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmployerHomeProfileVerified extends StatelessWidget {
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

          var firstWidget;

          if (userDocument['EmployerProfile'] == 'Internship') {
            firstWidget = StreamBuilder(
              stream: Firestore.instance
                  .collection(InternshipInformation)
                  .document(userid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: QamaiThemeColor,
                          backgroundImage:
                              NetworkImage(snapshot.data['ProfilePicture']),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: Text(
                          snapshot.data['EmployerName'],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: QamaiThemeColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 12),
                        child: Text(
                          snapshot.data['EmployerTitle'],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: QamaiThemeColor,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: QamaiThemeColor,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: Text(
                          'LOADING...',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: QamaiThemeColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 12),
                        child: Text(
                          'LOADING...',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: QamaiThemeColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          } else if (userDocument['EmployerProfile'] == 'Job') {
            firstWidget = StreamBuilder(
              stream: Firestore.instance
                  .collection(WorkInformation)
                  .document(userid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: QamaiThemeColor,
                          backgroundImage:
                              NetworkImage(snapshot.data['ProfilePicture']),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: Text(
                          snapshot.data['EmployerName'],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: QamaiThemeColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 12),
                        child: Text(
                          snapshot.data['EmployerTitle'],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: QamaiThemeColor,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: QamaiThemeColor,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: Text(
                          'LOADING...',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: QamaiThemeColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 12),
                        child: Text(
                          'LOADING...',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: QamaiThemeColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }

          var secondWidget;

          var thirdWidget;

          if (userDocument['online']) {
            secondWidget = Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Ionicons.getIconData("ios-cloud-done"),
                    size: 60,
                    color: QamaiGreen,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Text(
                    'Providing',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: QamaiThemeColor,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Text(
                    'Work',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: QamaiThemeColor,
                    ),
                  ),
                ),
              ],
            );
          } else {
            secondWidget = Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Ionicons.getIconData("ios-cloud-outline"),
                    size: 60,
                    color: Red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Text(
                    'Not Providing',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: QamaiThemeColor,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Text(
                    'Work',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: QamaiThemeColor,
                    ),
                  ),
                ),
              ],
            );
          }

          if (userDocument['NumberVerified']) {
            thirdWidget = Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    OMIcons.verifiedUser,
                    color: QamaiGreen,
                    size: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Text(
                    'Number',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: QamaiThemeColor,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Text(
                    'Verified',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: QamaiThemeColor,
                    ),
                  ),
                ),
              ],
            );
          } else {
            thirdWidget = Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Ionicons.getIconData("ios-close-circle-outline"),
                    size: 60,
                    color: Red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Text(
                    'Number',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: QamaiThemeColor,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Text(
                    'Not Verified',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: QamaiThemeColor,
                    ),
                  ),
                ),
              ],
            );
          }

          return EmployerHomeProfileVerifiedWidget(
              firstWidget, secondWidget, thirdWidget);
        } else {
          return Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: VeryLightGray,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: QamaiThemeColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12),
                          child: Text(
                            'LOADING...',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: QamaiThemeColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Text(
                            'LOADING...',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: QamaiThemeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: 80,
                        child: VerticalDivider(color: QamaiThemeColor)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Ionicons.getIconData("ios-cloud-done"),
                            size: 60,
                            color: QamaiGreen,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12),
                          child: Text(
                            'LOADING...',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: QamaiThemeColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Text(
                            'LOADING...',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: QamaiThemeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: 80,
                        child: VerticalDivider(color: QamaiThemeColor)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            OMIcons.verifiedUser,
                            color: QamaiGreen,
                            size: 60,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12),
                          child: Text(
                            'LOADING...',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: QamaiThemeColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Text(
                            'LOADING...',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: QamaiThemeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
