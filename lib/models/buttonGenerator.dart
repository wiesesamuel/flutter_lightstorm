import 'package:flutter/material.dart';
import 'package:lsd/pin/pin.dart';

import 'color_button.dart';

final ButtonTextColorConverter buttonTextColorConverter = ButtonTextColorConverter();
final ButtonGroupConverter buttonGroupConverter = ButtonGroupConverter();
final ButtonSingleConverter _buttonSingleConverter = ButtonSingleConverter();

class ButtonTextColorConverter {
  Color getTextColor(Color color) {
    switch (color.value) {
      // dark blue
      case (4278190335):
        return Colors.white;
    }
    return Colors.black;
  }
}

enum ButtonSingle { R, G, B, W }

class ButtonSingleConverter {
  ColorButton getButton(ButtonSingle buttonSingle, Pin pin) {
    switch (buttonSingle) {
      case ButtonSingle.R:
        return ColorButton(
          name: "Red",
          color: Colors.red,
          pin: pin,
        );
      case ButtonSingle.G:
        return ColorButton(
          name: "Green",
          color: Colors.green,
          pin: pin,
        );
      case ButtonSingle.B:
        return ColorButton(
          name: "Blue",
          color: Color.fromRGBO(0, 0, 255, 1.0),
          pin: pin,
        );
      case ButtonSingle.W:
        return ColorButton(
          name: "White",
          color: Color.fromRGBO(20, 20, 20, 0.7),
          pin: pin,
        );
        break;
    }
    return null;
  }
}

enum ButtonGroup { RGB, RGBW }

class ButtonGroupConverter {
  List<ColorButton> getButtons(ButtonGroup buttonGroup, List<Pin> pins) {
    checkSize(buttonGroup, pins);
    switch (buttonGroup) {
      case ButtonGroup.RGB:
        return [
          _buttonSingleConverter.getButton(ButtonSingle.R, pins[0]),
          _buttonSingleConverter.getButton(ButtonSingle.G, pins[1]),
          _buttonSingleConverter.getButton(ButtonSingle.B, pins[2]),
        ];
        break;
      case ButtonGroup.RGBW:
        return [
          _buttonSingleConverter.getButton(ButtonSingle.W, pins[3]),
          _buttonSingleConverter.getButton(ButtonSingle.R, pins[0]),
          _buttonSingleConverter.getButton(ButtonSingle.G, pins[1]),
          _buttonSingleConverter.getButton(ButtonSingle.B, pins[2]),
        ];
        break;
    }
    return null;
  }

  void checkSize(ButtonGroup buttonGroup, List<Pin> pins) {
    switch (buttonGroup) {
      case ButtonGroup.RGB:
        if (pins.length != 3) throwWrongSizeException();
        break;
      case ButtonGroup.RGBW:
        if (pins.length != 4) throwWrongSizeException();
        break;
    }
  }

  void throwWrongSizeException() {
    throw FormatException(
        "Pin members doesnt match number of members from buttongroup!");
  }
}
