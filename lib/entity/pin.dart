import './entity.dart';
import 'package:lsd/Controller/Controller.dart';
import 'package:lsd/entity/pin_type.dart';

class Pin extends Entity {
  static final Controller controller = new Controller();
  static const int _MAX_FREQUENCY = 300;
  static const int _MAX_BRIGHTNESS = 100;

  final int pinNr;
  final PinType pinTyp;
  int frequency;
  int brightness;

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
}