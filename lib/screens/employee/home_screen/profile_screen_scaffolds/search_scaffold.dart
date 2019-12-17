import 'package:flutter/material.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/search_bar.dart';
import 'package:qamai_official/theme.dart';

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
