import 'package:flutter/material.dart';

class ColorButton extends StatefulWidget {
  final Color color;
  final String name;
  final ReactiveController reactiveController;

  ColorButton({Key key, this.color, @required this.name})
      : reactiveController = ReactiveController(),
        super(key: key);

  @override
  _ColorButtonApp createState() {
    return _ColorButtonApp(color, name, reactiveController);
  }

  void toggleStatus() => reactiveController.toggleStatus();

  get isPressed => reactiveController.isPressed();
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
}
