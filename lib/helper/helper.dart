import 'package:lsd/controller/controller.dart';
import 'package:lsd/pin/mode_type.dart';
import 'package:lsd/pin/pin.dart';

void setBooleansOnList(List<bool> list, bool value) {
  for(int i = 0; i < list.length; i++) {
    list[i] = value;
  }
}

void unifyLists(List<bool> target, List<bool> source) {
  if (target.length != source.length)
    throw FormatException("Size of lists isnt equal");
  for(int i = 0; i < target.length; i++) {
    target[i] = source[i];
  }
}

int getCurrentModeIndex() {
  return pinController.currentModeType.index;
}

int getCurrentHighestPrioritizedModeInUse(Pin pin) {
  ModeType inUse = pinController.getHighestPrioritizedModeInUse(pin);
  if (inUse == null)
    return -1;
  return inUse.index;
}