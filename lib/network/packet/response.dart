import 'dart:convert';

import 'package:flutter_led_app/network/util/exceptions.dart';

class Response {

  String _json;
  int id;
  List _errors;
  List _data;

  Response.fromJson(String json) {
    this._json = json;
    var obj = jsonDecode(json);
    this.id = obj["id"];
    this._errors = obj["errors"];
    this._data = obj["data"];
  }

  void validate() {

    // check for errors
    if (_errors.length > 0) {
      // TODO: add all errors
      throw APIError(_errors[0].toString());
    }
  }

  List getData() {
    return _data;
  }

  String toJson() {
    return _json;
  }

}
