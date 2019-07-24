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

    // response
    Future<Response> response;

    // get connection from pool
    _connectionPool.get().then((con) {

      // send request with connection and save incoming response
      response = con.request(Request(json, function)).whenComplete(() {

        // finished, free connection
        con.free();
      });
    }, onError: (e) {
      print(e);
    });


    // return response
    return response;
  }

  List<Stripe> getStripes() {
    //TODO FIX THIS MOTHERFUCKER
    // send server request to get stripes in use
    Future<Response> response = sendMessage("", "getStripes");
    //sleep(Duration(seconds: 3));
    // work with the actual response
    response.then((response){
      print(response.getData());

    });
    return null;
  }
}
