import 'package:flutter/material.dart';
import 'package:flutter_led_app/helper/helper.dart';
import 'package:flutter_led_app/pin/mode_type.dart';
import 'package:flutter_led_app/pin/pin.dart';

import 'button_generator.dart';
import 'pin_button.dart';

class StripeController extends StatefulWidget {
  // settings
  final PinButtonGroup pinButtonGroup;
  final String name;
  final List<Pin> pins;
  final ReactiveController reactiveController;

  StripeController(
      {Key key,
      String name,
      @required PinButtonGroup pinButtonGroup,
      @required List<Pin> pins})
      : this.name = name,
        this.pinButtonGroup = pinButtonGroup,
        this.pins = pins,
        reactiveController = ReactiveController(),
        super(key: key);

  @override
  _StripeControllerState createState() => _StripeControllerState(
      name,
      buttonGroupConverter.getButtons(pinButtonGroup, pins),
      reactiveController);

  void updateAllMembers() => reactiveController.updateAllMembers();

  void updateUI() => reactiveController.updateUI();

  List<bool> getGroupMembersStates(PinGroup pinGroup) =>
      reactiveController.getGroupMembersStates(pinGroup);

  void setGroupMembersStates(PinGroup pinGroup, bool state) =>
      reactiveController.setGroupMembersStates(pinGroup, state);
/*
  Map<String, dynamic> getJson() => {
        'name': name,
        'buttonGroup': buttonGroup,
      };

  StripeController.fromJson(Map<String, dynamic> json) {
    pins = List();
    name = json['name'];
    buttonGroup = json['buttonGroup'];
  }
  */
}

class _StripeControllerState extends State<StripeController> {
  static final String on = "Currently on";
  static final String off = "Currently off";

  // children
  List<PinButton> buttons;

  // state
  List<bool> pressed = List(ModeType.values.length);

  // functions
  final ReactiveController reactiveController;

  // depiction
  String name;
  Text subtitle = Text("");

  _StripeControllerState(this.name, this.buttons, this.reactiveController) {
    setBooleansOnList(pressed, true);
    reactiveController.updateAllMembers = () {
      buttons.forEach((button) {
        button.update();
      });
    };
    reactiveController.updateUI = () {
      buttons.forEach((button) {
        button.updateUI();
      });
      setState(() {});
    };
    reactiveController.getGroupMembersStates = (PinGroup pinGroup) {
      List<bool> result = [];
      buttons.forEach((button) {
        bool state = button.getGroupMemberState(pinGroup);
        if (state != null) result.add(state);
      });
      return result;
    };
    reactiveController.setGroupMembersStates = (PinGroup pinGroup, bool state) {
      buttons.forEach((button) {
        button.setGroupMemberState(pinGroup, state);
      });
    };
  }

  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.addAll(buttons);
    return Container(
      child: ListTile(
        contentPadding: null,
        dense: true,
        title: Text(name),
        //subtitle: Text(controllerState ? on : off),
        trailing: Container(
            //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            child: Row(
          children: children,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
        )),
        selected: pressed[getCurrentModeIndex()],
        onTap: () {
          setState(() {
            pressed[getCurrentModeIndex()] = !pressed[getCurrentModeIndex()];
            buttons.forEach((b) {
              b.toggleStatus();
            });
          });
        },
      ),
    );
  }
}

// accessible functions holder
class ReactiveController {
  Function updateAllMembers;
  Function updateUI;
  Function getGroupMembersStates;
  Function setGroupMembersStates;
}
