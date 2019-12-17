import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:bubble/bubble.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/chat_messages_form.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../../../constants.dart';
import '../../../../theme.dart';

final ScrollController scrollcontroller = ScrollController();
final TextEditingController textcontroller = TextEditingController();

class ChatScreen extends StatefulWidget {
  final InterviewID, EmployeeID;
  final ProfilePicture, CandidateDetails;

  ChatScreen(this.InterviewID, this.EmployeeID, this.ProfilePicture,
      this.CandidateDetails);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    InitializeChatScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: White,
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(97),
                child: Container(
                  color: QamaiThemeColor,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Ionicons.getIconData("ios-arrow-round-back"),
                              size: 40,
                              color: QamaiGreen,
                            ),
                            onPressed: () {
                              InitializeHome();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      TabBar(
                        indicatorColor: QamaiGreen,
                        unselectedLabelColor: LightGray,
                        labelColor: QamaiGreen,
                        tabs: [
                          Tab(
                            icon: Icon(
                              OMIcons.mailOutline,
                              size: 25,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              OMIcons.assignment,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  RelevantChatList(widget.InterviewID, widget.EmployeeID),
                  EvaluationList(
                      widget.ProfilePicture, widget.CandidateDetails),
                ],
              ),
            ),
          )),
    );
  }
}

class ChatList extends StatelessWidget {
  final InterviewID, EmployeeID, onSend;

  ChatList(this.InterviewID, this.EmployeeID, this.onSend);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BubbleWidgets(InterviewID, EmployeeID),
        ChatBottomWidget('Enter your message', (value) {
          setText(value);
        }, InterviewID, onSend),
      ],
    );
  }
}

class EvaluationList extends StatelessWidget {
  final ProfilePicture, Details;

  EvaluationList(this.ProfilePicture, this.Details);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Center(
          child: ProfilePicture,
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Details,
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          color: QamaiThemeColor,
        ),
        SizedBox(
          height: 20,
        ),
        Button(
          color: QamaiGreen,
          text: 'ACCEPT',
        ),
        SizedBox(
          height: 20,
        ),
        Button(
          color: Red,
          text: 'REJECT',
        ),
        SizedBox(
          height: 40,
        ),
        SmoothStarRating(
            allowHalfRating: false,
            onRatingChanged: (v) {},
            starCount: 5,
            rating: 3,
            size: 40.0,
            color: QamaiGreen,
            borderColor: QamaiThemeColor,
            spacing: 0.0),
      ],
    );
  }
}

class RelevantChatList extends StatelessWidget {
  final InterviewID, EmployeeID;

  RelevantChatList(this.InterviewID, this.EmployeeID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(UserInformation)
          .document(userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['ActiveProfile'] == 'Employer') {
            return ChatList(
              InterviewID,
              EmployeeID,
              () {
                sendMessage(InterviewID, getText(), 1);
                textcontroller.clear();
              },
            );
          } else {
            return ChatList(
              InterviewID,
              EmployeeID,
              () {
                sendMessage(InterviewID, getText(), 2);
                textcontroller.clear();
              },
            );
          }
        }
        return ChatList(
          InterviewID,
          EmployeeID,
          () {
            sendMessage(InterviewID, getText(), 1);
            textcontroller.clear();
          },
        );
      },
    );
  }
}

class BubbleSender extends StatelessWidget {
  //BLUE BUBBLE
  final messageSender, messageText;

