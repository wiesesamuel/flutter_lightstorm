import 'package:flutter/material.dart';

import 'color_button.dart';

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
