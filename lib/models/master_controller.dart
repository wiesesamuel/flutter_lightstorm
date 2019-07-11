import 'package:flutter/material.dart';
import 'package:lsd/models/stripe_controller.dart';
import 'package:lsd/pin/mode_type.dart';

import 'buttonGenerator.dart';

class MasterController extends StatefulWidget {
  final ModeType modeType;

  MasterController({Key key, this.modeType}) : super(key: key);

  @override
  _MasterControllerState createState() => _MasterControllerState();
}

class _MasterControllerState extends State<MasterController> {
  // children
  List<StripeController> stripes;

  // state
  bool controllerState = true;

  _MasterControllerState();

  Widget build(BuildContext context) {
    return ListView(
      children: [
        StripeController(name: "Tisch", buttonGroup: ButtonGroup.RGB),
        StripeController(name: "Fenster", buttonGroup: ButtonGroup.RGB),
        StripeController(name: "Schrank", buttonGroup: ButtonGroup.RGB),
      ],
    );
  }
}

// accessible functions holder
class ReactiveController {
  Function update;
  Function setState;
}
