import 'package:lsd/helper/helper.dart';
import 'package:lsd/pin/mode_type.dart';
import 'package:lsd/pin/pin.dart';


class PinController {
  
  ModeType currentModeType = ModeType.OnOff;
  List<bool> masterStates = List(ModeType.values.length);

  PinController() {
    setBooleansOnList(masterStates, true);
  }

  void flipMasterState(ModeType mode) {
    masterStates[mode.index] = !masterStates[mode.index];
  }

  void update(Pin pin) {
    ModeType modeInUse;
    for (int i = 0; i < ModeType.values.length; i++) {
      if (masterStates[i] && pin.states[i])
        modeInUse = ModeType.values[i];
    }
    sendPinState(pin, modeInUse);
    //TODO: raspberry communication
  }

  void sendPinState(Pin pin, ModeType mode) {
    if ( mode == null) {
      //TODO shut pin down
    }
    else {
      // TODO set pin to mode
      print(pin.pinNr.toString() + " is set to " + mode.index.toString());
    }
  }

  void setCurrentModeType(ModeType modeType) {
    currentModeType = modeType;
  }
}