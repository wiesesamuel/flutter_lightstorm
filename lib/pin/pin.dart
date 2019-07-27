import 'package:flutter_led_app/controller/controller.dart';
import 'package:flutter_led_app/helper/helper_models.dart';

import 'mode_type.dart';

class Pin {
  static const int _MAX_FREQUENCY = 300;
  static const int _MAX_BRIGHTNESS = 100;

  // parameters
  final int pin_nr;
  final int id;
  final String color;

  // state
  int frequency;
  int brightness;
  var states = List(ModeType.values.length);
  var group = [];

  Pin(this.pin_nr, this.id, this.color) {
    setBooleansOnList(states, false);
    frequency = 200;
    brightness = 100;
  }

  void setState(bool state) {
    states[getCurrentModeIndex()] = state;
    update();
  }

  void flipState() {
    states[getCurrentModeIndex()] = !states[getCurrentModeIndex()];
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

  bool updatePinValues(Pin pin) {
    if (id == pin.id) {
      frequency = pin.frequency;
      brightness = pin.brightness;
      states = pin.states;
      group = pin.group;
      return true;
    }
    return false;
  }

  Pin.fromJson(Map<String, dynamic> json)
      : pin_nr = json['pin_nr'],
        id = int.parse(json['id']),
        frequency = json['frequency'],
        brightness = json['brightness'],
        states = json['states'],
        group = json['group'],
        color = json['color'];

  Map<String, dynamic> toJson() => {
        'pin_nr': pin_nr,
        'id': id,
        'frequency': frequency,
        'brightness': brightness,
        'states': states.toString(),
        'group': group,
        'color': color,
      };
}
