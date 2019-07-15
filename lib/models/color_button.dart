import 'package:flutter/material.dart';
import 'package:lsd/helper/helper.dart';
import 'package:lsd/models/app_theme.dart';
import 'package:lsd/pin/mode_type.dart';
import 'package:lsd/pin/pin.dart';

class ColorButton extends StatefulWidget {

  final Color color;
  final String name;
  final Pin pin;
  final ReactiveController reactiveController;

  ColorButton({Key key, this.color, @required this.name, @required this.pin})
      : reactiveController = ReactiveController(),
        super(key: key);

  @override
  _ColorButtonApp createState() {
    return _ColorButtonApp(color, name, pin, reactiveController);
  }

  void toggleStatus() => reactiveController.toggleStatus();
  void flipState() => reactiveController.flipState();
  void update() => reactiveController.update();
  void updateUI() => reactiveController.updateUI();

  /*
  Map<String, dynamic> getJson() =>
      {
        'name': name,
        'color': color,
        'pin': pin.toJson(),
      };

  ColorButton.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    name = json['name'];
    pin = Pin.fromJson(json['pin']);
  }
*/
}

class _ColorButtonApp extends State<ColorButton> {
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

  _ColorButtonApp(this.mainFrontColor, this.name, this.pin, this.reactiveController) {
    unifyLists(pressed, pin.states);
    setBooleansOnList(disabled, false);
    reactiveController.toggleStatus = () {
      setState(() {
        disabled[getCurrentModeIndex()] = !disabled[getCurrentModeIndex()];
        pin.setState(pressed[getCurrentModeIndex()] && !disabled[getCurrentModeIndex()]);
      });
    };
    reactiveController.flipState = () {
      setState(() {
        pressed[getCurrentModeIndex()] = !pressed[getCurrentModeIndex()];
        pin.setState(pressed[getCurrentModeIndex()] && !disabled[getCurrentModeIndex()]);
      });
    };
    reactiveController.update = () {
      setState(() {
        pin.setState(pressed[getCurrentModeIndex()] && !disabled[getCurrentModeIndex()]);
      });
    };
    reactiveController.updateUI = () {
      setState(() {
      });
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
}
