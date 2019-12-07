import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/profile_overview.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:flutter_icons/flutter_icons.dart';

class EmployerProfile extends StatefulWidget {
  EmployerProfile({Key key}) : super(key: key);

  @override
  _EmployerProfileState createState() => _EmployerProfileState();
}

class _EmployerProfileState extends State<EmployerProfile> {
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
              Container(),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
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
