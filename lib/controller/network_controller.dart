import 'dart:io';

import 'package:flutter_led_app/network/connection/pool.dart';
import 'package:flutter_led_app/network/packet/request.dart';
import 'package:flutter_led_app/network/packet/response.dart';
import 'package:flutter_led_app/pin/stripe.dart';
import 'package:http/http.dart' as http;

class NetworkController {
  String host = "192.168.0.11";
  int port = 5000;
  String passphrase = "";

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

  Future<Response> sendMessage(String json, String function) {
    // connect to server
    connect();

    // get connection from pool
    return _connectionPool.get().then((con) {
      // send request with connection and save incoming response
      Response response = con.request(Request(json, function));
      con.free();
      return response;
    }, onError: (e) {
      print(e);
    });

  }

  List<Stripe> getStripes() {
    //TODO FIX THIS MOTHERFUCKER
    // send server request to get stripes in use
    //sleep(Duration(seconds: 3));
    // work with the actual response
    sendMessage("", "getStripes").then((response){
      print("mtf");
      print(response);

    });
    return null;
  }
}
