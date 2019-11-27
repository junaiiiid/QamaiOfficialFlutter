import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/modules/user_information.dart';
import 'package:qamai_official/database/firebase.dart';
import 'package:qamai_official/database/firebase_data_reciever.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:toast/toast.dart';
import 'package:image_cropper/image_cropper.dart';



class ProfileOverview extends StatefulWidget {
  final BuildContext buildcontext;

  ProfileOverview({Key key, this.buildcontext}) : super(key: key);

  @override
  _ProfileOverviewState createState() => _ProfileOverviewState();
}


class _ProfileOverviewState extends State<ProfileOverview> {

  Future uploadPic(context) async{

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
        )
    );

    _image=croppedFile;

    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("ProfilePicture/$fileName");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    Toast.show("Profile Picture Uploaded", widget.buildcontext, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    String url = (await firebaseStorageRef.getDownloadURL()).toString();
    setimageURL(url);
    UpdateProfilePicture(widget.buildcontext, url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: (){
              uploadPic(widget.buildcontext);
            },
            child: FirebaseProfilePicture(),
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
                child: FirebaseName(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: FirebaseStory(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: IconButton(
                  icon: Icon(
                    OMIcons.edit,
                    color: QamaiGreen,
                    size: 25.0,
                  ),
                  onPressed: () {
                    Update(widget.buildcontext);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
