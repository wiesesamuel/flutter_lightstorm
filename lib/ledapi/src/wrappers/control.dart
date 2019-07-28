part of ledapi;

Future<void> controlRefreshSession(Connection con) {
  var rnd = new Random();
  var req = Request("control", "session_refresh", id: rnd.nextInt(pow(2, 32)));
  return con.request(req).then((res) {
    con.changePass(res.getData()[0]);
  });
}

Future<void> updatePin(Connection con, Pin pin) {
  var rnd = new Random();
  var req = Request("led", "setPin", id: rnd.nextInt(pow(2, 32)));
  req.addParam(pin.toJson());
  return con.request(req).then((res) {
    return res;
  });
}

Future<Response> getStripes(Connection con) {
  var rnd = new Random();
  var req = Request("led", "getStripes", id: rnd.nextInt(pow(2, 32)));
  return con.request(req).then((res) {
    return res;
  });
}
