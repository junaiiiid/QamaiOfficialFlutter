import 'package:flutter/material.dart';
import 'package:simple_search_bar/simple_search_bar.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/search_result.dart';

class MySearchBar extends StatefulWidget {
  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final AppBarController appBarController = AppBarController();

  //PEOPLE SEARCH
  var peopleResultSet = [];
  var peopleSearchStore = [];

  initiatePeopleSearch(value) {
    if (value.length == 0) {
      setState(() {
        peopleResultSet = [];
        peopleSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    value=capitalizedValue;

    if (peopleResultSet.length == 0 && value.length == 1) {
      SearchService().searchPeople(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          peopleResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      peopleSearchStore = [];
      peopleResultSet.forEach((element) {
        if (element['FullName'].startsWith(capitalizedValue)) {
          setState(() {
            peopleSearchStore.add(element);
          });
        }
      });
    }
  }

  //JOB SEARCH
  var employerResultSet = [];
  var employerSearchStore = [];

  initiateJobSearch(value) {
    if (value.length == 0) {
      setState(() {
        employerResultSet = [];
        employerSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    value=capitalizedValue;

    if (employerResultSet.length == 0 && value.length == 1) {
      SearchService().searchJob(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          employerResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      employerSearchStore = [];
      employerResultSet.forEach((element) {
        if (element['EmployerName'].startsWith(capitalizedValue)) {
          setState(() {
            employerSearchStore.add(element);
          });
        }
      });
    }
  }

  //INTERNSHIP SEARCH
  var internshipResultSet = [];
  var internshipSearchStore = [];

  initiateInternshipSearch(value) {
    if (value.length == 0) {
      setState(() {
        internshipResultSet = [];
        internshipSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    value=capitalizedValue;

    if (internshipResultSet.length == 0 && value.length == 1) {
      SearchService().searchInternship(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          internshipResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      internshipSearchStore = [];
      internshipResultSet.forEach((element) {
        if (element['EmployerName'].startsWith(capitalizedValue)) {
          setState(() {
            internshipSearchStore.add(element);
          });
        }
      });
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: Column(
                children: <Widget>[
                  SearchAppBar(
                    searchFontSize: 16,
                    primary: White,
                    appBarController: appBarController,
                    // You could load the bar with search already active
                    autoSelected: true,
                    searchHint: "Search",
                    mainTextColor: QamaiThemeColor,
                    onChange: (String value) {

                      initiatePeopleSearch(value);
                      initiateJobSearch(value);
                      initiateInternshipSearch(value);

                    },
                    //Will show when SEARCH MODE wasn't active
                    mainAppBar: AppBar(
                      title: Text('Search',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              color: QamaiThemeColor,
                              fontSize: 16),
                          textAlign: TextAlign.center),
                      backgroundColor: White,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: QamaiThemeColor,
                          ),
                          onPressed: () {
                            //This is where You change to SEARCH MODE. To hide, just
                            //add FALSE as value on the stream
                            appBarController.stream.add(true);
                          },
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    indicatorColor:QamaiGreen,
                    unselectedLabelColor: QamaiThemeColor,
                    labelColor: QamaiGreen,
                    tabs: [
                      Tab(
                        icon: Icon(
                          Ionicons.getIconData("ios-contacts"),
                          size: 25,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Ionicons.getIconData("ios-briefcase"),
                          size: 25,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Ionicons.getIconData("md-ribbon"),
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
                SearchResultList(tempSearchStore: peopleSearchStore, item: 1,),
                SearchResultList(
                  tempSearchStore: employerSearchStore, item: 2,),
                SearchResultList(
                  tempSearchStore: internshipSearchStore, item: 3,),
              ],
            ),
          ),
        ),
    );
  }
}

