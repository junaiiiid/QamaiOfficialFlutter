import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/search_card.dart';


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
            }
            else {
              if (user.data['FullName'].toString().toLowerCase().contains(
                  value.toString().toLowerCase())) {
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
        }
        else {
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
            }
            else {
              if (user.data['EmployerName'].toString().toLowerCase().contains(
                  value.toString().toLowerCase())) {
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
        }
        else {
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
            }
            else {
              if (user.data['EmployerName'].toString().toLowerCase().contains(
                  value.toString().toLowerCase())) {
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
        }
        else {
          return ListView();
        }
      },
    );
  }
}





