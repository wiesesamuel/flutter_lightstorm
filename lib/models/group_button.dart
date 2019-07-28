import 'package:flutter/material.dart';
import 'package:flutter_led_app/models/app_theme.dart';
import 'package:flutter_led_app/views/views.dart';

class GroupButton extends StatefulWidget {
  final Color color;
  final String name;
  final int pinGroup;

  GroupButton({Key key, this.color, this.name, this.pinGroup})
      : super(key: key);

  @override
  _GroupButtonState createState() {
    return _GroupButtonState(color, name, pinGroup);
  }
}

class _GroupButtonState extends State<GroupButton> {
  // depiction
  final Color color;
  final String name;
  final int pinGroup;

  _GroupButtonState(this.color, this.name, this.pinGroup);

  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 50,
        height: 30,
        buttonColor: color,
        child: RaisedButton(
          onPressed: () {
            setState(() {
              modelController.unifyPinGroupState(pinGroup);
            });
          },
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(name),
          textColor: getButtonTextColor(color),
        ));
  }
}
