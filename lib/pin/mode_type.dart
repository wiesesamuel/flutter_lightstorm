import 'package:flutter/material.dart';

final ModeTypeHelper modeTypeHelper = ModeTypeHelper();

// enum index is also priority
enum ModeType {
  OnOff,
  Toggle,
  Music
}

class ModeTypeHelper {
  String getName(ModeType mode) {
    switch(mode){
      case ModeType.OnOff:
        return "OnOff";
      case ModeType.Toggle:
        return "toggle";
      case ModeType.Music:
        return "music";
    }
    return null;
  }

  IconData getIconData(ModeType mode) {
    switch(mode){
      case ModeType.OnOff:
        return Icons.brightness_6;
      case ModeType.Toggle:
        return Icons.wb_incandescent;
      case ModeType.Music:
        return Icons.audiotrack;
    }
    return null;
  }

}