import 'package:flutter/material.dart';
import 'package:lsd/models/group_button.dart';
import 'package:lsd/pin/pin.dart';

import 'pin_button.dart';

final PinButtonGroupConverter buttonGroupConverter = PinButtonGroupConverter();
final PinButtonSingleConverter _buttonSingleConverter =
    PinButtonSingleConverter();

final Color _blue = Color.fromRGBO(0, 0, 255, 1.0);
final Color _white = Color.fromRGBO(100, 100, 100, 1);

enum PinGroup { R, G, B, W }

PinGroup _getPinGroup(PinButtonSingle buttonType) {
  switch (buttonType) {
    case PinButtonSingle.R:
      return PinGroup.R;
    case PinButtonSingle.G:
      return PinGroup.G;
    case PinButtonSingle.B:
      return PinGroup.B;
    case PinButtonSingle.W:
      return PinGroup.W;
  }
}

GroupButton getGroupButtonSingle(PinGroup pinGroup) {
  switch (pinGroup) {
    case PinGroup.R:
      return GroupButton(
        name: "Red",
        color: Colors.red.withOpacity(0.5),
        pinGroup: pinGroup,
      );
    case PinGroup.G:
      return GroupButton(
        name: "Green",
        color: Colors.green.withOpacity(0.5),
        pinGroup: pinGroup,
      );
    case PinGroup.B:
      return GroupButton(
        name: "Blue",
        color: _blue.withOpacity(0.5),
        pinGroup: pinGroup,
      );
    case PinGroup.W:
      return GroupButton(
        name: "White",
        color: _white.withOpacity(0.5),
        pinGroup: pinGroup,
      );
  }
}

List<GroupButton> getGroupButtonGroup(List<PinGroup> pinGroup) {
  List<GroupButton> buttons = [];
  pinGroup.forEach((group) {
    buttons.add(getGroupButtonSingle(group));
  });
  return buttons;
}

enum PinButtonSingle { R, G, B, W }

class PinButtonSingleConverter {
  PinButton getPinButton(PinButtonSingle pinButtonSingle, Pin pin) {
    pin.addGroup(_getPinGroup(pinButtonSingle));
    switch (pinButtonSingle) {
      case PinButtonSingle.R:
        return PinButton(
          name: "Red",
          color: Colors.red,
          pin: pin,
        );
      case PinButtonSingle.G:
        return PinButton(
          name: "Green",
          color: Colors.green,
          pin: pin,
        );
      case PinButtonSingle.B:
        return PinButton(
          name: "Blue",
          color: _blue,
          pin: pin,
        );
      case PinButtonSingle.W:
        return PinButton(
          name: "White",
          color: _white,
          pin: pin,
        );
        break;
    }
  }
}

enum PinButtonGroup { RGB, RGBW }

class PinButtonGroupConverter {
  List<PinButton> getButtons(PinButtonGroup buttonGroup, List<Pin> pins) {
    _checkSize(buttonGroup, pins);
    switch (buttonGroup) {
      case PinButtonGroup.RGB:
        return [
          _buttonSingleConverter.getPinButton(PinButtonSingle.R, pins[0]),
          _buttonSingleConverter.getPinButton(PinButtonSingle.G, pins[1]),
          _buttonSingleConverter.getPinButton(PinButtonSingle.B, pins[2]),
        ];
        break;
      case PinButtonGroup.RGBW:
        return [
          _buttonSingleConverter.getPinButton(PinButtonSingle.W, pins[3]),
          _buttonSingleConverter.getPinButton(PinButtonSingle.R, pins[0]),
          _buttonSingleConverter.getPinButton(PinButtonSingle.G, pins[1]),
          _buttonSingleConverter.getPinButton(PinButtonSingle.B, pins[2]),
        ];
        break;
    }
  }

  void _checkSize(PinButtonGroup buttonGroup, List<Pin> pins) {
    switch (buttonGroup) {
      case PinButtonGroup.RGB:
        if (pins.length != 3) _throwWrongSizeException();
        break;
      case PinButtonGroup.RGBW:
        if (pins.length != 4) _throwWrongSizeException();
        break;
    }
  }

  void _throwWrongSizeException() {
    throw FormatException(
        "Pin members doesnt match number of members from buttongroup!");
  }
}
