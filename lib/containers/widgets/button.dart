import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';

class Button extends StatelessWidget {


  final Color color;
  final String text;
  final Function onpress;

  Button({@required this.color,@required this.text,this.onpress});

  @override
  Widget build(BuildContext context) {
    return NiceButton(
      width: 150,
      elevation: 0.0,
      radius: 20.0,
      text: text,
      fontSize: 15,
      background: color,
      onPressed: onpress,

    );
  }
}

class DisabledButton extends StatelessWidget {


  final Color color;
  final String text;

  DisabledButton({@required this.color,@required this.text});

  @override
  Widget build(BuildContext context) {
    return NiceButton(
      width: 150,
      elevation: 0.0,
      radius: 20.0,
      text: text,
      fontSize: 15,
      background: color,

    );
  }
}