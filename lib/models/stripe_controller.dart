import 'package:flutter/material.dart';

import 'color_button.dart';

class StripeController extends StatefulWidget {
  StripeController({Key key}) : super(key: key);

  @override
  _StripeControllerApp createState() => _StripeControllerApp();
}

class _StripeControllerApp extends State<StripeController> {
  // children
  List<ColorButton> buttons = [
    ColorButton(name: "Red", color: Colors.red),
    ColorButton(name: "Green", color: Colors.green),
    ColorButton(name: "Blue", color: Color.fromRGBO(0, 0, 255, 1.0))
  ];

  // state
  bool controllerState = false;

  // depiction
  Color controllerColor = Colors.red;

  Widget build(BuildContext context) {
    List<Widget> children = [
      ButtonTheme(
          minWidth: 10,
          height: 20,
          buttonColor: controllerColor,
          child: RaisedButton(
              onPressed: () {
                setState(() {
                  controllerState = !controllerState;
                  updateDepiction();
                  buttons.forEach((b) {
                    b.toggleStatus();
                    print(b.isPressed);
                  });
                });
              },
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text("Test")))
    ];
    children.addAll(buttons);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(children: children));
  }

  void updateDepiction() {
    if (controllerState)
      controllerColor = Colors.blueGrey;
    else
      controllerColor = Colors.red;
  }
}