  BubbleSender(this.messageSender, this.messageText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  messageSender,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: LightGray,
                    fontFamily: 'Raleway',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Bubble(
            margin: BubbleEdges.only(top: 10),
            alignment: Alignment.topRight,
            nip: BubbleNip.rightTop,
            color: QamaiThemeColor,
            child: Text(
              messageText,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: White,
                fontFamily: 'Raleway',
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class BubbleReceiver extends StatelessWidget {
  //GREEN BUBBLE
  final messageSender, messageText;

  BubbleReceiver(this.messageSender, this.messageText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  messageSender,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: LightGray,
                    fontFamily: 'Raleway',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Bubble(
            margin: BubbleEdges.only(top: 10),
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftTop,
            color: QamaiGreen,
            child: Text(
              messageText,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: White,
                fontFamily: 'Raleway',
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class ChatBottomWidget extends StatelessWidget {
  final label;
  final onChanged;
  final InterviewID;
  final onSend;

  ChatBottomWidget(this.label, this.onChanged, this.InterviewID, this.onSend);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200.0,
            ),
            child: new Scrollbar(
              child: new SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: SizedBox(
                  height: 50.0,
                  width: 330.0,
                  child: new TextField(
                    onTap: () {
                      Timer(
                          Duration(milliseconds: 100),
                          () => scrollcontroller.jumpTo(
                              scrollcontroller.position.maxScrollExtent));
                    },
                    controller: textcontroller,
                    onChanged: onChanged,
                    maxLength: 1000,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    maxLines: 1000,
                    decoration: new InputDecoration(
                      counterText: '',
                      hintText: label,
                      hintStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: LightGray,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: QamaiThemeColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: LightGray, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Ionicons.getIconData("ios-paper-plane"),
              size: 35,
            ),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}

class BubbleWidgets extends StatelessWidget {
  final InterviewID, EmployeeID;

  BubbleWidgets(this.InterviewID, this.EmployeeID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection(InterviewsInformation)
          .document(InterviewID)
          .collection('Chat').orderBy('CreatedAt')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> Chatbubbles = [];
          var interviews = snapshot.data.documents;
          for (var interview in interviews) {
            Chatbubbles.add(StreamBuilder(
              stream: Firestore.instance.collection(UserInformation).document(
                  EmployeeID).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userdocument = snapshot.data;

                  if (userdocument['FullName'] ==
                      interview.data['MessageSender']) {
                    return BubbleSender(interview.data['MessageSender'],
                        interview.data['MessageText']);
                  }
                  else {
                    return BubbleReceiver(interview.data['MessageSender'],
                        interview.data['MessageText']);
                  }
                }
                return Center();
              },
            ));
          }
          return Expanded(
            child: ListView(
              children: Chatbubbles,
              controller: scrollcontroller,
            ),
          );
        }
        return Center();
      },
    );
  }
}

void sendMessage(InterviewID, messageText, key) {
  if (key == 1) {
    DocumentReference user =
        Firestore.instance.collection(UserInformation).document(userid);

    user.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        var currentuser = datasnapshot.data;
        if (currentuser['EmployerProfile'] == 'Internship') {
          DocumentReference employer = Firestore.instance
              .collection(InternshipInformation)
              .document(userid);

          employer.get().then((datasnapshot) {
            if (datasnapshot.exists) {
              var employer = datasnapshot.data;
              firestore
                  .collection(InterviewsInformation)
                  .document(InterviewID)
                  .collection('Chat')
                  .add({
                'MessageSender': employer['EmployerName'],
                'MessageText': messageText,
                'CreatedAt': FieldValue.serverTimestamp(),
              });
            }
          });
        } else {
          DocumentReference employer =
              Firestore.instance.collection(WorkInformation).document(userid);

          employer.get().then((datasnapshot) {
            if (datasnapshot.exists) {
              var employer = datasnapshot.data;
              firestore
                  .collection(InterviewsInformation)
                  .document(InterviewID)
                  .collection('Chat')
                  .add({
                'MessageSender': employer['EmployerName'],
                'MessageText': messageText,
                'CreatedAt': FieldValue.serverTimestamp(),
              });
            }
          });
        }
      }
    });
  } else {
    DocumentReference user =
        Firestore.instance.collection(UserInformation).document(userid);
    user.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        var user = datasnapshot.data;
        firestore
            .collection(InterviewsInformation)
            .document(InterviewID)
            .collection('Chat')
            .add({
          'MessageSender': user['FullName'],
          'MessageText': messageText,
          'CreatedAt': FieldValue.serverTimestamp(),
        });
      }
    });
  }
}
