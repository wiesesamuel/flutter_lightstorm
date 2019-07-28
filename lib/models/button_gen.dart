import 'package:flutter/material.dart';
import 'package:flutter_led_app/models/group_button.dart';
import 'package:flutter_led_app/pin/pin.dart';

import 'pin_button.dart';

final Color _blue = Color.fromRGBO(0, 0, 255, 1.0);
final Color _white = Color.fromRGBO(100, 100, 100, 1);
enum PinGroup { R, G, B, W }

List<PinButton> getPinButtons(List<Pin> pins) {
  List<PinButton> buttons = [];
  pins.forEach((pin) {
    buttons.add(PinButton(
      pin: pin,
    ));
  });
  return buttons;
}

GroupButton getGroupButtonSingle(int pinGroup) {
  GroupButton button;
  PinGroup.values.forEach((group) {
    if (group.index == pinGroup) {
      switch (group) {
        case PinGroup.R:
          button = GroupButton(
            name: "Red",
            color: Colors.red.withOpacity(0.5),
            pinGroup: pinGroup,
          );
          break;
        case PinGroup.G:
          button = GroupButton(
            name: "Green",
            color: Colors.green.withOpacity(0.5),
            pinGroup: pinGroup,
          );
          break;
        case PinGroup.B:
          button = GroupButton(
            name: "Blue",
            color: _blue.withOpacity(0.5),
            pinGroup: pinGroup,
          );
          break;
        case PinGroup.W:
          button = GroupButton(
            name: "White",
            color: _white.withOpacity(0.5),
            pinGroup: pinGroup,
          );
          break;
      }
      return;
    }
  });

  return button;
}

List<GroupButton> getGroupButtonGroup(List<PinGroup> pinGroup) {
  List<GroupButton> buttons = [];
  pinGroup.forEach((group) {
    buttons.add(getGroupButtonSingle(group.index));
  });
  return buttons;
}
