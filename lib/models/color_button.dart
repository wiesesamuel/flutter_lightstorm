import 'package:flutter/material.dart';
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

  void update() => pin.update();

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
  Color color = Colors.black;
  Color textColor = Colors.black;
  final String name;

  // functions
  final ReactiveController reactiveController;

  _ColorButtonApp(this.color, this.name, this.reactiveController) {
    reactiveController.toggleStatus = () {
      setState(() {
        disabled = !disabled;
        updateDepiction();
      });
    };
    reactiveController.isPressed = () {
      return pressed;
    };
  }

  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 10,
        height: 40,
        buttonColor: (pressed && !disabled) ? color : Colors.white,
        child: RaisedButton(
          onPressed: () {
            setState(() {
              pressed = !pressed;
              updateDepiction();
            });
          },
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(name),
          textColor: textColor,
        ));
  }

  void updateDepiction() {
    // check state
    if (pressed && !disabled) {
      // custom depictions
      switch (color.value) {
        // dark blue
        case (4278190335):
          {
            textColor = Colors.white;
            break;
          }
        // default depiction
        default:
          textColor = Colors.black;
      }
    } else
      textColor = Colors.black;
  }
}

// accessible functions holder
class ReactiveController {
  Function toggleStatus;
  Function isPressed;
  Function getJson;
  Function update;
}
