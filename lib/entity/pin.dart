import './entity.dart';

class Pin extends Entity {
  static const int _MAX_FREQUENCY = 300;
  static const int _MAX_BRIGHTNESS = 100;

  final int pinNr;
  int frequency;
  int brightness;

  Pin(this.pinNr) {
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
}