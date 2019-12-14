import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/containers/modules/timed_work_search.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employee/home_screen/home_screen_containers/proposal_widgets.dart';

import '../../../../constants.dart';

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
        stream: firestore.collection(ProposalsInformation).snapshots(),
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
