import 'dart:io';

import 'package:flutter_led_app/helper/helper_files.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Client {
  /*
  static SecurityContext clientContext = new SecurityContext()
    ..setTrustedCertificates(getLocalFile("cert.pem").toString());

  var client = new HttpClient(context: clientContext);

  void sendRequest(String Msg) async {
    var request = await client.getUrl(Uri.parse("https://example.com/"));
    var response = await request.close();
    print(response);
  }

  void clientmain() async {
    final channel = await IOWebSocketChannel.connect("ws://localhost:1234");
    channel.sink.add("Hallo");
    channel.stream.listen((message) {
      print(message);
      channel.sink.add("received!");
      channel.sink.close(status.goingAway);
    });
  }
*/
}
