
import 'package:flutter/material.dart';
import 'package:qamai_official/modules/themes/theme.dart';
import 'package:qamai_official/screens/employer_employee_screens/employer_screens/widgets/home_scaffold_widgets.dart';

class EmployerHome extends StatefulWidget {
  @override
  _EmployerHomeState createState() => _EmployerHomeState();
}

class _EmployerHomeState extends State<EmployerHome> {
  @override
  void initState() {
    InitializeHome();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return EmployerHomeList();
  }
}

