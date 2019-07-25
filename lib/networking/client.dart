import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_led_app/networking/request.dart';
import 'package:flutter_led_app/networking/response.dart';
import 'package:http/http.dart' as http;

class Client {
  HttpClient client = HttpClient();
  String address = "192.168.0.11";
  int port = 5000;
  String url;

  void getUpdate() async {
    client.getUrl(Uri.parse(url)).then((onValue) {
      print(onValue);
    });
    var response = await http.get(url);
  }

  Client(this.address, this.port) {
    url = "http://" + address + "/" + port.toString();
    getResponse();
  }

  Future<Response> sendRequest(Request request) async {
    var response = await http.post(url, body:request);
    print(response);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Response.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }


  Future<Response> getResponse() async {
    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Response.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

}