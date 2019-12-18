import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../../constants.dart';

class ReviewCard extends StatelessWidget {
  final Rating, Review;

  ReviewCard(this.Rating, this.Review);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: VeryLightGray,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Review,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: QamaiThemeColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SmoothStarRating(
                    allowHalfRating: false,
                    starCount: 5,
                    rating: double.parse(Rating),
                    size: 30.0,
                    color: QamaiGreen,
                    borderColor: QamaiThemeColor,
                    spacing: 0.0)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget EmployerReviews(var document) {
  if (document == null) {
    document = userid;
  }

  return StreamBuilder<QuerySnapshot>(
    stream: firestore.collection(Proposals).snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Widget> ReviewCards = [];
        var proposals = snapshot.data.documents;
        for (var proposal in proposals) {
          if (proposal.data['EmployerID'] == document) {
            List<String> interviews = List.from(proposal.data['Interviews']);
            for (var interview in interviews) {
              ReviewCards.add(StreamBuilder(
                stream: Firestore.instance
                    .collection(Reviews)
                    .document(interview)
                    .collection('EmployerReview')
                    .document(document)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var ReviewDocument = snapshot.data;
                    return ReviewCard(
                        ReviewDocument['Rating'], ReviewDocument['Review']);
                  }
                  return NoReviews();
                },
              ));
            }
          }
        }
        if (ReviewCards.isEmpty) {
          return NoReviews();
        }
        return ListView(
          children: ReviewCards,
        );
      }
      return NoReviews();
    },
  );
}

class NoReviews extends StatelessWidget {
  const NoReviews({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
            color: QamaiGreen,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListTile(
              leading:
                  Icon(OMIcons.starBorder, color: QamaiThemeColor, size: 20.0),
              title: AutoSizeText(
                'No Reviews Yet',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: QamaiThemeColor,
                    fontSize: 15.0),
                maxLines: 1,
                maxFontSize: 15,
                minFontSize: 9,
              ),
            )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

Widget EmployeeReviews(var document) {
  if (document == null) {
    document = userid;
  }

  return StreamBuilder(
    stream: Firestore.instance
        .collection(UserInformation)
        .document(document)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<String> interviews = List.from(snapshot.data['Interviews']);
        List<Widget> ReviewCards = [];

        for (var interview in interviews) {
          ReviewCards.add(StreamBuilder(
            stream: Firestore.instance
                .collection(Reviews)
                .document(interview)
                .collection('EmployeeReview')
                .document(document)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ReviewCard(
                    snapshot.data['Rating'], snapshot.data['Review']);
              }
              return NoReviews();
            },
          ));
        }
        if (ReviewCards.isEmpty) {
          return NoReviews();
        }
        return ListView(
          children: ReviewCards,
        );
      }
      return NoReviews();
    },
  );
}
