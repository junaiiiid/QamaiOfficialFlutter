import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';

//SENT

class SentList extends StatelessWidget {

  final document;

  SentList(this.document);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection(UserInformation)
          .document(document)
          .snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData) {
          var userDocument=snapshot.data;
          temp_jobs_list =List.from(userDocument['JobList']);

          List<SentCard> sent_card_list = [];

          for(var v in temp_jobs_list) {
            final sent_card= SentCard(
              SentName(v),
              SentDescription(v),
              SentRate(v),
              SentCategory(v),
              SentProfilePicture(v),
              SentButton(v),
            );

            sent_card_list.add(sent_card);
          }
          return ListView(
            children: sent_card_list,
          );
        }
        else{
          return Center(
            child: Text(
              'No offers sent',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          );
        }
      },
    );
  }
}


class SentName extends StatelessWidget {

  final JobID;

  SentName(this.JobID);

  @override
  Widget build(BuildContext context) {

      return StreamBuilder(
          stream: Firestore.instance.collection('Proposals').document(JobID).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData)
            {
              var userDocument = snapshot.data;
              final title=userDocument['EmployerName'];
              return Text(
                title,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              );
            }
            else{
              return Text(
                'LOADING...',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              );
            }
          });
  }
}

class SentCategory extends StatelessWidget {

  final JobID;

  SentCategory(this.JobID);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: Firestore.instance.collection('Proposals').document(JobID).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            var userDocument = snapshot.data;
            final title=userDocument['Category'];
            return Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            );
          }
          else{
            return Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'LOADING...',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            );
          }
        });
  }
}

class SentDescription extends StatelessWidget {

  final JobID;

  SentDescription(this.JobID);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: Firestore.instance.collection('Proposals').document(JobID).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            var userDocument = snapshot.data;
            final title=userDocument['ProposalDescription'];
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          }
          else{
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'LOADING...',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          }
        });
  }
}

class SentRate extends StatelessWidget {

  final JobID;

  SentRate(this.JobID);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: Firestore.instance.collection('Proposals').document(JobID).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            var userDocument = snapshot.data;
            final title=userDocument['Rate'];
            return Padding(
              padding: EdgeInsets.all(35),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: QamaiGreen,
                ),
              ),
            );
          }
          else{
            return Padding(
              padding: EdgeInsets.all(35),
              child: Text(
                'LOADING...',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: QamaiGreen,
                ),
              ),
            );
          }
        });
  }
}

class SentButton extends StatelessWidget  {

  final JobID;

  SentButton(this.JobID);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: Firestore.instance.collection(UserInformation).document(userid).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            var userDocument = snapshot.data;
            temp_jobs_list =List.from(userDocument['JobList']);

            if(temp_jobs_list.contains(JobID))
              {
                return Button(color: Red,text: 'WITHDRAW',onpress: (){
                  RemoveJobs(JobID);
                },);
              }
            else{
              return DisabledButton(color: LightGray,text: 'WITHDRAWN');
            }
          }
          else{
            return DisabledButton(color: LightGray,text: 'WITHDRAWN');
          }
        });
  }
}

class SentProfilePicture extends StatelessWidget {

  final JobID;

  SentProfilePicture(this.JobID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Proposals').document(JobID).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData)
          {
            final userDocument= snapshot.data;
            final employerprofile = userDocument['EmployerProfile'];
            final employerid=userDocument['EmployerID'];

            return ProposalProfilePicture(employerprofile, employerid);
          }
        else{
          return CircleAvatar(
            backgroundColor: QamaiThemeColor,
          );
        }
      },
    );
  }


}


class SentCard extends StatefulWidget {

  final NameWidget;
  final DescriptionWidget;
  final RateWidget;
  final CategoryWidget;
  final PictureWidget;
  final ButtonWidget;


  SentCard(this.NameWidget, this.DescriptionWidget, this.RateWidget,
      this.CategoryWidget, this.PictureWidget,this.ButtonWidget);

  @override
  _SentCardState createState() => _SentCardState();
}

class _SentCardState extends State<SentCard> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: VeryLightGray,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: widget.PictureWidget,
                    ),
                    widget.NameWidget,
                  ],
                ),
                widget.CategoryWidget,
              ],
            ),
            Divider(
              color: QamaiThemeColor,
            ),
            widget.DescriptionWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.ButtonWidget,
                widget.RateWidget,
              ],
            ),
          ],
        ),
      ),
    );
  }
}


