import 'package:flutter/material.dart';
import 'package:lsd/models/buttonGenerator.dart';
import 'package:lsd/pin/mode_type.dart';
import 'package:lsd/pin/pin.dart';

class ColorButton extends StatefulWidget {

  Color color;
  String name;
  Pin pin;
  ReactiveController reactiveController;

  ColorButton({Key key, this.color, @required this.name, this.pin})
      : reactiveController = ReactiveController(),
        super(key: key);

  @override
  _ColorButtonApp createState() {
    return _ColorButtonApp(color, name, reactiveController);
  }

  void toggleStatus() => reactiveController.toggleStatus();

  get isPressed => reactiveController.isPressed();

  void setState(ModeType mode) {
    pin.setState(mode);
  }

  void update() {
    pin.update();
  }

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

}

class _ColorButtonApp extends State<ColorButton> {

  // states
  bool pressed = false;
  bool disabled = false;

  // depiction
  Color mainFrontColor = Colors.grey;
  Color disabledFrontColor = Colors.black;
  final String name;

  // functions
  final ReactiveController reactiveController;

  _ColorButtonApp(this.mainFrontColor, this.name, this.reactiveController) {
    reactiveController.toggleStatus = () {
      setState(() {
        disabled = !disabled;
        reactiveController.update();
      });
    };
    reactiveController.isPressed = () {
      return pressed;
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
              pressed = !pressed;
              reactiveController.update();
            });
          },
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(name),
          textColor: getTextColor(),
        ));
  }

  Color getFrontColor() {
    if (pressed) {
      if (disabled) {
        return disabledFrontColor;
      }
      return mainFrontColor;
    }
    return Colors.white;
  }

  Color getTextColor() {
    if (pressed) {
      return buttonTextColorConverter.getTextColor(mainFrontColor);
    }
    return Colors.black;
  }
}

// accessible functions holder
class ReactiveController {
  Function toggleStatus;
  Function isPressed;
  Function getJson;
  Function update;
  Function setState;
}
