import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/database/firebase_employer.dart';
import 'package:qamai_official/modules/setget/timed_search_setget.dart';
import 'package:qamai_official/database/firebase_employee.dart';
import 'package:qamai_official/modules/strings/other_strings.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:qamai_official/screens/employer_employee_screens/employee_screens/scaffolds/profile_scaffold.dart';
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/widgets/review_cards.dart';
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/scaffolds/profile_scaffold.dart';
import 'package:qamai_official/screens/employer_employee_screens/employee_screens/widgets/inbox_scaffold_widgets.dart';

//DESIRED TIME SEARCHING SCREEN

class DesiredTimeWorkFront extends StatelessWidget {
  final onTap;

  DesiredTimeWorkFront({this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        DesiredTimeWorkHeader('Wanna work at a specific time?',
            "Enter your desired time and we'll find something for you."),
        DesiredTimeWorkFields(
          onTap: onTap,
        ),
      ],
    );
  }
}

class DesiredTimeWorkBack extends StatelessWidget {
  final time;

  DesiredTimeWorkBack(this.time);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection(Proposals).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (time != null) {
              var proposals = snapshot.data.documents;
              List<Widget> proposals_list = [];
              proposals_list.add(DesiredTimeWorkHeader(
                  'Work from $time', 'Following work is avaliable'));

              for (var proposal in proposals) {
                if (proposal.data['Time']
                    .toString()
                    .toLowerCase()
                    .contains(time.toString().toLowerCase())) {
                  final EmployerName = proposal.data['EmployerName'];
                  final ProposalDescription =
                      proposal.data['ProposalDescription'];
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
                  proposals_list.add(proposal_card);
                }
              }
              if (proposals_list.length == 1) {
                proposals_list.add(Center(
                  child: AutoSizeText(
                    'No work found sorry!',
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
              return ListView(
                children: proposals_list,
              );
            } else {
              return Center(
                child: AutoSizeText(
                  'Please enter desired time and try again',
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
              );
            }
          } else {
            return Center(
              child: AutoSizeText(
                'Sorry No Work Found',
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
            );
          }
        },
      ),
    );
  }
}

class DesiredTimeWorkHeader extends StatelessWidget {
  final title;
  final subtitle;

  DesiredTimeWorkHeader(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AutoSizeText(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            minFontSize: 10.0,
            maxFontSize: 30.0,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 23.0,
              color: QamaiThemeColor,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, bottom: 10, right: 30, top: 15),
          child: AutoSizeText(
            subtitle,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 5.0,
              color: LightGray,
            ),
          ),
        ),
        Divider(
          color: QamaiThemeColor,
        ),
      ],
    );
  }
}

class DesiredTimeWorkFields extends StatelessWidget {
  final onTap;

  DesiredTimeWorkFields({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AutoSizeText(
              "START",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 5.0,
                color: LightGray,
              ),
            ),
            Container(
              child: DesiredTimeInput('', (value) {
                setTimestart(value);
              }, 7),
              width: 100,
            ),
            AutoSizeText(
              "END",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 5.0,
                color: LightGray,
              ),
            ),
            Container(
              child: DesiredTimeInput('', (value) {
                setTimeend(value);
              }, 7),
              width: 100,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: QamaiThemeColor,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            'Time should have AM and PM at the end',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 1.0,
              color: LightGray,
            ),
          ),
        ),
        Divider(
          color: QamaiThemeColor,
        ),
        Center(
          child: IconButton(
            icon: Icon(
              OMIcons.search,
              color: QamaiThemeColor,
              size: 50,
            ),
            onPressed: onTap,
          ),
        ),
      ],
    );
  }
}

class DesiredTimeInput extends StatelessWidget {
  final label;
  final onChanged;
  final max;

  DesiredTimeInput(this.label, this.onChanged, this.max);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: TextFormField(
        onChanged: onChanged,
        maxLength: max,
        keyboardType: TextInputType.text,
        obscureText: false,
        decoration: InputDecoration(
          counterText: '',
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: LightGray,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LightGray, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: QamaiThemeColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}

//SEARCH CARDS AND THEIR RESULTS

class SearchResultCards extends StatelessWidget {
  final data, title, text, item, userID;

  SearchResultCards(this.data, this.title, this.text, this.item, this.userID);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data['ProfilePicture']),
              backgroundColor: QamaiGreen,
            ),
            title: AutoSizeText(
              '${data[title]}',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: QamaiThemeColor,
                  fontSize: 15),
              maxLines: 1,
              maxFontSize: 15,
              minFontSize: 12,
            ),
            subtitle: AutoSizeText(
              '${data[text]}',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: QamaiThemeColor,
                  fontSize: 12),
              maxLines: 1,
              maxFontSize: 12,
              minFontSize: 10,
            ),
            trailing: Column(
              children: <Widget>[
                Icon(
                  OMIcons.verifiedUser,
                  color: QamaiGreen,
                  size: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  OMIcons.star,
                  color: QamaiGreen,
                  size: 20,
                ),
              ],
            )),
      ),
      onTap: () {
        if (item == 1) {
          //views profile of people
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PublicProfilePeople(data, userID)),
          );
        } else if (item == 2) {
          //views profile of Jobs
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PublicProfileJobs(data, userID)),
          );
        } else {
          //views profile of Internships
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PublicProfileInternship(data, userID)),
          );
        }
      },
    );
  }
}

