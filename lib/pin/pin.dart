import 'package:lsd/Controller/Controller.dart';
import 'package:lsd/pin/pin_type.dart';

import 'mode_type.dart';

class Pin {
  static final Controller controller = Controller();
  static const int _MAX_FREQUENCY = 300;
  static const int _MAX_BRIGHTNESS = 100;

  // parameters
  final int pinNr;
  final PinType pinTyp;

  // state
  int frequency;
  int brightness;
  ModeType mode;
  List<int> group;

  Pin(this.pinNr, this.pinTyp) {
    frequency = 200;
    brightness = 100;
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

  void update() {
    controller.update(this);
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
        mode = json['mode'],
        group = json['group'];

  Map<String, dynamic> toJson() => {
        'pinNr': pinNr,
        'pinTyp': pinTyp,
        'frequency': frequency,
        'brightness': brightness,
        'mode': mode,
        'group': group,
      };
}
