import 'package:flutter/material.dart';

import 'color_button.dart';

enum ButtonTextStates {
  on, off
}

final ButtonTextColorConverter buttonTextColorConverter = ButtonTextColorConverter();

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


enum ButtonSingle {
  R, G, B
}

class ButtonSingleConverter {
  ColorButton getButton(ButtonSingle buttonSingle) {
    switch(buttonSingle) {
      case ButtonSingle.R:
        return ColorButton(name: "Red", color: Colors.red);
      case ButtonSingle.G:
        return ColorButton(name: "Green", color: Colors.green);
      case ButtonSingle.B:
        return ColorButton(name: "Blue", color: Color.fromRGBO(0, 0, 255, 1.0));
    }
    return null;
  }
}

enum ButtonGroup { RGB }

class ButtonGroupConverter {

  ButtonSingleConverter _buttonSingleConverter = ButtonSingleConverter();

  List<ColorButton> getButtons(ButtonGroup buttonGroup) {
    switch (buttonGroup) {
      case ButtonGroup.RGB:
        return [
          _buttonSingleConverter.getButton(ButtonSingle.R),
          _buttonSingleConverter.getButton(ButtonSingle.G),
          _buttonSingleConverter.getButton(ButtonSingle.B),
        ];
        break;
    }
    return null;
  }
}
