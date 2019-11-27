import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flip_card/flip_card.dart';
import 'package:qamai_official/screens/home_screen/home_screen_containers/public_profile_view.dart';

Widget SearchResultCards(data, title, text, context,item) {
  return GestureDetector(
    child: Card(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data['ProfilePicture']),
            backgroundColor: QamaiGreen,
          ),
          title: AutoSizeText(
            '${data[title]}',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: QamaiThemeColor,
                fontSize: 15),
            maxLines: 1,
            maxFontSize: 15,
            minFontSize: 12,
          ),
          subtitle: AutoSizeText(
            '${data[text]}',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: QamaiThemeColor,
                fontSize: 12),
            maxLines: 1,
            maxFontSize: 12,
            minFontSize: 10,
          ),
          trailing: Column(
            children: <Widget>[
              Icon(
                OMIcons.verifiedUser,
                color: QamaiGreen,
                size: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Icon(
                OMIcons.star,
                color: QamaiGreen,
                size: 20,
              ),
            ],
          )),
    ),
    onTap: () {
      if(item==1)
        {
          //views profile of people
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PublicProfilePeople(data)),
          );
        }
      else if(item==2)
      {
        //views profile of Jobs
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PublicProfileJobs(data)),
        );
      }
      else{
        //views profile of Internships
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PublicProfileInternship(data)),
        );
      }
    },
  );
}
