import 'package:flutter/material.dart';
import 'package:lsd/models/stripe_controller.dart';
import 'package:lsd/pin/mode_type.dart';
import 'package:lsd/pin/pin.dart';
import 'package:lsd/pin/pin_type.dart';

import 'buttonGenerator.dart';

class MasterController extends StatefulWidget {
  final ReactiveController reactiveController;

  MasterController({Key key}) :
        reactiveController = ReactiveController(),
        super(key: key);

  @override
  _MasterControllerState createState() =>
      _MasterControllerState(reactiveController);

  void updateAllMembers() => reactiveController.updateAllMembers();
}

class _MasterControllerState extends State<MasterController> {
  // children
  List<StripeController> stripes = [
    StripeController(name: "Tisch", buttonGroup: ButtonGroup.RGB, pins: [
      Pin(0, PinType.raspberry),
      Pin(1, PinType.raspberry),
      Pin(2, PinType.raspberry),
    ]),
    StripeController(name: "Fenster", buttonGroup: ButtonGroup.RGB, pins: [
      Pin(3, PinType.raspberry),
      Pin(4, PinType.raspberry),
      Pin(5, PinType.raspberry),
    ]),
    StripeController(name: "Schrank", buttonGroup: ButtonGroup.RGB, pins: [
      Pin(6, PinType.raspberry),
      Pin(7, PinType.raspberry),
      Pin(8, PinType.raspberry),
    ]),
    StripeController(
        name: "Decke Fenster",
        buttonGroup: ButtonGroup.RGBW,
        pins: [
          Pin(0, PinType.arduinoMega),
          Pin(1, PinType.arduinoMega),
          Pin(2, PinType.arduinoMega),
          Pin(3, PinType.arduinoMega),
        ]),
    StripeController(
        name: "Decke Schräge",
        buttonGroup: ButtonGroup.RGBW,
        pins: [
          Pin(4, PinType.arduinoMega),
          Pin(5, PinType.arduinoMega),
          Pin(6, PinType.arduinoMega),
          Pin(7, PinType.arduinoMega),
        ]),
    StripeController(
        name: "Schräge Hängend",
        buttonGroup: ButtonGroup.RGBW,
        pins: [
          Pin(8, PinType.arduinoMega),
          Pin(9, PinType.arduinoMega),
          Pin(10, PinType.arduinoMega),
          Pin(11, PinType.arduinoMega),
        ]),
    StripeController(name: "Decke Tisch", buttonGroup: ButtonGroup.RGBW, pins: [
      Pin(12, PinType.arduinoMega),
      Pin(13, PinType.arduinoMega),
      Pin(14, PinType.arduinoMega),
      Pin(15, PinType.arduinoMega),
    ]),
    StripeController(name: "Decke Quer", buttonGroup: ButtonGroup.RGBW, pins: [
      Pin(16, PinType.arduinoMega),
      Pin(17, PinType.arduinoMega),
      Pin(18, PinType.arduinoMega),
      Pin(19, PinType.arduinoMega),
    ]),
  ];

  // functions
  final ReactiveController reactiveController;

  _MasterControllerState(this.reactiveController) {
    reactiveController.updateAllMembers = () {
      stripes.forEach((stripe) {
        stripe.updateAllMembers();
      });
    };
  }

  Widget build(BuildContext context) {
    return stripes;
  }
}

// accessible functions holder
class ReactiveController {
  Function updateAllMembers;
}
