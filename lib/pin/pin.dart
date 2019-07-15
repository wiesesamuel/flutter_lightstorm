import 'package:lsd/controller/controller.dart';
import 'package:lsd/helper/helper.dart';
import 'package:lsd/pin/pin_type.dart';

import 'mode_type.dart';

class Pin {
  static const int _MAX_FREQUENCY = 300;
  static const int _MAX_BRIGHTNESS = 100;

  // parameters
  final int pinNr;
  final PinType pinTyp;

  // state
  int frequency;
  int brightness;
  List<bool> states = List(ModeType.values.length);
  List<int> group;

  Pin(this.pinNr, this.pinTyp) {
    setBooleansOnList(states, false);
    frequency = 200;
    brightness = 100;
  }

  void setState(bool state) {
    states[getCurrentModeIndex()] = state;
    update();
  }

  void flipState() {
    states[getCurrentModeIndex()] =
        !states[getCurrentModeIndex()];
    update();
  }

  void update() {
    pinController.update(this);
  }

  int getFrequency() => frequency;

  int getBrightness() => brightness;

  void setFrequency(int frequency) {
    if (frequency > _MAX_FREQUENCY)
      this.frequency = _MAX_FREQUENCY;
    else
      this.frequency = frequency;
  }

  void setBrightness(int brightness) {
    if (frequency > _MAX_BRIGHTNESS)
      this.brightness = _MAX_BRIGHTNESS;
    else
      this.brightness = brightness;
  }

  void addGroup(int group) {
    if (!this.group.contains(group)) this.group.add(group);
  }

  void rmGroup(int group) {
    if (this.group.contains(group)) this.group.remove(group);
  }

  bool isGroup(int group) => this.group.contains(group);

  Pin.fromJson(Map<String, dynamic> json)
      : pinNr = json['pinNr'],
        pinTyp = json['pinTyp'],
        frequency = json['frequency'],
        brightness = json['brightness'],
        states = json['states'],
        group = json['group'];

  Map<String, dynamic> toJson() => {
        'pinNr': pinNr,
        'pinTyp': pinTyp,
        'frequency': frequency,
        'brightness': brightness,
        'states': states,
        'group': group,
      };
}
