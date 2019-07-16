import 'package:flutter/material.dart';
import 'package:flutter_led_app/models/button_generator.dart';
import 'package:flutter_led_app/models/group_button.dart';

class GroupController extends StatefulWidget {
  final List<PinGroup> pinGroups;

  GroupController(this.pinGroups);

  @override
  _GroupControllerState createState() =>
      _GroupControllerState(getGroupButtonGroup(pinGroups));
}

class _GroupControllerState extends State<GroupController> {
  // children
  List<GroupButton> buttons;

  _GroupControllerState(this.buttons);

  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.addAll(buttons);
    return Container(
      child: ListTile(
        dense: true,
        trailing: Container(
            child: Row(
          children: children,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
        )),
      ),
    );
  }
}
