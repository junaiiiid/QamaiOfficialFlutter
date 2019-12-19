import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:qamai_official/modules/themes/theme.dart';
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/widgets/inbox_scaffold_widgets.dart';
import 'package:qamai_official/database/firebase_employee.dart';
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/widgets/interviews_module.dart';

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








