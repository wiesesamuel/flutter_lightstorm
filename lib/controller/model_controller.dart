import 'package:flutter/material.dart';
import 'package:lsd/models/button_generator.dart';
import 'package:lsd/models/group_controller.dart';
import 'package:lsd/models/stripe_controller.dart';
import 'package:lsd/pin/pin.dart';
import 'package:lsd/pin/pin_type.dart';

class ModelController {
  // children
  List<Widget> content = [];

  List<GroupController> groups = [
    GroupController([PinGroup.W, PinGroup.R, PinGroup.G, PinGroup.B]),
  ];

  List<StripeController> stripes = [
    StripeController(name: "Tisch", pinButtonGroup: PinButtonGroup.RGB, pins: [
      Pin(0, PinType.raspberry),
      Pin(1, PinType.raspberry),
      Pin(2, PinType.raspberry),
    ]),
    StripeController(
        name: "Fenster",
        pinButtonGroup: PinButtonGroup.RGB,
        pins: [
          Pin(3, PinType.raspberry),
          Pin(4, PinType.raspberry),
          Pin(5, PinType.raspberry),
        ]),
    StripeController(
        name: "Schrank",
        pinButtonGroup: PinButtonGroup.RGB,
        pins: [
          Pin(6, PinType.raspberry),
          Pin(7, PinType.raspberry),
          Pin(8, PinType.raspberry),
        ]),
    StripeController(
        name: "Decke Fenster",
        pinButtonGroup: PinButtonGroup.RGBW,
        pins: [
          Pin(0, PinType.arduinoMega),
          Pin(1, PinType.arduinoMega),
          Pin(2, PinType.arduinoMega),
          Pin(3, PinType.arduinoMega),
        ]),
    StripeController(
        name: "Decke Schräge",
        pinButtonGroup: PinButtonGroup.RGBW,
        pins: [
          Pin(4, PinType.arduinoMega),
          Pin(5, PinType.arduinoMega),
          Pin(6, PinType.arduinoMega),
          Pin(7, PinType.arduinoMega),
        ]),
    StripeController(
        name: "Schräge Hängend",
        pinButtonGroup: PinButtonGroup.RGBW,
        pins: [
          Pin(8, PinType.arduinoMega),
          Pin(9, PinType.arduinoMega),
          Pin(10, PinType.arduinoMega),
          Pin(11, PinType.arduinoMega),
        ]),
    StripeController(
        name: "Decke Tisch",
        pinButtonGroup: PinButtonGroup.RGBW,
        pins: [
          Pin(12, PinType.arduinoMega),
          Pin(13, PinType.arduinoMega),
          Pin(14, PinType.arduinoMega),
          Pin(15, PinType.arduinoMega),
        ]),
    StripeController(
        name: "Decke Quer",
        pinButtonGroup: PinButtonGroup.RGBW,
        pins: [
          Pin(16, PinType.arduinoMega),
          Pin(17, PinType.arduinoMega),
          Pin(18, PinType.arduinoMega),
          Pin(19, PinType.arduinoMega),
        ]),
  ];

  void updateAllMembers() {
    stripes.forEach((stripe) {
      stripe.updateAllMembers();
    });
  }

  void updateUI() {
    stripes.forEach((stripe) {
      stripe.updateUI();
    });
  }

  List<Widget> getAllMembers() {
    return content;
  }

  void unifyPinGroupState(PinGroup pinGroup) {
    // get group members states
    List<bool> states = [];
    stripes.forEach((stripe) {
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
    stripes.forEach((stripe) {
      stripe.setGroupMembersStates(pinGroup, resultingState);
    });
  }

  ModelController() {
    for (int i = 0; i < groups.length; i++) {
      content.add(groups[i]);
    }
    for (int i = 0; i < stripes.length; i++) {
      content.add(stripes[i]);
    }
  }
}
