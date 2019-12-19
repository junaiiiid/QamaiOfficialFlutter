import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qamai_official/modules/setget/proposal_setget.dart';
import 'package:qamai_official/modules/themes/colors.dart';
import 'package:qamai_official/modules/themes/theme.dart';
import 'package:qamai_official/screens/employer_employee_screens/common_screens/widgets/search_widgets.dart';
import 'package:simple_search_bar/simple_search_bar.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    InitializeHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MySearchBar();
  }
}


class MySearchBar extends StatefulWidget {
  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final AppBarController appBarController = AppBarController();

  Widget peopleList;
  Widget workEmployersList;
  Widget internshipEmployersList;

  @override
  void initState() {
    peopleList = PeopleSearchResult();
    workEmployersList = WorkEmployerSearchResult();
    internshipEmployersList = InternshipEmployerSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
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
                    setState(() {
                      peopleList = PeopleSearchResult(value: value,);
                      workEmployersList =
                          WorkEmployerSearchResult(value: value,);
                      internshipEmployersList =
                          InternshipEmployerSearchResult(value: value,);
                    });
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
                  indicatorColor: QamaiGreen,
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
                        Ionicons.getIconData("ios-school"),
                        size: 25,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Ionicons.getIconData("ios-time"),
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
              peopleList,
              workEmployersList,
              internshipEmployersList,
              DesiredTimeWorkFront(onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DesiredTimeWorkBack(getTime())),
                );
              },),
            ],
          ),
        ),
      ),
    );
  }
}