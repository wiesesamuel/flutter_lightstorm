import 'package:flutter/material.dart';
import 'package:flutter_led_app/models/button_gen.dart';
import 'package:flutter_led_app/models/group_controller.dart';
import 'package:flutter_led_app/models/stripe_controller.dart';
import 'package:flutter_led_app/pin/stripe.dart';

class ModelController {
  // children
  //final Client client = new Client("192.168.0.11", 5000);

  List<Widget> content = [];

  List<GroupController> groups = [
    GroupController([PinGroup.W, PinGroup.R, PinGroup.G, PinGroup.B]),
  ];

  List<Stripe> stripes = [];

  List<StripeController> stripeController = [];

  void updateAllMembers() {
    stripeController.forEach((stripe) {
      stripe.updateAllMembers();
    });
  }

  void updateUI() {
    stripeController.forEach((stripe) {
      stripe.updateUI();
    });
  }

  List<Widget> getAllMembers() {
    return content;
  }

  void addStripe(String json) {

  }

  void unifyPinGroupState(int pinGroup) {
    // get group members states
    List<bool> states = [];
    stripeController.forEach((stripe) {
      states.addAll(stripe.getGroupMembersStates(pinGroup));
    });

    // no group members
    if (states.length == 0) return;

    // compute resulting state
    bool resultingState;
    bool state = states[0];
    states.forEach((groupState) {
      if (state != groupState) {
        resultingState = false;
        return;
      }
    });

    if (resultingState == null) resultingState = !state;

    // set unified state
    stripeController.forEach((stripe) {
      stripe.setGroupMembersStates(pinGroup, resultingState);
    });
  }

  ModelController() {
    for (int i = 0; i < groups.length; i++) {
      content.add(groups[i]);
    }
    for (int i = 0; i < stripeController.length; i++) {
      content.add(stripeController[i]);
    }
  }
}
