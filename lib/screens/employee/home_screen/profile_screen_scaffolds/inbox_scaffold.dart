import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/proposal_widgets.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/sent_widgets.dart';


class Inbox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
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
                        'Proposals',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Sent',
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
              ProposalsList(),
              SentList(userid),
              Container(),
            ],
          ),
        ),
      ),
    );
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
    }
    else {
      return Icon(
        OMIcons.business,
        size: 25,
      );
    }
  }
}
