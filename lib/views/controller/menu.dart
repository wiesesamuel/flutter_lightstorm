part of views;

class BrightnessSlider extends Slider {
  BrightnessSlider({
    value = 100,
    @required callback,}
  ) : super(value: value, onChanged: callback, min: 0, max: 100, label: "Brg");
}
class FrequenceSlider extends Slider {
  FrequenceSlider({
    value = 200,
      @required callback,}
      ) : super(value: value, onChanged: callback, min: 0, max: 100, label: "Frq");
}