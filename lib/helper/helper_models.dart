import 'package:flutter_led_app/pin/mode_type.dart';
import 'package:flutter_led_app/pin/pin.dart';
import 'package:flutter_led_app/views/views.dart';

void setBooleansOnList(List list, bool value) {
  for(int i = 0; i < list.length; i++) {
    list[i] = value;
  }
}

void unifyLists(List target, List source) {
  if (target.length != source.length)
    throw FormatException("Size of lists isnt equal");
  for(int i = 0; i < target.length; i++) {
    target[i] = source[i];
  }
}

int getCurrentModeIndex() {
  return modelController.currentModeType.index;
}

int getCurrentHighestPrioritizedModeInUse(Pin pin) {
  ModeType inUse = modelController.getHighestPrioritizedModeInUse(pin);
  if (inUse == null)
    return -1;
  return inUse.index;
}