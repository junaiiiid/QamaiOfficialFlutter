import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/profile_overview.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:qamai_official/containers/widgets/error_alerts.dart';
import 'package:qamai_official/database/phone_and_email.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/sent_widgets.dart';


class Profile extends StatefulWidget {

  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
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
                ProfileOverview(),
                TabBar(
                  indicatorColor:QamaiGreen,
                  unselectedLabelColor: QamaiThemeColor,
                  labelColor: QamaiGreen,
                  tabs: [
                    Tab(
                      icon: Icon(
                        OMIcons.accountCircle,
                        size: 25,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        OMIcons.workOutline,
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
              ProfileList(),
              EmployeeWork(),
              ReviewsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewsList extends StatelessWidget {
  const ReviewsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
            color: QamaiGreen,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListTile(
              leading:
              Icon(OMIcons.starBorder, color: QamaiThemeColor, size: 20.0),
              title: AutoSizeText(
                'No Reviews Yet',
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

class WorkList extends StatelessWidget {
  const WorkList({
    Key key,
  }) : super(key: key);

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
                'No Work History',
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

class EmployeeWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection(UserInformation)
          .document(userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> JobList = List.from(snapshot.data['JobList']);
          if (JobList.isEmpty) {
            return WorkList();
          }
          else {
            return SentList();
          }
        }
        else {
          return WorkList();
        }
      },
    );
  }
}


class ProfileList extends StatefulWidget {
  final BuildContext buildcontext;

  ProfileList({
    this.buildcontext,
    Key key,
  }) : super(key: key);

  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CardBuilder(
          title: FirstName,
          text: 'FirstName',
          icon: OMIcons.personOutline,
        ),
        CardBuilder(
          title: LastName,
          text: 'LastName',
          icon: OMIcons.personOutline,
        ),
        CardBuilder(
          title: DOB,
          text: 'DOB',
          icon: OMIcons.dateRange,
        ),
        CardBuilder(
          title: CNIC,
          text: 'CNIC',
          icon: OMIcons.creditCard,
        ),
        CardBuilder(
          title: Email,
          text: 'Email',
          icon: OMIcons.mailOutline,
        ),
        CardBuilder(
          title: Phone,
          text: 'Phone',
          icon: OMIcons.call,
        ),
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
        FlatButton(
          padding: EdgeInsets.all(0),
          child: Card(
              color: QamaiGreen,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ListTile(
                leading: Icon(OMIcons.phoneLocked,
                    color: QamaiThemeColor, size: 20.0),
                title: AutoSizeText(
                  'Verify Phone Number',
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
          onPressed: () {
            PhoneVerification(widget.buildcontext);
          },
        ),
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
              Navigator.of(widget.buildcontext).pop();
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
