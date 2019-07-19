import 'dart:math';

import 'package:flutter_led_app/network/packet/request.dart';

import 'connection.dart';

Future<void> controlRefreshSession(Connection con) {
  var rnd = new Random();
  var req = Request("session_refresh", "", id: rnd.nextInt(pow(2, 32)));
  return con.request(req).then((res) {
    con.changePass(res.getData()[0]);
  });
}
