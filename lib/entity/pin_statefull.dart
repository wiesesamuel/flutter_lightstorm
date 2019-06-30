import 'package:lsd/entity/pin_type.dart';

import './pin.dart';
import './mode_type.dart';

class PinStatefull extends Pin {
  bool state;
  ModeType mode;
  List<int> group;

  PinStatefull(int pinNr, PinType pinTyp) : super(pinNr, pinTyp);

  void addGroup(int group) {
    if (!this.group.contains(group))
      this.group.add(group);
  }

  void rmGroup(int group) {
    if (this.group.contains(group))
      this.group.remove(group);
  }

  bool isGroup(int group) => this.group.contains(group);



  void flip() {
    state = !state;
  }
}