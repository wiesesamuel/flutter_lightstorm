import 'package:flutter/material.dart';
import 'package:flutter_led_app/helper/helper_models.dart';
import 'package:flutter_led_app/models/app_theme.dart';
import 'package:flutter_led_app/pin/mode_type.dart';
import 'package:flutter_led_app/pin/pin.dart';

class PinButton extends StatefulWidget {
  final Color color;
  final String name;
  final Pin pin;
  final ReactiveController reactiveController;

  PinButton({Key key, @required this.color, @required this.name, @required this.pin})
      : reactiveController = ReactiveController(),
        super(key: key);

  @override
  _ColorButtonApp createState() {
    return _ColorButtonApp(color, name, pin, reactiveController);
  }

  void toggleStatus() => reactiveController.toggleStatus();

  void flipState() => reactiveController.flipState();

  void setState(bool state) => reactiveController.setState(state);

  void update() => reactiveController.update();

  void updateUI() => reactiveController.updateUI();

  bool getGroupMemberState(int pinGroup) =>
      reactiveController.getGroupMemberState(pinGroup);

  void setGroupMemberState(int pinGroup, bool state) =>
      reactiveController.setGroupMemberState(pinGroup, state);

  bool updatePin(Pin pin) {
    if (this.pin.id == pin.id) {
      this.pin.updatePinValues(pin);
      return true;
    }
    return false;
  }
}

class _ColorButtonApp extends State<PinButton> {
  final Pin pin;

  // states
  List<bool> pressed = List(ModeType.values.length);
  List<bool> disabled = List(ModeType.values.length);

  // depiction
  Color mainFrontColor = Colors.grey;
  Color disabledFrontColor = Colors.black;
  Color inUseFrontColor = Colors.black;
  final String name;

  // functions
  final ReactiveController reactiveController;

  _ColorButtonApp(
      this.mainFrontColor, this.name, this.pin, this.reactiveController) {
    unifyLists(pressed, pin.states);
    setBooleansOnList(disabled, false);
    reactiveController.toggleStatus = () {
      setState(() {
        disabled[getCurrentModeIndex()] = !disabled[getCurrentModeIndex()];
        pin.setState(
            pressed[getCurrentModeIndex()] && !disabled[getCurrentModeIndex()]);
      });
    };
    reactiveController.flipState = () {
      setState(() {
        pressed[getCurrentModeIndex()] = !pressed[getCurrentModeIndex()];
        pin.setState(
            pressed[getCurrentModeIndex()] && !disabled[getCurrentModeIndex()]);
      });
    };
    reactiveController.setState = (bool state) {
      setState(() {
        pressed[getCurrentModeIndex()] = state;
        pin.setState(
            pressed[getCurrentModeIndex()] && !disabled[getCurrentModeIndex()]);
      });
    };
    reactiveController.update = () {
      setState(() {
        pin.setState(
            pressed[getCurrentModeIndex()] && !disabled[getCurrentModeIndex()]);
      });
    };
    reactiveController.updateUI = () {
      setState(() {});
    };
    reactiveController.getGroupMemberState = (int pinGroup) {
      if (!pin.isGroup(pinGroup)) return null;
      return pin.states[getCurrentModeIndex()];
    };
    reactiveController.setGroupMemberState = (int pinGroup, bool state) {
      if (pin.isGroup(pinGroup)) reactiveController.setState(state);
    };
    disabledFrontColor = mainFrontColor.withOpacity(0.7);
    inUseFrontColor = mainFrontColor.withOpacity(0.2);
  }

  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 50,
        height: 30,
        buttonColor: getFrontColor(),
        child: RaisedButton(
          onPressed: () {
            setState(() {
              reactiveController.flipState();
            });
          },
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(name),
          textColor: getTextColor(),
        ));
  }

  Color getFrontColor() {
    if (pressed[getCurrentModeIndex()]) {
      if (getCurrentHighestPrioritizedModeInUse(pin) > getCurrentModeIndex())
        return inUseFrontColor;
      if (disabled[getCurrentModeIndex()]) {
        return disabledFrontColor;
      }
      return mainFrontColor;
    }
    return getDefaultButtonFrontColor();
  }

  Color getTextColor() {
    if (pressed[getCurrentModeIndex()]) {
      return getButtonTextColor(mainFrontColor);
    }
    return getDefaultButtonTextColor();
  }
}

// accessible functions holder
class ReactiveController {
  Function toggleStatus;
  Function update;
  Function updateUI;
  Function flipState;
  Function setState;
  Function getGroupMemberState;
  Function setGroupMemberState;
}