class PeopleSearchResult extends StatelessWidget {
  final value;

  PeopleSearchResult({this.value});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(UserInformation).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var users = snapshot.data.documents;
          var userID;
          List<Widget> usersList = [];

          for (var user in users) {
            if (value == null) {
              userID = user.documentID;
              usersList.add(
                  SearchResultCards(user.data, 'FullName', 'Story', 1, userID));
            } else {
              if (user.data['FullName']
                  .toString()
                  .toLowerCase()
                  .contains(value.toString().toLowerCase())) {
                userID = user.documentID;
                usersList.add(SearchResultCards(
                    user.data, 'FullName', 'Story', 1, userID));
              }
            }
          }
          if (usersList.length == 0) {
            usersList.add(Center(
              child: Text(
                'No results found',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: QamaiThemeColor),
              ),
            ));
          }

          return ListView(
            children: usersList,
          );
        } else {
          return Center(
            child: Text(
              'No results found',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: QamaiThemeColor),
            ),
          );
        }
      },
    );
  }
}

class WorkEmployerSearchResult extends StatelessWidget {
  final value;

  WorkEmployerSearchResult({this.value});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(WorkInformation).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var users = snapshot.data.documents;
          var userID;
          List<Widget> usersList = [];

          for (var user in users) {
            if (value == null) {
              userID = user.documentID;
              usersList.add(SearchResultCards(
                  user.data, 'EmployerName', 'EmployerTitle', 2, userID));
            } else {
              if (user.data['EmployerName']
                  .toString()
                  .toLowerCase()
                  .contains(value.toString().toLowerCase())) {
                userID = user.documentID;
                usersList.add(SearchResultCards(
                    user.data, 'EmployerName', 'EmployerTitle', 2, userID));
              }
            }
          }

          if (usersList.length == 0) {
            usersList.add(Center(
              child: Text(
                'No results found',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: QamaiThemeColor),
              ),
            ));
          }

          return ListView(
            children: usersList,
          );
        } else {
          return ListView();
        }
      },
    );
  }
}

class InternshipEmployerSearchResult extends StatelessWidget {
  final value;

  InternshipEmployerSearchResult({this.value});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(InternshipInformation).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var users = snapshot.data.documents;
          var userID;
          List<Widget> usersList = [];

          for (var user in users) {
            if (value == null) {
              userID = user.documentID;
              usersList.add(SearchResultCards(
                  user.data, 'EmployerName', 'EmployerTitle', 3, userID));
            } else {
              if (user.data['EmployerName']
                  .toString()
                  .toLowerCase()
                  .contains(value.toString().toLowerCase())) {
                userID = user.documentID;
                usersList.add(SearchResultCards(
                    user.data, 'EmployerName', 'EmployerTitle', 3, userID));
              }
            }
          }

          if (usersList.length == 0) {
            usersList.add(Center(
              child: Text(
                'No results found',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: QamaiThemeColor),
              ),
            ));
          }

          return ListView(
            children: usersList,
          );
        } else {
          return ListView();
        }
      },
    );
  }
}

//PUBLIC PROFILE VIEW IN SEARCH MODE

//PEOPLE
class PublicProfilePeople extends StatelessWidget {
  final data, userID;

  PublicProfilePeople(this.data, this.userID);

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
                  EmployeeWork(userID),
                  EmployeeReviews(userID),
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
  final data, userID;

  PublicProfileJobs(this.data, this.userID);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: White,
          body: DefaultTabController(
            length: 3,
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
                  JobList(
                    data: data,
                  ),
                  EmployerWork(userID),
                  EmployerReviews(userID),
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
                  '${data['EmployerTitle']}',
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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Designation :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            '${data['EmployerTitle']}',
            style: TextStyle(
                fontFamily: 'Raleway', color: QamaiThemeColor, fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Description :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '${data['EmployerDescription']}',
            style: TextStyle(
                fontFamily: 'Raleway', color: QamaiThemeColor, fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

//INTERNSHIP
class PublicProfileInternship extends StatelessWidget {
  final data, userID;

  PublicProfileInternship(this.data, this.userID);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: White,
          body: DefaultTabController(
            length: 3,
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
                  InternshipList(
                    data: data,
                  ),
                  EmployerWork(userID),
                  EmployerReviews(userID),
                ],
              ),
            ),
          )),
    );
  }
}

class PublicInternshipOverview extends StatelessWidget {
  final data;

  PublicInternshipOverview(this.data);

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
                  '${data['EmployerTitle']}',
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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Designation :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            '${data['EmployerTitle']}',
            style: TextStyle(
                fontFamily: 'Raleway', color: QamaiThemeColor, fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Description :',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: QamaiThemeColor,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '${data['EmployerDescription']}',
            style: TextStyle(
                fontFamily: 'Raleway', color: QamaiThemeColor, fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
