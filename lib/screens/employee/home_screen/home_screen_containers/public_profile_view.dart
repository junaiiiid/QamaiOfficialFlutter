import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qamai_official/constants.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/screens/employee/home_screen/profile_screen_scaffolds/profile_scaffold.dart';
import 'package:auto_size_text/auto_size_text.dart';



//PEOPLE
class PublicProfilePeople extends StatelessWidget {
  final data;

  PublicProfilePeople(this.data);

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
                    PublicProfileOverview(data),
                    SizedBox(
                      height: 20,
                    ),
                    TabBar(
                      indicatorColor: QamaiGreen,
                      unselectedLabelColor: QamaiThemeColor,
                      labelColor: QamaiGreen,
                      tabs: [
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
                  WorkList(),
                  ReviewsList(),
                ],
              ),
            ),
          )),
    );
  }
}

class PublicProfileOverview extends StatelessWidget {
  final data;

  PublicProfileOverview(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            minRadius: 30,
            maxRadius: 60,
            backgroundImage: NetworkImage('${data['ProfilePicture']}'),
            backgroundColor: QamaiGreen,
          ),
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
                  '${data['FirstName']} ${data['LastName']}',
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
                  '${data['Story']}',
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

//JOBS
class PublicProfileJobs extends StatelessWidget {
  final data;

  PublicProfileJobs(this.data);

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
                    PublicJobOverview(data),
                    SizedBox(
                      height: 20,
                    ),
                    TabBar(
                      indicatorColor: QamaiGreen,
                      unselectedLabelColor: QamaiThemeColor,
                      labelColor: QamaiGreen,
                      tabs: [
                        Tab(
                          icon: Icon(
                            OMIcons.business,
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
                  JobList(data: data,),
                  ReviewsList(),
                ],
              ),
            ),
          )),
    );
  }
}

class PublicJobOverview extends StatelessWidget {
  final data;

  PublicJobOverview(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            minRadius: 30,
            maxRadius: 60,
            backgroundImage: NetworkImage('${data['ProfilePicture']}'),
            backgroundColor: QamaiGreen,
          ),
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
                  '${data['JobTitle']}',
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

class JobList extends StatelessWidget {

  final data;

  const JobList({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:20),
          child: Text(
            'Job Title :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:20),
          child: Text(
            '${data['JobTitle']}',
            style: TextStyle(
                fontFamily: 'Raleway',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:20),
          child: Text(
            'Job Description :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '${data['JobDescription']}',
            style: TextStyle(
                fontFamily: 'Raleway',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Card(
            color: QamaiGreen,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListTile(
              leading:
              Icon(OMIcons.check, color: QamaiThemeColor, size: 20.0),
              title: AutoSizeText(
                'Apply for this Position',
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

//INTERNSHIP

class PublicProfileInternship extends StatelessWidget {
  final data;

  PublicProfileInternship(this.data);

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
                    PublicInternshipOverview(data),
                    SizedBox(
                      height: 20,
                    ),
                    TabBar(
                      indicatorColor: QamaiGreen,
                      unselectedLabelColor: QamaiThemeColor,
                      labelColor: QamaiGreen,
                      tabs: [
                        Tab(
                          icon: Icon(
                            Ionicons.getIconData('ios-school'),
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
                  InternshipList(data: data,),
                  ReviewsList(),
                ],
              ),
            ),
          )),
    );
  }
}

class PublicInternshipOverview extends StatelessWidget {
  final data;

  PublicInternshipOverview (this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            minRadius: 30,
            maxRadius: 60,
            backgroundImage: NetworkImage('${data['ProfilePicture']}'),
            backgroundColor: QamaiGreen,
          ),
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
                  '${data['InternshipEmployerName']}',
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
                  '${data['InternshipTitle']}',
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

class InternshipList extends StatelessWidget {

  final data;

  const InternshipList({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:20),
          child: Text(
            'Internship Title :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:20),
          child: Text(
            '${data['InternshipTitle']}',
            style: TextStyle(
                fontFamily: 'Raleway',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:20),
          child: Text(
            'Internship Description :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '${data['InternshipDescription']}',
            style: TextStyle(
                fontFamily: 'Raleway',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Card(
            color: QamaiGreen,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListTile(
              leading:
              Icon(OMIcons.check, color: QamaiThemeColor, size: 20.0),
              title: AutoSizeText(
                'Apply for this Position',
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