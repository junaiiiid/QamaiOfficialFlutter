import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/database/firebase_employee.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:qamai_official/modules/themes/theme.dart';
import 'package:qamai_official/screens/employer_employee_screens/employee_screens/widgets/inbox_scaffold_widgets.dart';


class Inbox extends StatefulWidget {


  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
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
              EmployeeInterviewCardsList(),
            ],
          ),
        ),
      ),
    );
  }
}




