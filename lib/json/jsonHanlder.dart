import 'json.dart';

class JsonHandler {
  List<Stripe> stripes = List();

  JsonHandler() {
    for (int i = 0; i < 10; i++) {
      List<Pin> pins = new List();
      for (int p = 0; p < 10; p++) {
        List color = new List(3);
        color[0] = 0;
        color[1] = 0;
        color[2] = 255;

        pins.add(Pin(p.toString(), color));
      }
      //stripes.add(Stripe(i.toString(), pins[0]));
    }

    print(stripes[0].toJson());
  }
}
