import 'package:lsd/controller/controller.dart';

void setBooleansOnList(List<bool> list, bool value) {
  for(int i = 0; i < list.length; i++) {
    list[i] = value;
  }
}

int getCurrentModeIndex() {
  return pinController.currentModeType.index;
}