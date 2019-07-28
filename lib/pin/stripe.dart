import 'package:flutter_led_app/pin/pin.dart';

class Stripe {
  List<Pin> pins;
  String name;
  int id;

  Stripe(this.pins, this.name, this.id);

  Stripe.fromJson(Map<String, dynamic> json) {
    pins = [];
    name = json['name'];
    id = json['id'];
    for (var value in json['pins']) {
      pins.add(Pin.fromJson(value));
    }
  }

  Map<String, dynamic> toJson() => {
    'pins': pins,
    'name': name,
    'id': id,
  };

}