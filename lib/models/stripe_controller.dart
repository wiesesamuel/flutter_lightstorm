import 'package:flutter/material.dart';

import 'buttonGenerator.dart';
import 'color_button.dart';

class StripeController extends StatefulWidget {
  static final ButtonGroupConverter _buttonGroupConverter =
      ButtonGroupConverter();
  final ButtonGroup buttonGroup;
  final String name;

  StripeController({Key key, String name, @required ButtonGroup buttonGroup})
      : this.name = name,
        this.buttonGroup = buttonGroup,
        super(key: key);

  @override
  _StripeControllerState createState() => _StripeControllerState(
      name, _buttonGroupConverter.getButtons(buttonGroup));
}

class _StripeControllerState extends State<StripeController> {
  static final String on = "Currently on";
  static final String off = "Currently off";

  // children
  List<ColorButton> buttons;

  // state
  bool controllerState = true;

  // depiction
  String name;
  Color controllerColor = Colors.red;
  Text subtitle = Text("");

  _StripeControllerState(this.name, this.buttons);

  Widget build(BuildContext context) {
    List<Widget> children = [
      /*
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
              */
    ];
    children.addAll(buttons);
    return Container(
      //height: 30.0,
      child: ListTile(
        title: Text(name),
        //subtitle: Text(controllerState ? on : off),
        trailing: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            child: Row(
              children: children,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
            )),
        selected: controllerState,
        onTap: () {
          setState(() {
            controllerState = !controllerState;
            print(controllerState);
            updateDepiction();
            buttons.forEach((b) {
              b.toggleStatus();
            });
          });
        },
      ),
    );
  }

  void updateDepiction() {
    if (controllerState)
      controllerColor = Colors.blueGrey;
    else
      controllerColor = Colors.red;
  }
}
