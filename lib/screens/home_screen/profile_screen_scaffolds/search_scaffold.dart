import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/screens/home_screen/home_screen_containers/search_bar.dart';
import 'package:qamai_official/screens/home_screen/home_screen_containers/public_profile_view.dart';

class Search extends StatefulWidget {
  final BuildContext context;
  Search({Key key, this.context}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MySearchBar(widget.context);
  }
}
