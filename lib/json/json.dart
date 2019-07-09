class Pin {
  String name;
  List colors;

  Pin(this.name, this.colors);

  Pin.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        colors = json['colors'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'colors': colors,
      };
}

class Stripe {
  final String name;
  final List<Pin> pins;

  Stripe(this.name, this.pins);

  Stripe.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        pins = json['pins'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'pins': pins,
      };
}
