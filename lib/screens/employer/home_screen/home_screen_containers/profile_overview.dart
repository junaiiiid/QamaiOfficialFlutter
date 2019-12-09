import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/modules/employer_information.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:toast/toast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EmployerProfileOverview extends StatefulWidget {
  EmployerProfileOverview({
    Key key,
  }) : super(key: key);

  @override
  _EmployerProfileOverviewState createState() =>
      _EmployerProfileOverviewState();
}

class _EmployerProfileOverviewState extends State<EmployerProfileOverview> {
  Future uploadPic(context) async {
    File _image;
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 50,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            backgroundColor: QamaiGreen,
            activeControlsWidgetColor: QamaiGreen,
            activeWidgetColor: QamaiThemeColor,
            toolbarTitle: 'Cropper',
            toolbarColor: QamaiThemeColor,
            toolbarWidgetColor: QamaiGreen,
            cropFrameColor: QamaiGreen,
            cropGridColor: QamaiGreen,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    _image = croppedFile;

    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("ProfilePicture/$fileName");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    Toast.show("Profile Picture Uploaded", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    String url = (await firebaseStorageRef.getDownloadURL()).toString();
    setimageURL(url);
    UpdateEmployerProfilePicture(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              uploadPic(context);
            },
            child: EmployerProfilePicture(),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: EmployerName(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: EmployerDesignation(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: IconButton(
                  icon: Icon(
                    OMIcons.verifiedUser,
                    color: QamaiGreen,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmployerProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUser();
    return StreamBuilder(
      stream: Firestore.instance
          .collection(UserInformation)
          .document(userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;
          if (userDocument['EmployerProfile'] == 'Internship') {
            return StreamBuilder(
              stream: Firestore.instance
                  .collection(InternshipInformation)
                  .document(userid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                    minRadius: 30,
                    maxRadius: 60,
                    backgroundImage:
                        NetworkImage(snapshot.data['ProfilePicture']),
                    backgroundColor: QamaiGreen,
                  );
                } else {
                  return CircleAvatar(
                    minRadius: 30,
                    maxRadius: 60,
                    backgroundColor: QamaiGreen,
                  );
                }
              },
            );
          } else {
            return StreamBuilder(
              stream: Firestore.instance
                  .collection(WorkInformation)
                  .document(userid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                    minRadius: 30,
                    maxRadius: 60,
                    backgroundImage:
                        NetworkImage(snapshot.data['ProfilePicture']),
                    backgroundColor: QamaiGreen,
                  );
                } else {
                  return CircleAvatar(
                    minRadius: 30,
                    maxRadius: 60,
                    backgroundColor: QamaiGreen,
                  );
                }
              },
            );
          }
        } else {
          return CircleAvatar(
            minRadius: 30,
            maxRadius: 60,
            backgroundColor: QamaiGreen,
          );
        }
      },
    );
  }
}

class EmployerName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUser();
    return StreamBuilder(
      stream: Firestore.instance
          .collection(UserInformation)
          .document(userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;
          if (userDocument['EmployerProfile'] == 'Internship') {
            return StreamBuilder(
              stream: Firestore.instance
                  .collection(InternshipInformation)
                  .document(userid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AutoSizeText(
                    snapshot.data['EmployerName'],
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                        color: QamaiThemeColor,
                        fontSize: 18.0),
                    minFontSize: 15,
                    maxFontSize: 18,
                    maxLines: 1,
                  );
                } else {
                  return AutoSizeText(
                    'LOADING...',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                        color: QamaiThemeColor,
                        fontSize: 18.0),
                    minFontSize: 15,
                    maxFontSize: 18,
                    maxLines: 1,
                  );
                }
              },
            );
          } else {
            return StreamBuilder(
              stream: Firestore.instance
                  .collection(WorkInformation)
                  .document(userid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AutoSizeText(
                    snapshot.data['EmployerName'],
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                        color: QamaiThemeColor,
                        fontSize: 18.0),
                    minFontSize: 15,
                    maxFontSize: 18,
                    maxLines: 1,
                  );
                } else {
                  return AutoSizeText(
                    'LOADING...',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                        color: QamaiThemeColor,
                        fontSize: 18.0),
                    minFontSize: 15,
                    maxFontSize: 18,
                    maxLines: 1,
                  );
                }
              },
            );
          }
        } else {
          return AutoSizeText(
            'LOADING...',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
                color: QamaiThemeColor,
                fontSize: 18.0),
            minFontSize: 15,
            maxFontSize: 18,
            maxLines: 1,
          );
        }
      },
    );
  }
}

class EmployerDesignation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUser();
    return StreamBuilder(
      stream: Firestore.instance
          .collection(UserInformation)
          .document(userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userDocument = snapshot.data;
          if (userDocument['EmployerProfile'] == 'Internship') {
            return StreamBuilder(
              stream: Firestore.instance
                  .collection(InternshipInformation)
                  .document(userid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AutoSizeText(
                    snapshot.data['EmployerTitle'],
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: QamaiThemeColor,
                        decoration: TextDecoration.underline,
                        fontSize: 12.0),
                    minFontSize: 10,
                    maxFontSize: 12,
                    maxLines: 1,
                  );
                } else {
                  return AutoSizeText(
                    'LOADING...',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: QamaiThemeColor,
                        decoration: TextDecoration.underline,
                        fontSize: 12.0),
                    minFontSize: 10,
                    maxFontSize: 12,
                    maxLines: 1,
                  );
                }
              },
            );
          } else {
            return StreamBuilder(
              stream: Firestore.instance
                  .collection(WorkInformation)
                  .document(userid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AutoSizeText(
                    snapshot.data['EmployerTitle'],
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: QamaiThemeColor,
                        decoration: TextDecoration.underline,
                        fontSize: 12.0),
                    minFontSize: 10,
                    maxFontSize: 12,
                    maxLines: 1,
                  );
                } else {
                  return AutoSizeText(
                    'LOADING...',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: QamaiThemeColor,
                        decoration: TextDecoration.underline,
                        fontSize: 12.0),
                    minFontSize: 10,
                    maxFontSize: 12,
                    maxLines: 1,
                  );
                }
              },
            );
          }
        } else {
          return AutoSizeText(
            'LOADING...',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: QamaiThemeColor,
                decoration: TextDecoration.underline,
                fontSize: 12.0),
            minFontSize: 10,
            maxFontSize: 12,
            maxLines: 1,
          );
        }
      },
    );
  }
}
