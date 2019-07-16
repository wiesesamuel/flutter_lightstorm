import 'package:flutter_led_app/helper/helper.dart';
import 'package:flutter_led_app/pin/mode_type.dart';
import 'package:flutter_led_app/pin/pin.dart';

class PinController {
  ModeType currentModeType = ModeType.OnOff;
  List<bool> masterStates = List(ModeType.values.length);

  PinController() {
    setBooleansOnList(masterStates, true);
  }

  void flipMasterState(ModeType mode) {
    masterStates[mode.index] = !masterStates[mode.index];
  }

  ModeType getHighestPrioritizedModeInUse(Pin pin) {
    ModeType modeInUse;
    for (int i = 0; i < ModeType.values.length; i++) {
      if (masterStates[i] && pin.states[i]) modeInUse = ModeType.values[i];
    }
    return modeInUse;
  }

  void update(Pin pin) {
    sendPinState(pin, getHighestPrioritizedModeInUse(pin));
    //TODO: raspberry communication
  }

  void sendPinState(Pin pin, ModeType mode) {
    if (mode == null) {
      //TODO shut pin down
      print(pin.pinNr.toString() + " is OFF");
    } else {
      // TODO set pin to mode
      print(pin.pinNr.toString() +
          " is ON in mode: " +
          modeTypeHelper.getName(mode));
    }
  }

  void setCurrentModeType(ModeType modeType) {
    currentModeType = modeType;
    //modelController.updateAllMembers();
  }
}
