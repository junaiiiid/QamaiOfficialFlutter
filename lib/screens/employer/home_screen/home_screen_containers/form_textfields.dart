import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qamai_official/constants.dart';
import 'package:qamai_official/containers/widgets/button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EmployerFormTextFields extends StatelessWidget {
  final label;
  final onChanged;
  final max;

  EmployerFormTextFields(this.label, this.onChanged, this.max);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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

class EmployerFormBigTextFields extends StatelessWidget {
  final label;
  final onChanged;
  final max;

  EmployerFormBigTextFields(this.label, this.onChanged, this.max);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13, right: 13, bottom: 7.5),
      child: Container(
        height: 200,
        padding: EdgeInsets.all(10.0),
        child: new ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200.0,
          ),
          child: new Scrollbar(
            child: new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: SizedBox(
                height: 150.0,
                child: new TextField(
                  onChanged: onChanged,
                  maxLength: max,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  maxLines: max,
                  decoration: new InputDecoration(
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
      ),
    );
  }
}
