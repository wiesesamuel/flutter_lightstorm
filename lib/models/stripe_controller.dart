import 'package:flutter/material.dart';
import 'package:flutter_led_app/helper/helper_models.dart';
import 'package:flutter_led_app/models/button_gen.dart';
import 'package:flutter_led_app/pin/mode_type.dart';
import 'package:flutter_led_app/pin/stripe.dart';
import 'pin_button.dart';

class StripeController extends StatefulWidget {
  // settings
  final Stripe stripe;
  final ReactiveController reactiveController;
  final List<PinButton> buttons;

  StripeController({Key key, @required Stripe stripe})
      : this.stripe = stripe,
        this.buttons = getPinButtons(stripe.pins),
        reactiveController = ReactiveController(),
        super(key: key);

  @override
  _StripeControllerState createState() =>
      _StripeControllerState(stripe.name, buttons, reactiveController);

  void updateAllMembers() => reactiveController.updateAllMembers();

  void updateUI() => reactiveController.updateUI();

  List<bool> getGroupMembersStates(int pinGroup) =>
      reactiveController.getGroupMembersStates(pinGroup);

  void setGroupMembersStates(int pinGroup, bool state) =>
      reactiveController.setGroupMembersStates(pinGroup, state);

  bool updateStripe(Stripe stripe) {
    // check if id identical
    if (this.stripe.id == stripe.id) {
      // check if pins are identical
      if (this.stripe.pins.length == stripe.pins.length &&
          stripe.pins.length == buttons.length) {
        // check if pins are identical
        bool pinFound = false;
        for (var pin in stripe.pins) {
          pinFound = false;
          for (var pinButton in buttons) {
            if (pinButton == null)
              break;
            pinFound = pinButton.updatePin(pin);
            if (pinFound) break;
          }
          if (!pinFound) break;
        }
        return pinFound;
      }
    }
    return false;
  }
}

class _StripeControllerState extends State<StripeController> {
  // children
  List<PinButton> buttons;

  // state
  List<bool> pressed = List(ModeType.values.length);

  // functions
  final ReactiveController reactiveController;

  // depiction
  String name;

  _StripeControllerState(this.name, this.buttons, this.reactiveController) {
    setBooleansOnList(pressed, true);
    reactiveController.updateAllMembers = () {
      buttons.forEach((button) {
        button.update();
      });
    };
    reactiveController.updateUI = () {
      buttons.forEach((button) {
        button.updateUI();
      });
      setState(() {});
    };
    reactiveController.getGroupMembersStates = (int pinGroup) {
      List<bool> result = [];
      buttons.forEach((button) {
        bool state = button.getGroupMemberState(pinGroup);
        if (state != null) result.add(state);
      });
      return result;
    };
    reactiveController.setGroupMembersStates = (int pinGroup, bool state) {
      buttons.forEach((button) {
        button.setGroupMemberState(pinGroup, state);
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
  Function updateUI;
  Function getGroupMembersStates;
  Function setGroupMembersStates;
}
