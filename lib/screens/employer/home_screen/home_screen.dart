import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:qamai_official/constants.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/containers/widgets/error_alerts.dart';
import 'package:qamai_official/containers/widgets/settings_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employee/home_screen/profile_screen_scaffolds/radar_scaffold.dart';
import 'package:qamai_official/screens/employee/home_screen/profile_screen_scaffolds/search_scaffold.dart';
import 'package:qamai_official/screens/employer/home_screen/profile_screen_scaffolds/inbox_scaffold.dart';
import 'package:qamai_official/screens/employer/home_screen/profile_screen_scaffolds/profile_scaffold.dart';

import '../../../theme.dart';

void Initialize() {
  FlutterStatusbarcolor.setStatusBarColor(White);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  FlutterStatusbarcolor.setNavigationBarColor(QamaiThemeColor);
  FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
}

class EmployerHomeScreen extends StatefulWidget {
  @override
  _EmployerHomeScreenState createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHomeScreen> {


  Widget body;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ThemeService themeService = Provider.of<ThemeService>(context);
      themeService.switchToThemeB();
    });

    Initialize();
    getUser();
    getJobsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(OMIcons.settings, color: QamaiThemeColor),
            onPressed: () {
              settings(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(OMIcons.exitToApp, color: QamaiThemeColor),
              onPressed: () {
                logoutalert(context);
              },
            ),
          ],
          backgroundColor: White,
          title: Center(
            child: Text(
              '',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: QamaiThemeColor),
            ),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.decelerate,
          buttonBackgroundColor: QamaiGreen,
          color: QamaiThemeColor,
          items: [
            Icon(
              OMIcons.home,
              color: White,
            ),
            Icon(
              OMIcons.search,
              color: White,
            ),
            Icon(
              OMIcons.myLocation,
              color: White,
            ),
            Icon(
              OMIcons.message,
              color: White,
            ),
            Icon(
              OMIcons.personOutline,
              color: White,
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 1:
                {
                  setState(() {
                    body = Search();
                  });
                  break;
                }
              case 2:
                {
                  setState(() {
                    body = RadarMap();
                  });
                  break;
                }
              case 3:
                {
                  setState(() {
                    body = EmployerInbox();
                  });
                  break;
                }
              case 4:
                {
                  setState(() {
                    body = EmployerProfile();
                  });
                  break;
                }
            }
          },
        ),
        body: body,
      ),
    );
  }
}
