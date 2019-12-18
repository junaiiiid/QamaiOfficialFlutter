import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/containers/widgets/error_alerts.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/database/phone_and_email.dart';
import 'package:qamai_official/screens/employee/home_screen/profile_screen_scaffolds/profile_scaffold.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/profile_overview.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/review_cards.dart';

import '../../../../theme.dart';
import 'inbox_scaffold.dart';

class EmployerProfile extends StatefulWidget {
  EmployerProfile({Key key}) : super(key: key);

  @override
  _EmployerProfileState createState() => _EmployerProfileState();
}

class _EmployerProfileState extends State<EmployerProfile> {
  @override
  void initState() {
    InitializeHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(180),
            child: Column(
              children: <Widget>[
                EmployerProfileOverview(),
                TabBar(
                  indicatorColor: QamaiGreen,
                  unselectedLabelColor: QamaiThemeColor,
                  labelColor: QamaiGreen,
                  tabs: [
                    Tab(
                      icon: WorkIconReturner(),
                    ),
                    Tab(
                      icon: Icon(
                        OMIcons.assignment,
                        size: 25,
                      ),
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
              EmployerDetailsList(),
              EmployerWork(userid),
              EmployerReviews(userid),
            ],
          ),
        ),
      ),
    );
  }
}


class NoProposal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
            color: QamaiGreen,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListTile(
              leading: Icon(OMIcons.clear, color: QamaiThemeColor, size: 20.0),
              title: AutoSizeText(
                'No Proposals Submitted',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: QamaiThemeColor,
                    fontSize: 15.0),
                maxLines: 1,
                maxFontSize: 15,
                minFontSize: 9,
              ),
            )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

Widget EmployerWork(var document) {
  if (document == null) {
    document = userid;
  }


  return StreamBuilder<QuerySnapshot>(
    stream: firestore.collection(Proposals).snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final userdocument = snapshot.data.documents;

        for (var documents in userdocument) {
          if (documents['EmployerID'] == document) {
            return SubmittedProposalsList(document);
          }
        }
        return NoProposal();
      }
      else {
        return WorkList();
      }
    },
  );
}


class WorkIconReturner extends StatelessWidget {
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
          if (userDocument['EmployerProfile'] == 'Job') {
            return Icon(
              OMIcons.business,
              size: 25,
            );
          } else {
            return Icon(
              Ionicons.getIconData('ios-school'),
              size: 25,
            );
          }
        } else {
          return Icon(
            OMIcons.business,
            size: 25,
          );
        }
      },
    );
  }
}

class CardReturner extends StatelessWidget {

  final firebasedata;
  final text;
  final icon;

  CardReturner(this.firebasedata, this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection(UserInformation)
          .document(userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;
          if (userDocument['EmployerProfile'] == 'Job') {
            return StreamBuilder(
                stream: Firestore.instance.collection(WorkInformation).document(
                    userid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Card(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: ListTile(
                          leading: Icon(icon, color: QamaiGreen, size: 20.0),
                          title: AutoSizeText(
                            '${text} :   ${snapshot.data[firebasedata]}',
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
                  else {
                    return Card(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: ListTile(
                          leading: Icon(icon, color: QamaiGreen, size: 20.0),
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
                }
            );
          }
          else {
            return StreamBuilder(
                stream: Firestore.instance.collection(InternshipInformation)
                    .document(userid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Card(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: ListTile(
                          leading: Icon(icon, color: QamaiGreen, size: 20.0),
                          title: AutoSizeText(
                            '${text} :   ${snapshot.data[firebasedata]}',
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
                  else {
                    return Card(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: ListTile(
                          leading: Icon(icon, color: QamaiGreen, size: 20.0),
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
                }
            );
          }
        }
        else {
          return Card(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ListTile(
                leading: Icon(icon, color: QamaiGreen, size: 20.0),
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
      },
    );
  }
}

class EmployerDetailsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CardReturner('EmployerName', 'Organization Name', OMIcons.business),
        CardReturner('EmployerTitle', 'Designation', OMIcons.workOutline),
        CardReturner('EmployerEmail', 'Email', OMIcons.mailOutline),
        EmployerDescriptionWidget('EmployerDescription'),
        FlatButton(
          padding: EdgeInsets.all(0),
          child: Card(
              color: QamaiGreen,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ListTile(
                  leading: Icon(OMIcons.removeRedEye,
                      color: QamaiThemeColor, size: 20.0),
                  title: AutoSizeText(
                    'Reset Your Password',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: QamaiThemeColor,
                        fontSize: 15.0),
                    maxLines: 1,
                    maxFontSize: 15,
                    minFontSize: 9,
                  ),
                  onTap: () {
                    dialog(
                        context,
                        'Reset Password',
                        'Are you sure you want to reset your password?',
                        'Yes',
                        'No',
                        Image.asset(
                          'images/Password1.png',
                        ), () {
                      PasswordChanger(context);
                    });
                  })),
        ),
        NumberVerifyButton(),
        FlatButton(
          padding: EdgeInsets.all(0),
          child: Card(
              color: QamaiThemeColor,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ListTile(
                leading: Icon(OMIcons.refresh, color: QamaiGreen, size: 20.0),
                title: AutoSizeText(
                  'Request Information Change',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: QamaiGreen,
                      fontSize: 15.0),
                  maxLines: 1,
                  maxFontSize: 15,
                  minFontSize: 9,
                ),
              )),
          onPressed: () {
            dialog(
                context,
                'Request Information Change',
                '''Please send us an email, to request information change.
We'll review your request and change your information accordingly.''',
                'Send',
                'Cancel',
                Image.asset(
                  'images/info.png',
                ), () {
              sendMail();
              Navigator.of(context).pop();
            });
          },
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}

class EmployerDescriptionWidget extends StatelessWidget {

  final firebasedata;

  EmployerDescriptionWidget(this.firebasedata);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection(UserInformation)
          .document(userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;
          if (userDocument['EmployerProfile'] == 'Job') {
            return StreamBuilder(
                stream: Firestore.instance.collection(WorkInformation).document(
                    userid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5),),
                          border: Border.all(color: VeryLightGray),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: AutoSizeText(
                                    'Description',
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    OMIcons.assignment,
                                    size: 20,
                                    color: QamaiGreen,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: QamaiThemeColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '${snapshot.data[firebasedata]}',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: QamaiThemeColor,
                                    fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else {
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
                                  child: AutoSizeText(
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    OMIcons.assignment,
                                    size: 20,
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
                              child: AutoSizeText(
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
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
            );
          }
          else {
            return StreamBuilder(
                stream: Firestore.instance.collection(InternshipInformation)
                    .document(userid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5),),
                          border: Border.all(color: VeryLightGray),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: AutoSizeText(
                                    'Description',
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    OMIcons.assignment,
                                    size: 20,
                                    color: QamaiGreen,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: QamaiThemeColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '${snapshot.data[firebasedata]}',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: QamaiThemeColor,
                                    fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else {
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
                                  child: AutoSizeText(
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    OMIcons.assignment,
                                    size: 20,
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
                              child: AutoSizeText(
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
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
            );
          }
        }
        else {
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
                        child: AutoSizeText(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          OMIcons.assignment,
                          size: 20,
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
                    child: AutoSizeText(
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
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}






