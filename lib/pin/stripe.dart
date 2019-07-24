import 'package:flutter_led_app/pin/pin.dart';

class Stripe {
  List<Pin> pins;
  String name;
  int id;

  Stripe(this.pins, this.name, this.id);

  Stripe.fromJson(Map<String, dynamic> json)
      : pins = json['pins'],
        name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'pins': pins,
    'name': name,
    'id': id,
  };

}