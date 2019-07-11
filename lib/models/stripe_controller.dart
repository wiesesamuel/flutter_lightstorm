import 'package:flutter/material.dart';
import 'package:lsd/pin/pin.dart';

import 'buttonGenerator.dart';
import 'color_button.dart';

class StripeController extends StatefulWidget {
  static final ButtonGroupConverter _buttonGroupConverter =
      ButtonGroupConverter();
  ButtonGroup buttonGroup;
  String name;
  List<Pin> pins;

  StripeController(
      {Key key,
      String name,
      @required ButtonGroup buttonGroup,
      @required List<Pin> pins})
      : this.name = name,
        this.buttonGroup = buttonGroup,
        this.pins = pins,
        super(key: key);

  @override
  _StripeControllerState createState() => _StripeControllerState(
      name, _buttonGroupConverter.getButtons(buttonGroup, pins));

  Map<String, dynamic> getJson() => {
        'name': name,
        'buttonGroup': buttonGroup,
      };

  StripeController.fromJson(Map<String, dynamic> json) {
    pins = List();
    name = json['name'];
    buttonGroup = json['buttonGroup'];
  }
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
  Function update;
  Function setState;
}
