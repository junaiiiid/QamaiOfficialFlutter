import 'package:flutter/material.dart';
import 'package:qamai_official/modules/themes/colors.dart';

class TextInput extends StatelessWidget {

  final String hint;
  final bool passtext;
  final TextInputType keyboard;
  final Function ontap;
  final Function onchanged;
  final int Max;
  final bool enabled;

  TextInput({@required this.hint,this.passtext,this.keyboard,this.ontap,this.onchanged,this.Max,this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onchanged,
      maxLength: Max,
      onTap: ontap,
      keyboardType: keyboard,
      obscureText: passtext,
      decoration: InputDecoration(
        counterText: '',
        labelText: hint,
        labelStyle: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 18.0,
          color: LightGray,
        ),
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: LightGray, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: QamaiGreen, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}