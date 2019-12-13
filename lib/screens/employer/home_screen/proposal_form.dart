import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/modules/proposal_information.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:qamai_official/screens/employer/home_screen/home_screen_containers/form_textfields.dart';
import 'package:toast/toast.dart';
import 'package:toggle_switch/toggle_switch.dart';

bool showSpinner;

class ProposalForm extends StatefulWidget {
  @override
  _ProposalFormState createState() => _ProposalFormState();
}

class _ProposalFormState extends State<ProposalForm> {
  @override
  void initState() {
    showSpinner = false;
    super.initState();
    setCategory('Internship');
    setRateCategory('hour');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        color: QamaiThemeColor,
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            ProposalFormHeader(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, bottom: 10, right: 30, top: 15),
              child: AutoSizeText(
                'What are you posting?',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 5.0,
                  color: QamaiThemeColor,
                ),
              ),
            ),
            Center(
              child: ToggleSwitch(
                minWidth: 100.0,
                initialLabelIndex: 0,
                activeBgColor: QamaiThemeColor,
                activeTextColor: White,
                inactiveBgColor: VeryLightGray,
                inactiveTextColor: LightGray,
                labels: ['Internship', 'Job'],
                onToggle: (index) {
                  index == 0 ? setCategory('Internship') : setCategory('Job');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, bottom: 10, right: 30, top: 15),
              child: AutoSizeText(
                'What is the rate?',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 5.0,
                  color: QamaiThemeColor,
                ),
              ),
            ),
            Center(
              child: ToggleSwitch(
                minWidth: 100.0,
                initialLabelIndex: 0,
                activeBgColor: QamaiThemeColor,
                activeTextColor: White,
                inactiveBgColor: VeryLightGray,
                inactiveTextColor: LightGray,
                labels: ['Hourly', 'Monthly'],
                onToggle: (index) {
                  index == 0
                      ? setRateCategory('hour')
                      : setRateCategory('month');
                },
              ),
            ),
            EmployerFormTextFields('Amount Offered', (value) {
              setRate(value);
            }, 7),
            EmployerFormTextFields('Positions Available', (value) {
              setPosition(value);
            }, 3),
            EmployerFormBigTextFields('Proposal Description', (value) {
              setDescription(value);
            }, 500),
            EmployerFormTextFields('Time Start', (value) {
              setTimestart(value);
            }, 5),
            EmployerFormTextFields('Time End', (value) {
              setTimeend(value);
            }, 5),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, bottom: 10, right: 30, top: 15),
              child: AutoSizeText(
                'Time should have AM and PM at the end',
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
            Button(
              color: QamaiThemeColor,
              text: 'POST',
              onpress: () {
                PublishProposal();
                setState(() {
                  showSpinner = true;
                });
                Navigator.pop(context);
                Toast.show('Proposal Submitted', context,
                    duration: Toast.LENGTH_LONG);
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ProposalFormHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AutoSizeText(
            'Posting a Request?',
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
            'Just provide the following details and post your request ',
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

void PublishProposal() {
  getUser();

  DocumentReference users =
      Firestore.instance.collection(UserInformation).document(userid);

  DocumentReference work =
      Firestore.instance.collection(WorkInformation).document(userid);

  DocumentReference internship =
      Firestore.instance.collection(InternshipInformation).document(userid);

  users.get().then((datasnapshot) {
    if (datasnapshot.exists) {
      var userDocument = datasnapshot.data;
      if (userDocument['EmployerProfile'] == 'Internship') {
        internship.get().then((datasnapshot) {
          var internDocument = datasnapshot.data;
          firestore.collection(ProposalsInformation).add({
            'Category': getCategory(),
            'EmployerProfile': userDocument['EmployerProfile'],
            'EmployerID': userid,
            'EmployerName': internDocument['EmployerName'],
            'Positions': getPosition().toString(),
            'ProposalDescription': getDescription(),
            'Rate': getRate(),
            'Time': getTime(),
            'CandidateList': [],
          });
        });
      } else if (userDocument['EmployerProfile'] == 'Job') {
        work.get().then((datasnapshot) {
          var workDocument = datasnapshot.data;
          firestore.collection(ProposalsInformation).add({
            'Category': getCategory(),
            'EmployerProfile': userDocument['EmployerProfile'],
            'EmployerID': userid,
            'EmployerName': workDocument['EmployerName'],
            'Positions': getPosition(),
            'ProposalDescription': getDescription(),
            'Rate': getRate(),
            'Time': getTime(),
            'CandidateList': [],
          });
        });
      }
    }
  });
}
