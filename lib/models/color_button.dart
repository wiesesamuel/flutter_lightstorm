import 'package:flutter/material.dart';
import 'package:lsd/helper/helper.dart';
import 'package:lsd/models/button_generator.dart';
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
  void flipState() => pin.flipState();
  void update() => pin.update();

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
  final String name;

  // functions
  final ReactiveController reactiveController;

  _ColorButtonApp(this.mainFrontColor, this.name, this.pin, this.reactiveController) {
    setBooleansOnList(pressed, false);
    setBooleansOnList(disabled, false);
    reactiveController.toggleStatus = () {
      setState(() {
        disabled[getCurrentModeIndex()] = !disabled[getCurrentModeIndex()];
        pin.setState(pressed[getCurrentModeIndex()] && !disabled[getCurrentModeIndex()]);
      });
    };
    disabledFrontColor = mainFrontColor.withOpacity(0.5);
  }

  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 50,
        height: 30,
        buttonColor: getFrontColor(),
        child: RaisedButton(
          onPressed: () {
            setState(() {
              pressed[getCurrentModeIndex()] = !pressed[getCurrentModeIndex()];
              pin.setState(pressed[getCurrentModeIndex()] && !disabled[getCurrentModeIndex()]);
            });
          },
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(name),
          textColor: getTextColor(),
        ));
  }

  Color getFrontColor() {
    if (pressed[getCurrentModeIndex()]) {
      if (disabled[getCurrentModeIndex()]) {
        return disabledFrontColor;
      }
      return mainFrontColor;
    }
    return Colors.white;
  }

  Color getTextColor() {
    if (pressed[getCurrentModeIndex()]) {
      return buttonTextColorConverter.getTextColor(mainFrontColor);
    }
    return Colors.black;
  }

}

// accessible functions holder
class ReactiveController {
  Function toggleStatus;
}
