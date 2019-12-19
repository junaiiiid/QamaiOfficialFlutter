import 'package:flutter/material.dart';
import 'package:qamai_official/modules/themes/theme.dart';
import 'package:qamai_official/screens/employer_employee_screens/common_screens/widgets/map_widgets.dart';


class RadarMap extends StatefulWidget {

  RadarMap({Key key}) : super(key: key);
  @override
  _RadarMapState createState() => _RadarMapState();
}

class _RadarMapState extends State<RadarMap> {

  @override
  void initState() {
    InitializeHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapSample(),
    );
  }
}

