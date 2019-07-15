import 'package:flutter/material.dart';
import 'package:lsd/models/button_generator.dart';
import 'package:lsd/models/group_button.dart';

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
        //contentPadding: null,
        dense: true,
        //subtitle: Text(controllerState ? on : off),
        trailing: Container(
            //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            child: Row(
          children: children,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
        )),
      ),
    );
  }
}
