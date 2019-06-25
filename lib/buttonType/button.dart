import 'package:flutter/material.dart';
import 'package:lsd/entity/pin.dart';

class PinButton {
  FlatButton button;
  Pin pin;

  PinButton(this.pin, Color color) {
    button = new FlatButton(onPressed: () => pin.update(), child: null);
  }

}