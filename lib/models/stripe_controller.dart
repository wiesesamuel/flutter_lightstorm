import 'package:flutter/material.dart';
import 'package:lsd/helper/helper.dart';
import 'package:lsd/pin/mode_type.dart';
import 'package:lsd/pin/pin.dart';

import 'button_generator.dart';
import 'color_button.dart';

class StripeController extends StatefulWidget {

  // settings
  final ButtonGroup buttonGroup;
  final String name;
  final List<Pin> pins;
  final ReactiveController reactiveController;

  StripeController(
      {Key key,
      String name,
      @required ButtonGroup buttonGroup,
      @required List<Pin> pins})
      : this.name = name,
        this.buttonGroup = buttonGroup,
        this.pins = pins,
        reactiveController = ReactiveController(),
        super(key: key);

  @override
  _StripeControllerState createState() => _StripeControllerState(name,
      buttonGroupConverter.getButtons(buttonGroup, pins), reactiveController);

  void updateAllMembers() => reactiveController.updateAllMembers();
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
  List<ColorButton> buttons;

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
}
