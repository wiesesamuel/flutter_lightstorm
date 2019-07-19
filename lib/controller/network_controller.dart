import 'package:flutter_led_app/network/connection/pool.dart';
import 'package:flutter_led_app/network/packet/request.dart';

class NetworkController {
  String host = "192.168.0.11";
  int port = 5000;
  String passphrase = "debug";

  ConnectionPool _connectionPool = ConnectionPool();

  NetworkController() {
    connect();
  }

  NetworkController.connected(this.host, this.port, this.passphrase) {
    connect();
  }

  void connect() {
    _connectionPool.changeServer(host, port, passphrase);
  }

  void disconnect() {
    _connectionPool.disconnect();
  }

  void sendMessage(String json, String function) {
    print(json);
    connect();
    _connectionPool.get().then((con) {
      con.request(Request(json, function)).whenComplete(() {
        con.free();
      });
      return con;
    }, onError: (e) {
      print(e);
    });
  }
}
